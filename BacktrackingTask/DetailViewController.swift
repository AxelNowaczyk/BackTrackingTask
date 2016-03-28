//
//  DetailViewController.swift
//  BacktrackingTask
//
//  Created by Axel Nowaczyk on 28.03.2016.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import UIKit

struct Data{
    static var height: Int          = 20
    static var width: Int           = 10
    static var numberOfWords: Int   = 30
    
    static let heightDefault: Int           = 20
    static let widthDefault: Int            = 10
    static let numberOfWordsDefault: Int    = 30
}
class DetailViewController: UIViewController {

    @IBOutlet var gameView: UIView!
    static let vocabulary = Vocabulary()// dis from main queue
    
    override func viewDidLoad() {
        print("\(Data.height) \(Data.width)")
    }
}
