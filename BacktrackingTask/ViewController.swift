//
//  ViewController.swift
//  BacktrackingTask
//
//  Created by Axel Nowaczyk on 26.03.2016.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // user defines progrm parameters size of the board(n x m), number of words to be used
    // present most interesting results

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let voc = Vocabulary()
        print(voc.words!.description)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

