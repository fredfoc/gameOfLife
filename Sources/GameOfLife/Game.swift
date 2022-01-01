//
//  GameOfLife.swift
//
//
//  Created by Frederic FAUQUETTE on 31/12/2021.
//

import Combine
import SwiftUI

public enum Game {
    /// create a Game of Life
    ///
    /// - parameters:
    ///    - x: The number of columns
    ///    - y: The number of rows
    @inlinable
    public static func create(rows: Int, columns: Int) -> some SwiftUI.View {
        let domain = DependencyContainer.shared.container.resolve(Domain.self)
        let model = Model(domain: domain, rows: rows, columns: columns)
        let presenter = Presenter(model: model)
        return View(presenter: presenter)
    }
}
