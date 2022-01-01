//
//  Presenter.swift
//
//
//  Created by Frederic FAUQUETTE on 31/12/2021.
//

import Combine
import SwiftUI

@usableFromInline
final class Presenter: ObservableObject {
    @Published var world: [GridCell]?
    let rows: Int
    let columns: Int

    private var model: ModelProtocol
    private var cancellable: AnyCancellable?

    @usableFromInline
    init(model: ModelProtocol) {
        self.model = model
        rows = model.rows
        columns = model.columns
    }

    private func sink() {
        cancellable?.cancel()
        cancellable = model.update
            .sink { [weak self] in
                self?.world = $0
            }
    }

    deinit {
        cancellable?.cancel()
    }

    func start() {
        sink()
        model.start()
    }

    func cell(column: Int, row: Int) -> GridCell? {
        world?[row * columns + column]
    }
}

@usableFromInline
protocol ModelProtocol {
    func start()
    var update: AnyPublisher<[GridCell], Never> { get }
    var rows: Int { get }
    var columns: Int { get }
}
