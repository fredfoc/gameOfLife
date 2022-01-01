//
//  File.swift
//
//
//  Created by Frederic FAUQUETTE on 01/01/2022.
//

import Swinject

@usableFromInline
class DependencyContainer {
    @usableFromInline static let shared = DependencyContainer()

    @usableFromInline lazy var container: Container = {
        let container = Container()
        container.register(Domain.self) { _ in
            GameEngine()
        }
        return container
    }()

    private init() {}
}
