//
//  CardModel.swift
//  MatchingGame_Simple
//
//  Created by Ozzy on 28.12.2020.
//  Copyright © 2020 Taras Motruk. All rights reserved.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        
        // declare an array for generated cards
        var generatedCardArray = [Card]()
        
        var generatedNumbersArray = [Int]()
        
        // randomly generate the pair of cards
        while generatedCardArray.count < 16 {
            
            let randomNumber = arc4random_uniform(13)+1
            
            if generatedNumbersArray.contains(Int(randomNumber)) == false {
                
                // printing generated values
                print(randomNumber)
                
                generatedNumbersArray.append(Int(randomNumber))
                
                // create the first card object
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
                
                // add the first card to array of cards
                generatedCardArray.append(cardOne)
                
                // create the second card object
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
                
                // add the second card to array of cards
                generatedCardArray.append(cardTwo)
            }
        }
        
        for i in 0...generatedCardArray.count-1 {
            let randomNumber = Int(arc4random_uniform(UInt32(generatedCardArray.count)))
            
            let temporaryStorage = generatedCardArray[i]
            generatedCardArray[i] = generatedCardArray[randomNumber]
            generatedCardArray[randomNumber] = temporaryStorage
        }
        
        return generatedCardArray
    }
    
}
