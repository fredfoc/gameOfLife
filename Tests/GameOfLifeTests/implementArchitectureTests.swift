//
//  implementArchitectureTests.swift
//
//
//  Created by Frederic FAUQUETTE on 31/12/2021.
//

@testable import GameOfLife
import XCTest

final class implementArchitectureTests: XCTestCase {
    func testLibHasAGameOfLifeFile() throws {
        XCTAssertNotNil(Game.create(rows: 10, columns: 10))
    }
}
