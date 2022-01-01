//
//  File.swift
//
//
//  Created by Frederic FAUQUETTE on 01/01/2022.
//

import Combine
import Foundation

// swiftlint:disable identifier_name

@usableFromInline
final class GameEngine {
    var world: [Cell]? {
        didSet {
            if let world = world {
                _update.send(world.map { $0.state })
            }
        }
    }

    private var rows: Int?
    private var columns: Int?
    private let _update = PassthroughSubject<[State], DomainError>()
    private var timer: Timer.TimerPublisher
    private var cancellable: AnyCancellable?
    private var refreshInterval: Double

    @usableFromInline
    init(refreshInterval: Double = 0.05) {
        self.refreshInterval = refreshInterval
        timer = Timer.publish(every: refreshInterval, on: .main, in: .common)
    }

    func createRandomWorld(x: Int, y: Int) -> [Cell] {
        Array(repeating: State.alive, count: x * y)
            .map { _ in Bool.random() ? .alive : .dead }
            .enumerated()
            .map {
                Cell(x: $0 % y, y: Int(Double($0 / x)), state: $1)
            }
    }

    func iterate(_ world: [Cell]?) -> [Cell]? {
        guard let world = world else {
            return nil
        }
        let liveCells = world.filter { $0.state == .alive }
        let deadCells = world.filter { $0.state != .alive }

        let dyingCells = liveCells.filter { !(2 ... 3 ~= $0.livingNeighbours(world)) }
        let newLife = deadCells.filter { $0.livingNeighbours(world) == 3 }

        return world.map { cell in
            if dyingCells.contains(cell) {
                return Cell(x: cell.x, y: cell.y, state: .dead)
            } else if newLife.contains(cell) {
                return Cell(x: cell.x, y: cell.y, state: .alive)
            }
            return cell
        }
    }

    deinit {
        cancellable?.cancel()
    }
}

extension GameEngine: Domain {
    @usableFromInline
    func createWorld(x: Int, y: Int) {
        rows = y
        columns = x
        world = createRandomWorld(x: x, y: y)
    }

    @usableFromInline
    func start() {
        cancellable?.cancel()
        cancellable = timer.autoconnect().sink(receiveValue: { [weak self] _ in
            self?.world = self?.iterate(self?.world)
        })
    }

    @usableFromInline
    var update: AnyPublisher<[State], DomainError> {
        _update
            .eraseToAnyPublisher()
    }
}

// swiftlint:enable identifier_name
