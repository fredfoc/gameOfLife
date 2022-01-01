//
//  File.swift
//
//
//  Created by Frederic FAUQUETTE on 01/01/2022.
//

// swiftlint:disable identifier_name

struct Cell {
    let x: Int
    let y: Int
    let state: State

    // inspired from : https://blog.scottlogic.com/2014/09/10/game-of-life-in-functional-swift.html
    private static func cellsAreNeighbours(_ op1: Cell, _ op2: Cell) -> Bool {
        let delta = (abs(op1.x - op2.x), abs(op1.y - op2.y))
        switch delta {
        case (1, 1), (1, 0), (0, 1):
            return true
        default:
            return false
        }
    }

    private func neighbours(_ world: [Cell]) -> [Cell] {
        world.filter { Cell.cellsAreNeighbours(self, $0) }
    }

    func livingNeighbours(_ world: [Cell]) -> Int {
        neighbours(world).filter { $0.state == .alive }.count
    }
}

extension Cell: Equatable {
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
}

// swiftlint:enable identifier_name
