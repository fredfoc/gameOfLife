//
//  File.swift
//
//
//  Created by Frederic FAUQUETTE on 01/01/2022.
//

import Combine
@testable import GameOfLife
import XCTest

final class cellTests: XCTestCase {
    func testLivingNeighboursShouldBeOk() throws {
        func randomState(_ count: inout Int) -> State {
            let state: State = Bool.random() ? .alive : .dead
            if state == .alive {
                count += 1
            }
            return state
        }
        // Arrange
        let cell = Cell(x: 1, y: 1, state: .alive)
        var count = 0
        let world = [Cell(x: 0, y: 0, state: randomState(&count)),
                     Cell(x: 1, y: 0, state: randomState(&count)),
                     Cell(x: 2, y: 0, state: randomState(&count)),
                     Cell(x: 0, y: 1, state: randomState(&count)),
                     Cell(x: 1, y: 1, state: .alive),
                     Cell(x: 2, y: 1, state: randomState(&count)),
                     Cell(x: 0, y: 2, state: randomState(&count)),
                     Cell(x: 1, y: 2, state: randomState(&count)),
                     Cell(x: 2, y: 2, state: randomState(&count)),
                     Cell(x: 0, y: 3, state: .alive),
                     Cell(x: 1, y: 3, state: .alive),
                     Cell(x: 2, y: 3, state: .alive)]
        // Act
        let numberOfLivingCell = cell.livingNeighbours(world)
        // Assert
        XCTAssertEqual(numberOfLivingCell, count)
    }
}
