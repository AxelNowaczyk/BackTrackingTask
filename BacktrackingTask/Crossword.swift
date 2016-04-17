//
//  Crossword.swift
//  BacktrackingTask
//
//  Created by Axel Nowaczyk on 04.04.2016.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import Foundation

enum Orientation {
    case Horizontal
    case Vertical
}

class CrosswordWord {
    let word: Word
    let startPoint: (Int, Int)
    let orientation: Orientation

    init(word: Word, startPoint: (Int, Int), orientation: Orientation){
        self.word       = word
        self.startPoint = startPoint
        self.orientation = orientation
    }
    func checkIfCollisionOcc(with cWord: CrosswordWord) -> Bool {

        guard cWord.orientation != orientation else {
            return false
        }

        for sIndex in 0..<word.length {
            for cIndex in 0..<cWord.word.length{
                switch orientation {
                case .Horizontal:
                    let s_x = startPoint.0 + sIndex
                    let s_y = startPoint.1
                    let c_x = cWord.startPoint.0
                    let c_y = cWord.startPoint.1 + cIndex
                    
                    if s_x == c_x && s_y == c_y {
                        if  word.word[word.word.startIndex.advancedBy(sIndex)] ==
                        cWord.word.word[cWord.word.word.startIndex.advancedBy(cIndex)] {
                            return true
                        } else {
                            return false
                        }
                    }

                case .Vertical:
                    let s_x = startPoint.0
                    let s_y = startPoint.1 + sIndex
                    let c_x = cWord.startPoint.0 + cIndex
                    let c_y = cWord.startPoint.1
                    
                    if s_x == c_x && s_y == c_y {
                        if  word.word[word.word.startIndex.advancedBy(sIndex)] ==
                            cWord.word.word[cWord.word.word.startIndex.advancedBy(cIndex)] {
                            return true
                        } else {
                            return false
                        }
                    }

                }
            }
        }
        return true
    }
}

class Crossword {
//    let vocabulary = Vocabulary()
    func start() {
        crossword([CrosswordWord]())
    }
    private func crossword(crossword: [CrosswordWord]?) -> [CrosswordWord]? {
        guard crossword != nil else {
            return nil
        }
        
        guard crossword!.count < Data.numberOfWords else {
            return crossword
        }
        return self.crossword(getNextState(crossword!))
    }
    private func getNextState(crossword: [CrosswordWord]) -> [CrosswordWord]? {
//        if crossword.count == 0 {
//            crossword.append(CrosswordWord)
//            return
//        }
//        let lastWord = crossword[crossword.count-1]
        return crossword
    }
    func findPlaceForWord(word: Word, crossword: [CrosswordWord]) -> (Orientation,(Int, Int))? {
        
        guard crossword.count > 0 else {
            return (Orientation.Horizontal,(0,0))
        }
        
        for cword in crossword {
            let possibilities = findPossibleStarts(word, crosswordWord: cword)
            let place = givePlace(possibilities,crossword: crossword)
            
            if place != nil {
                return place
            }
        }
        
        return nil
    }
    // find places where the new word can start
    func findPossibleStarts(word: Word, crosswordWord: CrosswordWord) -> [(Orientation,(Int, Int),Word)]{
        var possibleStarts = [(Orientation,(Int, Int),Word)]()
        let word1 = word.word
        let word2 = crosswordWord.word.word
        
        for w2Index in word2.characters.startIndex..<word2.characters.endIndex{
            for w1Index in word1.characters.startIndex..<word1.characters.endIndex{
                if word1[w1Index] == word2[w2Index] {
                    
                    let x = crosswordWord.startPoint.0
                    let y = crosswordWord.startPoint.1
                    
                    switch crosswordWord.orientation {
                    case .Horizontal:
                        possibleStarts.append((Orientation.Vertical,(x+Int("\(w2Index)")!,y-Int("\(w1Index)")!),word))
                    case .Vertical:
                        possibleStarts.append((Orientation.Horizontal,(x-Int("\(w1Index)")!,y+Int("\(w2Index)")!),word))
                    }
                }
            }
        }
        return possibleStarts
    }
    private func givePlace(possibilities: [(Orientation,(Int, Int),Word)], crossword: [CrosswordWord]) -> (Orientation,(Int, Int))? {
        for poss in possibilities {
            if checkIfInBoard(poss) == true && checkIfNoCollisions(poss,crossword: crossword) == true {
                return (poss.0, poss.1)
            }
        }
        return nil
    }
    /*
        this 2 methods below checks if it possible to put this point on the board
     */
    private func checkIfInBoard(possibility: (Orientation,(Int, Int), Word)) -> Bool{
        switch possibility.0 {
        case Orientation.Horizontal:
            if  possibility.1.0 < 0 || (possibility.1.0 + possibility.2.length) > Data.width ||     // check x's
                possibility.1.1 < 0 || possibility.1.1 > Data.height {                              // check y's
                    return false
            }
        case Orientation.Vertical:
            if  possibility.1.1 < 0 || (possibility.1.1 + possibility.2.length) > Data.height ||    // check y's
                possibility.1.0 < 0 || possibility.1.0 > Data.width {                               // check x's
                    return false
            }
        }
        return true
    }
    private func checkIfNoCollisions(possibility: (Orientation,(Int, Int), Word), crossword: [CrosswordWord]) -> Bool{
        let possWord = CrosswordWord(word: possibility.2, startPoint: possibility.1, orientation: possibility.0)
        for cword in crossword {
            if cword.checkIfCollisionOcc(with: possWord) == false {
                return false
            }
        }
        return true
    }
}



