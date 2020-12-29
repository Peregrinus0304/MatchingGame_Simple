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
    
    var model = CardModel()
    var cardArray = [Card]()
    var timer:Timer?
    var milliseconds:Float = 60 * 1000
    var firstFlippedCardIndex:IndexPath?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardArray =  model.getCards()
        collectionView.delegate = self
        collectionView.dataSource = self
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(TimerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode:  .common)
    }
    
    @objc func TimerElapsed() {
        milliseconds -= 1
        let seconds = String(format: "%.2f", milliseconds/1000)
        timerLabel.text = "Time left: \(seconds)"
        if milliseconds <= 0 {
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            CheckGameEnded()
        }
    }
    
    func checkForMathces (_ secondFlippedCardIndex:IndexPath)
    {
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        let cardOne = cardArray [firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        if cardOne.imageName == cardTwo.imageName {
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            CheckGameEnded()
        }
        else {
            
            #warning("nomatch sound")
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        firstFlippedCardIndex = nil
    }
    
    func CheckGameEnded() {
        
        var isWon = true
        
        for card in cardArray {
            if card.isMatched == false {
                isWon = false
                break
            }
        }
        
        var title = ""
        var massage = ""
        
        if isWon == true {
            if milliseconds > 0 {
                timer?.invalidate()
            }
            title = "flawless victory!"
            massage = ""
        }
        else {
            if milliseconds > 0 {
                return
            }
            title = "You lose!"
            massage = ""
        }
        showAlert(title, massage)
    }
    
    func showAlert(_ title:String, _ massage:String){
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - Extension UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
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
            
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
                
            }
            else {
                
                checkForMathces(indexPath)
            }
        }
    }
    
}
