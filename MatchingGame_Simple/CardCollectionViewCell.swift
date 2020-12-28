//
//  CardCollectionViewCell.swift
//  MatchingGame_Simple
//
//  Created by Ozzy on 28.12.2020.
//  Copyright © 2020 Taras Motruk. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
      var card:Card?
    
    func setCard(_ card:Card) {
        
        self.card = card
        
        if card.isMatched == true{
            backImageView.alpha = 0
            frontImageView.alpha = 0
            
             return
        }
        else {
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
        
        frontImageView.image = UIImage(named: card.imageName)
        if card.isFlipped == true {
         
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
        else {
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            
        }
    }
    
    #warning("add funks to flip, flip back and remove cards")
    
}
