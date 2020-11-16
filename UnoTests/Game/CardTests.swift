//
//  CardTests.swift
//  UnoTests
//
//  Created by Thibault Klein on 10/17/20.
//

import XCTest
@testable import Uno

final class CardTests: XCTestCase {
    func testCardInitialization_whenProvidedDataIsValid_colorBlue() {
        // given
        let color = CardColor.blue
        let value = CardValue.one
        // when
        let card = Card(value: value, color: color)
        // then
        XCTAssertNotNil(card)
    }
    
    func testCardInitialization_whenProvidedDataIsValid_colorBlack() {
        // given
        let color = CardColor.black
        let value = CardValue.draw4
        // when
        let card = Card(value: value, color: color)
        // then
        XCTAssertNotNil(card)
    }
    
    func testCardInitialization_whenProvidedDataIsInvalid() {
        // given
        let color = CardColor.black
        let value = CardValue.one
        // when
        let card = Card(value: value, color: color)
        // then
        XCTAssertNil(card)
    }

    func testCardIsValidFirstCard_whenCardIsInvalid() {
        // given
        let card = Card(value: .draw4, color: .black)!
        // when
        let result = card.isValidFirstCard
        // then
        XCTAssertFalse(result)
    }

    func testCardIsValidFirstCard_whenCardIsValid() {
        // given
        let card = Card(value: .one, color: .red)!
        // when
        let result = card.isValidFirstCard
        // then
        XCTAssertTrue(result)
    }
    
    func testCardIsANumber() {
        XCTAssertTrue(Card(value: .zero, color: .blue)!.isANumberCard)
        XCTAssertTrue(Card(value: .one, color: .blue)!.isANumberCard)
        XCTAssertTrue(Card(value: .two, color: .blue)!.isANumberCard)
        XCTAssertTrue(Card(value: .three, color: .blue)!.isANumberCard)
        XCTAssertTrue(Card(value: .four, color: .blue)!.isANumberCard)
        XCTAssertTrue(Card(value: .five, color: .blue)!.isANumberCard)
        XCTAssertTrue(Card(value: .six, color: .blue)!.isANumberCard)
        XCTAssertTrue(Card(value: .seven, color: .blue)!.isANumberCard)
        XCTAssertTrue(Card(value: .eight, color: .blue)!.isANumberCard)
        XCTAssertTrue(Card(value: .nine, color: .blue)!.isANumberCard)
        XCTAssertFalse(Card(value: .draw2, color: .blue)!.isANumberCard)
    }
    
    func testCardPointsValue() {
        XCTAssertEqual(CardValue.draw2.points, 20)
        XCTAssertEqual(CardValue.skip.points, 20)
        XCTAssertEqual(CardValue.reverse.points, 20)
        XCTAssertEqual(CardValue.draw4.points, 50)
        XCTAssertEqual(CardValue.wild.points, 50)
        
        for cardValue in [
            CardValue.zero,
            .one,
            .two,
            .three,
            .four,
            .five,
            .six,
            .seven,
            .eight,
            .nine
        ] {
            XCTAssertEqual(cardValue.points, cardValue.rawValue)
        }
    }
}
