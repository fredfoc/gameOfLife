//
//  Domain.swift
//
//
//  Created by Frederic FAUQUETTE on 31/12/2021.
//

import Algorithms
import Foundation

enum State {
    case alive
    case dead
}

struct Domain {
    func createWorld(x: Int, y: Int) -> [[State]] {
        Array(repeating: .dead, count: x * y)
            .chunks(ofCount: x)
            .map { Array($0) }
    }
}
