//
//  File.swift
//
//
//  Created by Frederic FAUQUETTE on 01/01/2022.
//

import Combine
@testable import GameOfLife
import XCTest

extension Domain {
    func createWorld(x _: Int, y _: Int) {}
    func start() {}
    var error: AnyPublisher<Void, DomainError> {
        Fail(error: DomainError.engineWasBroken)
            .eraseToAnyPublisher()
    }

    var update: AnyPublisher<[State], DomainError> {
        Just([State.dead])
            .setFailureType(to: DomainError.self)
            .eraseToAnyPublisher()
    }
}

final class modelTests: XCTestCase {
    func testModelShouldCallCreateWorldBeforeStartingTheGame() throws {
        // Arrange
        class MockDomain: Domain {
            var createWasCalled = false
            var startWasCalled = false

            init() {}

            func createWorld(x _: Int, y _: Int) {
                createWasCalled = true
            }

            func start() {
                startWasCalled = createWasCalled ? true : false
            }
        }
        let mockDomain = MockDomain()
        let model = Model(domain: mockDomain)
        // Act
        model.start()
        // Assert
        XCTAssertTrue(mockDomain.createWasCalled)
        XCTAssertTrue(mockDomain.startWasCalled)
    }

    func testModelShouldSinkToUpdateAtStart() throws {
        // Arrange
        class MockPublisher<Output>: Publisher {
            var receivedSubscription = false

            public typealias Failure = DomainError
            public let output: Output

            public init(_ output: Output) {
                self.output = output
            }

            public func receive<S: Subscriber>(subscriber _: S) where S.Input == Output, S.Failure == Failure {
                receivedSubscription = true
            }
        }

        class MockDomain: Domain {
            var publisher = MockPublisher([State.dead])

            init() {}

            var update: AnyPublisher<[State], DomainError> {
                publisher
                    .eraseToAnyPublisher()
            }
        }

        let mockDomain = MockDomain()
        // Act
        Model(domain: mockDomain).start()
        // Assert
        XCTAssertTrue(mockDomain.publisher.receivedSubscription)
    }

    func testGridCellEquatable() throws {
        // Arrange
        let cell1 = GridCell(column: 1, row: 1, state: .dead)
        let cell2 = GridCell(column: 1, row: 1, state: .alive)
        // Act
        // Assert
        XCTAssertEqual(cell1, cell2)
    }
}
