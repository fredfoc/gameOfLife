//
//  GameOfLife.swift
//
//
//  Created by Frederic FAUQUETTE on 31/12/2021.
//

import SwiftUI

public enum Game {
    /// create a Game of Life
    ///
    /// - parameters:
    ///    - x: The number of columns
    ///    - y: The number of rows
    @inlinable
    static func create(x _: Int, y _: Int) -> some SwiftUI.View {
        let domain = DependencyContainer.shared.container.resolve(Domain.self)
        let model = Model(domain: domain)
        let presenter = Presenter(Model: model)
        return View(presenter: presenter)
    }
}
