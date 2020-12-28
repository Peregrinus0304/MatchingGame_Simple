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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

}

    // MARK: - Extension UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
