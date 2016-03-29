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
    
    static let navControllerHeight: CGFloat = CGFloat(10)
}
class DetailViewController: UIViewController {

    @IBOutlet var gameView: UIView!
    
    static let vocabulary = Vocabulary()// dis from main queue
    var cells = [UIView]()
    
    var cellSize: CGSize{
        let width   = gameView.bounds.size.width / CGFloat(Data.width)
        let height  = gameView.bounds.size.height / CGFloat(Data.height)
        return CGSize(width: width, height: height)
    }
    
    override func viewDidLoad() {

        createCells()
    }
    @IBAction func tapGesture(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    private func createCells(){
        for width in 0..<Data.width{
            for height in 0..<Data.height{
                let frame = CGRect(origin: CGPoint(x: CGFloat(width)*cellSize.width, y: CGFloat(height)*cellSize.height),size: cellSize)
                
                let cellView = UIView(frame: frame)
                cellView.backgroundColor = UIColor.randomColor
                
                gameView.addSubview(cellView)
                cells.append(cellView)
            }
        }
    }
}
private extension UIColor{
    class var randomColor: UIColor{
        switch arc4random()%7{
        case 0: return UIColor.redColor()
        case 1: return UIColor.blueColor()
        case 2: return UIColor.brownColor()
        case 3: return UIColor.blackColor()
        case 4: return UIColor.greenColor()
        case 5: return UIColor.purpleColor()
        case 6: return UIColor.yellowColor()
        default: return UIColor.grayColor()
            
        }
    }
}
