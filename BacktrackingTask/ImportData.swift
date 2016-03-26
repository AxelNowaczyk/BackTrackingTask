//
//  ImportData.swift
//  BacktrackingTask
//
//  Created by Axel Nowaczyk on 26.03.2016.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import Foundation

func importData(){
    let URLString = "https://www.kilgarriff.co.uk/BNClists/lemma.al"
    guard let myURL = NSURL(string: URLString) else {
        print("Error: \(URLString) ")
        return
    }
    
    do {
        let HTMLString = try String(contentsOfURL: myURL)
        print("\(HTMLString)") 
    } catch let error as NSError {
        print("Error: \(error)")
    }
    print("importing data")
}
