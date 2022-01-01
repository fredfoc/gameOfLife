//
//  File.swift
//
//
//  Created by Frederic FAUQUETTE on 01/01/2022.
//

import Combine
import Foundation

@usableFromInline
struct GameEngine {
    private let _update = PassthroughSubject<[[State]], DomainError>()
    @usableFromInline
    init() {}

    func generateWorld(x: Int, y: Int) -> [[State]] {
        Array(repeating: .dead, count: x * y)
            .chunks(ofCount: x)
            .map { Array($0) }
    }
}

extension GameEngine: Domain {
    @usableFromInline
    func createWorld(x _: Int, y _: Int) {}

    @usableFromInline
    func start() {}

    @usableFromInline
    var update: AnyPublisher<[[State]], DomainError> {
        _update.eraseToAnyPublisher()
    }
}
