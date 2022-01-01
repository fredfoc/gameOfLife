//
//  implementWorldCreationTests.swift
//
//
//  Created by Frederic FAUQUETTE on 31/12/2021.
//

@testable import GameOfLife
import XCTest

final class implementWorldCreationTests: XCTestCase {
    func testDomainShouldHaveAcreateWorlMethod() throws {
        XCTAssertNotNil(Domain().createWorld(x: 10, y: 10))
    }

    func testCreateWorldShouldReturnACorrectArray() throws {
        // Arrange
        let x = Int.random(in: 0 ..< 100)
        let y = Int.random(in: 0 ..< 100)
        let randomRow = Int.random(in: 0 ..< y)
        // Act
        let world = Domain().createWorld(x: x,
                                         y: y)
        // Assert
        XCTAssertEqual(world.count, y)
        XCTAssertEqual(world[randomRow].count, x)
    }

    func testDomainShouldHaveStateEnum() throws {
        XCTAssertNotNil(State.alive)
        XCTAssertNotNil(State.dead)
    }
}
