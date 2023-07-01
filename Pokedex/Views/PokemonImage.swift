//
//  PokemonImage.swift
//  Pokedex
//
//  Created by Büşra Kocakuşaklı on 1.07.2023.
//

import SwiftUI

struct PokemonImage: View {
    var imageLink = ""
    @State private var pokemonSprite = ""
    
    var body: some View {
        AsyncImage(url: URL(string: pokemonSprite))
            .frame(width: 75, height: 75)
            .onAppear {
                let loededData = UserDefaults.standard.string(forKey: imageLink)
                
                if loededData == nil {
                    getSprite(url: imageLink)
                    UserDefaults.standard.set(imageLink, forKey: imageLink)
                    print("New url")
                } else {
                    getSprite(url: loededData!)
                    print(" Using cached url..")
                }
            }
            .clipShape(Circle())
            .foregroundColor(Color.gray.opacity(0.60))
                   
    }
    func getSprite(url: String) {
        var tempSprite: String?
        
        PokemonSelectedApi().getSprite(url: url) { sprite in
            tempSprite = sprite.front_default
            self.pokemonSprite = tempSprite ?? "placeholder"
        }
    }
}

struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage()
    }
}
