//
//  Vocabulary.swift
//  BacktrackingTask
//
//  Created by Axel Nowaczyk on 26.03.2016.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import Foundation


class Vocabulary: CustomStringConvertible {
    /*
        words - dictionary that have the length of the word as first part and
                array of words as the second (the array is ordered with the use of
                score of the words)
     */
    var words: [Int:[Word]]?
    
    init(){
        if words == nil{
            words = [Int:[Word]]()
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
                
                let kind = Kind.getKind(divOnCol[3])
                let word = divOnCol[2]
                if let wantedKind = kind{
                    if words![word.characters.count] == nil{
                        words![word.characters.count] = [Word]()
                    }
                    words![word.characters.count]!.append(Word(word: word,kind: wantedKind))
                }
            }
            for (len,_) in words!{
                words![len]?.sortInPlace()
            }

        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
    var description: String{
        var returnString = ""
        if let wordsUW = words{
            for (length,words) in wordsUW{
                returnString+="\(length)\n"
                for word in words{
                    returnString+="\(word), "
                }

            }
        }
        return returnString
    }
}
class Word: CustomStringConvertible, Comparable {
    let word: String
    let kind: Kind
    
    var score: Int{
        var sum = 0
        for char in word.characters{
            sum += getScoreOfLetter(char) ?? 0
        }
        return sum
    }
    private func getScoreOfLetter(letter: Character) -> Int?{
        /*
            Score from scrabble
         */
        switch letter {
        case "q","z":
            return 10
        case "j","x":
            return 8
        case "k":
            return 5
        case "f","h","v","w","y":
            return 4
        case "b","c","m","p":
            return 3
        case "d","g":
            return 2
        case "e","a","i","o","n","r","t","l","s","u":
            return 1
        default:
            return nil
        }
    }
    init(word: String, kind:Kind){
        self.word = word
        self.kind = kind
    }
    var description: String{
        return "\(word) \(score) \(kind) \n"
    }
}
/// the best are at the beggining
func < (lhs: Word, rhs: Word) -> Bool {
    return lhs.score > rhs.score
}

func == (lhs: Word, rhs: Word) -> Bool {
    return lhs.score == rhs.score
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
