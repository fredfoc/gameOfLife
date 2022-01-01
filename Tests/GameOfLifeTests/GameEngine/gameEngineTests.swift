//
//  File.swift
//
//
//  Created by Frederic FAUQUETTE on 01/01/2022.
//

@testable import GameOfLife
import XCTest

final class gameEngineTests: XCTestCase {
    func testCreateWorldShouldReturnACorrectArray() throws {
        // Arrange
        let x = Int.random(in: 0 ..< 100)
        let y = Int.random(in: 0 ..< 100)
        let randomRow = Int.random(in: 0 ..< y)
        // Act
        let world = GameEngine().generateWorld(x: x,
                                               y: y)
        // Assert
        XCTAssertEqual(world.count, y)
        XCTAssertEqual(world[randomRow].count, x)
    }
}
