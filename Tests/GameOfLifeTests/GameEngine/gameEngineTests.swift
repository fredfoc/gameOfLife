//
//  File.swift
//
//
//  Created by Frederic FAUQUETTE on 01/01/2022.
//

import Combine
@testable import GameOfLife
import XCTest

final class gameEngineTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    func testCreateWorldShouldReturnACorrectArray() throws {
        // Arrange
        let x = Int.random(in: 0 ..< 100)
        let y = Int.random(in: 0 ..< 100)
        // Act
        let world = GameEngine().createRandomWorld(x: x,
                                                   y: y)
        // Assert
        XCTAssertEqual(world.count, x * y)
    }

    func testWhenWorldIsCreatedAnUpdateShouldBeMade() throws {
        // Arrange
        let expectation = self.expectation(description: "testWhenWorldIsSetAnUpdateShouldBeMade")
        let engine = GameEngine()
        var receivedValue = false
        engine.update
            .sink { _ in } receiveValue: { _ in
                receivedValue = true
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // Act
        engine.createWorld(x: 10, y: 10)
        waitForExpectations(timeout: 1)
        // Assert
        XCTAssertTrue(receivedValue)
    }

    func testWhenEngineStartsAnUpdateShouldBeMade() throws {
        // Arrange
        let expectation = self.expectation(description: "testWhenEngineStartsAnUpdateShouldBeMade")
        let engine = GameEngine(refreshInterval: 0.1)
        var receivedValue = false
        var interval = 0
        engine.update
            .sink { _ in } receiveValue: { _ in
                interval += 1
                if interval > 2 {
                    receivedValue = true
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Act
        engine.createWorld(x: 10, y: 10)
        engine.start()
        waitForExpectations(timeout: 1)
        // Assert
        XCTAssertTrue(receivedValue)
    }

    func testIterateShouldReturnNilIfWorldIsNil() throws {
        // Arrange
        // Act
        // Assert
        XCTAssertNil(GameEngine().iterate(nil))
    }

    func testIterateShouldWorkProperlyForDying() throws {
        // Arrange
        let initialWorld = [Cell(x: 0, y: 0, state: .alive),
                            Cell(x: 1, y: 0, state: .dead),
                            Cell(x: 2, y: 0, state: .alive),
                            Cell(x: 0, y: 1, state: .alive),
                            Cell(x: 1, y: 1, state: .alive),
                            Cell(x: 2, y: 1, state: .alive),
                            Cell(x: 0, y: 2, state: .alive),
                            Cell(x: 1, y: 2, state: .alive),
                            Cell(x: 2, y: 2, state: .alive)]
        let expectedWorld = [Cell(x: 0, y: 0, state: .alive),
                             Cell(x: 1, y: 0, state: .dead),
                             Cell(x: 2, y: 0, state: .alive),
                             Cell(x: 0, y: 1, state: .dead),
                             Cell(x: 1, y: 1, state: .dead),
                             Cell(x: 2, y: 1, state: .dead),
                             Cell(x: 0, y: 2, state: .alive),
                             Cell(x: 1, y: 2, state: .dead),
                             Cell(x: 2, y: 2, state: .alive)]
        // Act
        let calculatedWorld = GameEngine().iterate(initialWorld)
        // Assert
        expectedWorld
            .enumerated()
            .forEach {
                XCTAssertEqual($1.state, calculatedWorld![$0].state)
            }
    }

    func testIterateShouldWorkProperlyForLiving() throws {
        // Arrange
        let initialWorld = [Cell(x: 0, y: 0, state: .alive),
                            Cell(x: 1, y: 0, state: .dead),
                            Cell(x: 0, y: 1, state: .alive),
                            Cell(x: 1, y: 1, state: .alive)]
        let expectedWorld = [Cell(x: 0, y: 0, state: .alive),
                             Cell(x: 1, y: 0, state: .alive),
                             Cell(x: 0, y: 1, state: .alive),
                             Cell(x: 1, y: 1, state: .alive)]
        // Act
        let calculatedWorld = GameEngine().iterate(initialWorld)
        // Assert
        expectedWorld
            .enumerated()
            .forEach {
                XCTAssertEqual($1.state, calculatedWorld![$0].state)
            }
    }
}
