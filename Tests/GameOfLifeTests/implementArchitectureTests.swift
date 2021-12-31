//
//  implementArchitectureTests.swift
//
//
//  Created by Frederic FAUQUETTE on 31/12/2021.
//

@testable import GameOfLife
import XCTest

final class implementArchitectureTests: XCTestCase {
    func testLibHasAViewFile() throws {
        XCTAssertNotNil(View())
    }

    func testLibHasAPresenterFile() throws {
        XCTAssertNotNil(Presenter())
    }

    func testLibHasADomainFile() throws {
        XCTAssertNotNil(Domain())
    }

    func testLibHasAGameOfLifeFile() throws {
        XCTAssertNotNil(Game.create(x: 10, y: 10))
    }
}
