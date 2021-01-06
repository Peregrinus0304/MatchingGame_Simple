//
//  ViewController.swift
//  MatchingGame_Simple
//
//  Created by Ozzy on 27.12.2020.
//  Copyright © 2020 Taras Motruk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    
    private var model = CardModel()
    private var cardArray = [Card]()
    private var timer:Timer?
    private var milliseconds:Float = 60 * 1000
    private var firstFlippedCardIndex:IndexPath?
    let sectionInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardArray =  model.getCards()
        collectionView.delegate = self
        collectionView.dataSource = self
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(TimerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode:  .common)
    }
    
}

//MARK: Fileprivate extension

fileprivate extension ViewController {
    
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
    
    func checkForMathces (_ secondFlippedCardIndex:IndexPath) {
        
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
        var title = ""
        var massage = ""
        
        for card in cardArray {
            if card.isMatched == false {
                isWon = false
                break
            }
        }
        
        if isWon == true {
            if milliseconds > 0 {
                timer?.invalidate()
            }
            title = "flawless victory!"
            massage = ""
        } else {
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
        cell.layer.cornerRadius = 30
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
        
        if !card.isFlipped  && !card.isMatched {
            cell.flip(card)
            
            #warning("flip sound")
            
            
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
                
            }
            else {
                checkForMathces(indexPath)
            }
        }
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemPerRow:CGFloat = 3
        let minimumSpace: CGFloat = 10
        let itemSize: CGSize
        let paddingSpace = sectionInsets.left + sectionInsets.right + minimumSpace * (itemPerRow - 1 )
        let width = collectionView.bounds.width - paddingSpace
        let widthPerItem = width / itemPerRow
        itemSize = CGSize(width: widthPerItem, height: widthPerItem)
        
        return itemSize
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return  sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 
    }
    
}
