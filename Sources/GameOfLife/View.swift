//
//  View.swift
//
//
//  Created by Frederic FAUQUETTE on 31/12/2021.
//

import SwiftUI

@usableFromInline
struct View: SwiftUI.View {
    @ObservedObject private var presenter: Presenter

    @usableFromInline
    init(presenter: Presenter) {
        self.presenter = presenter
    }

    @usableFromInline
    var body: some SwiftUI.View {
        Text("Hello")
    }
}
