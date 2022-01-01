//
//  Presenter.swift
//
//
//  Created by Frederic FAUQUETTE on 31/12/2021.
//

import SwiftUI

@usableFromInline
final class Presenter: ObservableObject {
    @Published var gameIsStarted = false

    private var Model: Model

    @usableFromInline
    init(Model: Model) {
        self.Model = Model
    }
}
