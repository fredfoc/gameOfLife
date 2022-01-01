//
//  Model.swift
//
//
//  Created by Frederic FAUQUETTE on 01/01/2022.
//

import Combine
import Foundation

@usableFromInline
struct Model {
    private let domain: Domain?
    private var cancellable: AnyCancellable?

    @usableFromInline
    init(domain: Domain?) {
        self.domain = domain
        cancellable = domain?.update.sink(receiveCompletion: { _ in },
                                          receiveValue: { _ in })
    }

    func start() {
        domain?.createWorld(x: 10, y: 10)
        domain?.start()
    }
}
