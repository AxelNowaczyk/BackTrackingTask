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

class CrosswordWord: CustomStringConvertible {
    let word: Word
    let startPoint: (Int, Int)
    let orientation: Orientation

    init(word: Word, startPoint: (Int, Int), orientation: Orientation){
        self.word       = word
        self.startPoint = startPoint
        self.orientation = orientation
    }
    func checkConstraints(with cWord: CrosswordWord) -> Bool {
        guard checkIfCanBeNextTo(word: cWord) else {
            return false
        }
        
        for sIndex in 0..<word.length {
            for cIndex in 0..<cWord.word.length{
                
                var s_x = startPoint.0
                var s_y = startPoint.1
                var c_x = cWord.startPoint.0
                var c_y = cWord.startPoint.1
                
                switch (orientation,cWord.orientation) {
                case (.Horizontal, .Horizontal):
                    s_x += sIndex
                    c_x += cIndex
                case (.Horizontal, .Vertical):
                    s_x += sIndex
                    c_y += cIndex
                case (.Vertical, .Horizontal):
                    s_y += sIndex
                    c_x += cIndex
                case (.Vertical, .Vertical):
                    s_y += sIndex
                    c_y += cIndex
                }
                    
                guard s_x == c_x && s_y == c_y else {
                    continue
                }
                
                guard cWord.orientation != orientation else {
                    return false
                }
                    
                guard word.word[word.word.startIndex.advancedBy(sIndex)] ==
                    cWord.word.word[cWord.word.word.startIndex.advancedBy(cIndex)] else {
                        return false
                }
                return true
            }
        }
        return true
    }
    private func checkIfCanBeNextTo(word cWord: CrosswordWord) -> Bool {
        for sIndex in 0..<word.length {
            for cIndex in 0..<cWord.word.length{
                
                var s_x = startPoint.0
                var s_y = startPoint.1
                var c_x = cWord.startPoint.0
                var c_y = cWord.startPoint.1
                
                switch (orientation,cWord.orientation) {
                case (.Horizontal, .Horizontal):
                    s_x += sIndex
                    c_x += cIndex
                case (.Horizontal, .Vertical):
                    s_x += sIndex
                    c_y += cIndex
                case (.Vertical, .Horizontal):
                    s_y += sIndex
                    c_x += cIndex
                case (.Vertical, .Vertical):
                    s_y += sIndex
                    c_y += cIndex
                }
                switch orientation {
                case .Horizontal:
                    if s_y == c_y && (startPoint.0-1 == c_x ||
                                    startPoint.0+word.length+1 == c_x) {
                        return false
                    }
                    switch cWord.orientation {
                    case .Horizontal:
                        if s_x == c_x && (s_y-1 == c_y || s_y+1 == c_y) {
                            return false
                        }
                    case .Vertical:
                        if s_x == c_x && (  s_y-1 == cWord.startPoint.1+cWord.word.length ||
                                            s_y+1 == cWord.startPoint.1) {
                            return false
                        }
                    }
                case .Vertical:
                    if s_x == c_x && (startPoint.1-1 == c_y ||
                                    startPoint.1+word.length+1 == c_y) {
                        return false
                    }
                    switch cWord.orientation {
                    case .Horizontal:
                        if s_y == c_y && (  s_x-1 == cWord.startPoint.0+cWord.word.length ||
                                            s_x+1 == cWord.startPoint.0) {
                            return false
                        }
                    case .Vertical:
                        if s_y == c_y && (s_x-1 == c_x || s_x+1 == c_x) {
                            return false
                        }
                    }
                }
            }
        }
        return true

    }
    var description: String{
        return "\(word) \(startPoint) \(orientation) \n"
    }
}

class Crossword {
    private let vocabulary = Vocabulary()
    private var lastWord: Word?
    func start() {
        lastWord = Word(word: "",kind: Kind.N)
        crossword([CrosswordWord]())
    }
    private func crossword(crossword: [CrosswordWord]?) -> [CrosswordWord]? {
        // when there is no results
        guard let crossword = crossword else {
            return nil
        }
        
        guard crossword.count < Data.numberOfWords else {
            print(crossword)
            return crossword
        }
        let nextWord = getNextWord()
        guard let nextWordUW = nextWord else {
            return nil
        }
        
        let places = findPlacesForWord(nextWordUW, crossword: crossword)
        guard places.count > 0 else {
            return self.crossword(crossword)
        }
        for place in places {
            let nextCw = crossword + [CrosswordWord(word: nextWordUW, startPoint: place.1, orientation: place.0)]
            self.crossword(nextCw)
        }
        return nil
    }
    private func getNextWord() -> Word? {
        guard let lastWord = lastWord else{
            return nil
        }
        if lastWord.word == "" {
            self.lastWord = vocabulary.getFirst
        } else {
            self.lastWord = vocabulary.getNextWord(lastWord)
        }
        return self.lastWord
    }
    private func findPlacesForWord(word: Word, crossword: [CrosswordWord]) -> [(Orientation,(Int, Int))] {
        
        var places = [(Orientation,(Int, Int))]()
        guard crossword.count > 0 else {
            return giveAllPossForFirst(word)
        }
        
        for cword in crossword {
            let possibilities = findPossibleStarts(word, crosswordWord: cword)
            places += givePlaces(possibilities,crossword: crossword)
        }
        
        return places
    }
    private func giveAllPossForFirst(word: Word) -> [(Orientation,(Int, Int))] {
        var possies = [(Orientation,(Int, Int))]()
        for x in 0..<Data.width{
            for y in 0..<Data.height{
                if Data.width > x + word.length{
                    possies.append((Orientation.Horizontal,(x,y)))
                }
                if Data.height > y + word.length{
                    possies.append((Orientation.Vertical,(x,y)))
                }
            }
        }
        return possies
    }
    // find places where the new word can start
    private func findPossibleStarts(word: Word, crosswordWord: CrosswordWord) -> [(Orientation,(Int, Int),Word)]{
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
    private func givePlaces(possibilities: [(Orientation,(Int, Int),Word)], crossword: [CrosswordWord]) -> [(Orientation,(Int, Int))] {
        var places = [(Orientation,(Int, Int))]()
        for poss in possibilities {
            if checkIfInBoard(poss) == true && checkIfNoCollisions(poss,crossword: crossword) == true {
                places.append((poss.0, poss.1))
            }
        }
        return places
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
            guard cword.checkConstraints(with: possWord) else {
                return false
            }
        }
        return true
    }
}



