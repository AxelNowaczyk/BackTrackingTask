//
//  ImportData.swift
//  BacktrackingTask
//
//  Created by Axel Nowaczyk on 26.03.2016.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import Foundation


class Vocabulary: CustomStringConvertible {
    var words: [Word]?
    
    init(){
        if words == nil{
            words = [Word]()
            importData()
        }
    }
    private func importData(){
        let URLString = "https://www.kilgarriff.co.uk/BNClists/lemma.al"
        guard let myURL = NSURL(string: URLString) else {
            print("Error: \(URLString) ")
            return
        }
        
        do {
            let HTMLString = try String(contentsOfURL: myURL)
            let devideOnRows = HTMLString.characters.split{$0 == "\n"}.map(String.init)
            for i in devideOnRows{
                let divOnCol = i.characters.split{ $0 == " " }.map(String.init)
                if divOnCol[3] == "n" || divOnCol[3] == "adv" || divOnCol[3] == "a" || divOnCol[3] == "v"{
                    words!.append(Word(word: divOnCol[2],occ: Int(divOnCol[1])!,kind: Kind.getKind(divOnCol[3])!))
                }
            }
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
    var description: String{
        var returnString = ""
        if let wordsUW = words{
            for word in wordsUW{
                returnString+=word.description+"\n"
            }
        }
        return returnString
    }
}
class Word: CustomStringConvertible {
    let word: String
    let occ: Int
    let kind: Kind
    
    init(word: String, occ: Int, kind:Kind){
        self.word = word
        self.occ = occ
        self.kind = kind
    }
    var description: String{
        return "\(word) \(occ) \(kind)"
    }
}
enum Kind: String {
    case ADV
    case A
    case N
    case V
    var description: String{
        switch self {
        case ADV:
            return Kind.ADV.rawValue.lowercaseString
        case A:
            return Kind.A.rawValue.lowercaseString
        case N:
            return Kind.N.rawValue.lowercaseString
        case V:
            return Kind.V.rawValue.lowercaseString

        }
    }
    static func getKind(string: String) -> Kind?{
        switch string.lowercaseString {
        case Kind.ADV.rawValue.lowercaseString:
            return Kind.ADV
        case Kind.A.rawValue.lowercaseString:
            return Kind.A
        case Kind.N.rawValue.lowercaseString:
            return Kind.N
        case Kind.V.rawValue.lowercaseString:
            return Kind.V
        default:
            return nil
        }
    }
}
