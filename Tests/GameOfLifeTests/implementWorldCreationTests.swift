//
//  implementWorldCreationTests.swift
//
//
//  Created by Frederic FAUQUETTE on 31/12/2021.
//

@testable import GameOfLife
import XCTest

final class implementWorldCreationTests: XCTestCase {
    func testDomainShouldHaveStateEnum() throws {
        XCTAssertNotNil(State.alive)
        XCTAssertNotNil(State.dead)
    }
}
