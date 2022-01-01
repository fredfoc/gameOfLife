//
//  Domain.swift
//
//
//  Created by Frederic FAUQUETTE on 31/12/2021.
//

import Algorithms
import Combine
import Foundation

@usableFromInline
enum State {
    case alive
    case dead
}

@usableFromInline
enum DomainError: Error {
    case engineWasBroken
}

@usableFromInline
protocol Domain {
    func createWorld(x: Int, y: Int)
    func start()
    var update: AnyPublisher<[[State]], DomainError> { get }
}
