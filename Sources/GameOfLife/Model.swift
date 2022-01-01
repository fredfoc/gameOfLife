//
//  Model.swift
//
//
//  Created by Frederic FAUQUETTE on 01/01/2022.
//

import Combine
import Foundation

@usableFromInline
class Model {
    private var domain: Domain?
    private var cancellable: AnyCancellable?
    private var _update = PassthroughSubject<[GridCell], Never>()
    @usableFromInline
    let rows: Int
    @usableFromInline
    let columns: Int

    @usableFromInline
    init(domain: Domain?, rows: Int = 10, columns: Int = 20) {
        self.domain = domain
        self.rows = rows
        self.columns = columns
    }

    private func sink() {
        cancellable?.cancel()
        cancellable = domain?.update.sink(receiveCompletion: { _ in },
                                          receiveValue: { values in
                                              self._update.send(values
                                                  .enumerated()
                                                  .map { GridCell(column: $0 % self.rows,
                                                                  row: Int(Double($0 / self.columns)),
                                                                  state: $1)
                                                  })
                                          })
    }

    deinit {
        cancellable?.cancel()
    }
}

extension Model: ModelProtocol {
    @usableFromInline
    var update: AnyPublisher<[GridCell], Never> {
        _update.eraseToAnyPublisher()
    }

    @usableFromInline
    func start() {
        sink()
        domain?.createWorld(x: rows, y: columns)
        domain?.start()
    }
}
