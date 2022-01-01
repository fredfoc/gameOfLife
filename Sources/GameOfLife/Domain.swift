//
//  Domain.swift
//
//
//  Created by Frederic FAUQUETTE on 31/12/2021.
//

import Combine
import Foundation

@usableFromInline
enum State {
    case alive
    case dead
}

public enum DomainError: Error {
    case engineWasBroken
}

@usableFromInline
protocol Domain: AnyObject {
    // swiftlint:disable identifier_name
    func createWorld(x: Int, y: Int)
    // swiftlint:enable identifier_name
    func start()
    var update: AnyPublisher<[State], DomainError> { get }
}
