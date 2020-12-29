//
//  ViewController.swift
//  MatchingGame_Simple
//
//  Created by Ozzy on 27.12.2020.
//  Copyright © 2020 Taras Motruk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    
    var cardArray = [Card]()
    var model = CardModel()
    var timer:Timer?
    var milliseconds:Float = 60 * 1000
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardArray =  model.getCards()
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(TimerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode:  .common)
    }
    
    @objc func TimerElapsed () {
        milliseconds -= 1
        let seconds = String(format: "%.2f", milliseconds/1000)
        timerLabel.text = "Час до анального покарання: \(seconds)"
        if milliseconds <= 0 {
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            #warning("check if game ended")
        }
    }
    
}

// MARK: - Extension UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
        
        let card = cardArray [indexPath.row]
        cell.setCard(card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if milliseconds <= 0 {
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
            cell.flip()
            
            #warning("flip sound")
            
            card.isFlipped = true
            
            #warning("check for matches")
            
        }
    }
    
}
