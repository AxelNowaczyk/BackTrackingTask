//
//  BacktrackingTaskTests.swift
//  BacktrackingTaskTests
//
//  Created by Axel Nowaczyk on 18.04.2016.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import XCTest
@testable import BacktrackingTask

class BacktrackingTaskTests: XCTestCase {
    /*
    let cw = Crossword()
    var cwwT = [CrosswordWord]()
    
    override func setUp() {
        let word = Word(word: "example", kind: Kind.N)
        let cww = CrosswordWord(word: word, startPoint: (0,0), orientation: Orientation.Horizontal)
        let cww2 = CrosswordWord(word: word, startPoint: (0,0), orientation: Orientation.Vertical)
        let word2 = Word(word: "amanda", kind: Kind.N)
        let cww3 = CrosswordWord(word: word2, startPoint: (0,2), orientation: Orientation.Horizontal)
        cwwT.append(cww)
        cwwT.append(cww2)
        cwwT.append(cww3)
    }
    
    func testCheckIfCollisionOcc_thesameOrientation(){
        let word = Word(word: "example", kind: Kind.N)
        let cww = CrosswordWord(word: word, startPoint: (0,0), orientation: Orientation.Horizontal)
        let word2 = Word(word: "example", kind: Kind.N)
        let cww2 = CrosswordWord(word: word2, startPoint: (0,0), orientation: Orientation.Horizontal)
        XCTAssert(cww.checkConstraints(with: cww2) == false)
    }
    
    func testCheckIfCollisionOcc_DiffOrientOkCrossing(){
        let word = Word(word: "example", kind: Kind.N)
        let cww = CrosswordWord(word: word, startPoint: (0,0), orientation: Orientation.Horizontal)
        let word2 = Word(word: "example", kind: Kind.N)
        let cww2 = CrosswordWord(word: word2, startPoint: (0,0), orientation: Orientation.Vertical)
        XCTAssert(cww.checkConstraints(with: cww2))
    }
    func testCheckIfCollisionOcc_DiffOrientBadCrossing(){
        let word = Word(word: "example", kind: Kind.N)
        let cww = CrosswordWord(word: word, startPoint: (0,0), orientation: Orientation.Horizontal)
        let word2 = Word(word: "example", kind: Kind.N)
        let cww2 = CrosswordWord(word: word2, startPoint: (2,0), orientation: Orientation.Vertical)
        XCTAssert(cww.checkConstraints(with: cww2) == false)
    }
    func testCheckIfCollisionOcc_thesameOrientationNoCrossing(){
        let word = Word(word: "example", kind: Kind.N)
        let cww = CrosswordWord(word: word, startPoint: (0,0), orientation: Orientation.Horizontal)
        let word2 = Word(word: "example", kind: Kind.N)
        let cww2 = CrosswordWord(word: word2, startPoint: (0,2), orientation: Orientation.Horizontal)
        XCTAssert(cww.checkConstraints(with: cww2))
    }
    func testCheckIfCollisionOcc_diffOrientationNoCrossing(){
        let word = Word(word: "example", kind: Kind.N)
        let cww = CrosswordWord(word: word, startPoint: (0,0), orientation: Orientation.Horizontal)
        let word2 = Word(word: "example", kind: Kind.N)
        let cww2 = CrosswordWord(word: word2, startPoint: (2,2), orientation: Orientation.Vertical)
        XCTAssert(cww.checkConstraints(with: cww2))
    }
    
    func testIfNoCollisions_OkWith2Words() {
        let word = Word(word: "adam", kind: Kind.N)
        XCTAssert(cw.checkIfNoCollisions((Orientation.Vertical, (2, 0), word), crossword: cwwT))
    }
    func testIfNoCollisions_WrognWith2Words() {
        let word = Word(word: "adam", kind: Kind.N)
        XCTAssert(cw.checkIfNoCollisions((Orientation.Vertical, (1, 0), word), crossword: cwwT) == false)
    }
    func testIfNoCollisions_OkWith1WordWrongWithSecondOne() {
        let word = Word(word: "memphis", kind: Kind.N)
        XCTAssert(cw.checkIfNoCollisions((Orientation.Vertical, (3, 0), word), crossword: cwwT) == false)
    }
    
    func testIfInBoard_HorizontalLeft(){
        let word = Word(word: "example", kind: Kind.N)
        cw.checkIfInBoard((Orientation.Horizontal,(-1, 0), word))
    }
    
    func testIfInBoard_HorizontalRight(){
        let word = Word(word: "example", kind: Kind.N)
        cw.checkIfInBoard((Orientation.Horizontal,(Data.width, 0), word))
    }
    func testIfInBoard_VerticalTop(){
        let word = Word(word: "example", kind: Kind.N)
        cw.checkIfInBoard((Orientation.Vertical,(0, -1), word))
    }
    func testIfInBoard_VerticalBottom(){
        let word = Word(word: "example", kind: Kind.N)
        cw.checkIfInBoard((Orientation.Vertical,(0, Data.height), word))
    }*/
    
}
