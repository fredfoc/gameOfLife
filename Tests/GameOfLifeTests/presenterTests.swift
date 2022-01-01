//
//  File.swift
//
//
//  Created by Frederic FAUQUETTE on 01/01/2022.
//

import Combine
@testable import GameOfLife
import XCTest

extension ModelProtocol {
    func start() {}
    var update: AnyPublisher<[GridCell], Never> {
        Just([GridCell(column: 0, row: 0, state: .dead)]).eraseToAnyPublisher()
    }

    var rows: Int { 10 }
    var columns: Int { 10 }
}

final class presenterTests: XCTestCase {
    func testPresenterShouldCallStartModelWhenStarting() throws {
        // Arrange
        class MockModel: ModelProtocol {
            var startWasCalled = false
            func start() {
                startWasCalled = true
            }
        }
        let mockModel = MockModel()
        let presenter = Presenter(model: mockModel)
        // Act
        presenter.start()
        // Assert
        XCTAssertTrue(mockModel.startWasCalled)
    }

    func testPresenterShouldGetRowsAndColumnsFromModelAtInit() throws {
        // Arrange
        class MockModel: ModelProtocol {
            var rows: Int { 10 }
            var columns: Int { 15 }
        }
        let mockModel = MockModel()
        // Act
        _ = Presenter(model: mockModel)
        // Assert
        XCTAssertEqual(mockModel.rows, 10)
        XCTAssertEqual(mockModel.columns, 15)
    }

    func testPresenterShouldSinkToModelUpdateAtStart() throws {
        // Arrange
        class MockPublisher<Output>: Publisher {
            var receivedSubscription = false

            public typealias Failure = Never
            public let output: Output

            public init(_ output: Output) {
                self.output = output
            }

            public func receive<S: Subscriber>(subscriber _: S) where S.Input == Output, S.Failure == Failure {
                receivedSubscription = true
            }
        }

        class MockModel: ModelProtocol {
            var publisher = MockPublisher([GridCell(column: 0, row: 0, state: .dead)])

            init() {}

            var update: AnyPublisher<[GridCell], Never> {
                publisher
                    .eraseToAnyPublisher()
            }
        }

        let mockModel = MockModel()
        // Act
        Presenter(model: mockModel).start()
        // Assert
        XCTAssertTrue(mockModel.publisher.receivedSubscription)
    }

    func testPresenterShouldReturnCorrectGridCell() throws {
        // Arrange
        class MockModel: ModelProtocol {
            var rows = 10
            var columns = 15
            private var world: [GridCell] {
                Array(repeating: State.dead, count: columns * rows)
                    .enumerated()
                    .map { index, state in
                        let row = Int(Double(index / columns))
                        let column = index % columns
                        return GridCell(column: column, row: row, state: state)
                    }
            }

            var update: AnyPublisher<[GridCell], Never> {
                Just(world).eraseToAnyPublisher()
            }
        }
        let mockModel = MockModel()
        let presenter = Presenter(model: mockModel)
        let row = Int.random(in: 0 ..< mockModel.rows)
        let column = Int.random(in: 0 ..< mockModel.columns)
        // Act
        presenter.start()
        let cell = presenter.cell(column: column, row: row)
        // Assert
        XCTAssertEqual(cell?.row, row)
        XCTAssertEqual(cell?.column, column)
    }
}
