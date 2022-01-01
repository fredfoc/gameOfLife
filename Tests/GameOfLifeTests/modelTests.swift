//
//  File.swift
//
//
//  Created by Frederic FAUQUETTE on 01/01/2022.
//

import Combine
@testable import GameOfLife
import XCTest

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

            var update: AnyPublisher<[[State]], DomainError> = Just([[State.dead]])
                .setFailureType(to: DomainError.self)
                .eraseToAnyPublisher()
        }
        let mockDomain = MockDomain()
        let model = Model(domain: mockDomain)
        // Act
        model.start()
        // Assert
        XCTAssertTrue(mockDomain.createWasCalled)
        XCTAssertTrue(mockDomain.startWasCalled)
    }

    func testModelShouldSinkToUpdateBeforeStartingTheGame() throws {
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
            var publisher = MockPublisher([[State.dead]])

            init() {}

            func createWorld(x _: Int, y _: Int) {}

            func start() {}

            var update: AnyPublisher<[[State]], DomainError> {
                publisher
                    .eraseToAnyPublisher()
            }
        }

        let mockDomain = MockDomain()
        let model = Model(domain: mockDomain)
        // Act
        model.start()
        // Assert
        XCTAssertTrue(mockDomain.publisher.receivedSubscription)
    }
}
