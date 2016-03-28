//
//  MasterViewController.swift
//  BacktrackingTask
//
//  Created by Axel Nowaczyk on 28.03.2016.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var widhtTextField: UITextField!
    @IBOutlet var numberOfWordsTextField: UITextField!
    @IBOutlet var playWithItButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playWithItButton.backgroundColor    = UIColor.greenColor()
        playWithItButton.layer.cornerRadius = 10
        
        setHWN()
        
    }
    private func updateData(){
        let newHeight           = Int(heightTextField.text!) ?? Data.heightDefault
        let newWidht            = Int(widhtTextField.text!) ?? Data.widthDefault
        let newNumberOfWords    = Int(numberOfWordsTextField.text!) ?? Data.numberOfWordsDefault
        
//        check range
        
        Data.height         = newHeight
        Data.width          = newWidht
        Data.numberOfWords  = newNumberOfWords
        
        setHWN()
    }
    private func setHWN(){
        heightTextField.text        = "\(Data.height)"
        widhtTextField.text         = "\(Data.width)"
        numberOfWordsTextField.text = "\(Data.numberOfWords)"
    }
    private struct Seques{
        static let PlayWithIt = "Play With It"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier{
            switch identifier{
                
            case Seques.PlayWithIt:
                updateData()
//                if let vc = segue.destinationViewController as? DetailViewController{
//                
//                }
            default: break
            }
        }

    }
}
