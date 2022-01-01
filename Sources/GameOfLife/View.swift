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

    // inspired by : https://github.com/martinlexow/GameOfLife/blob/main/GameOfLife
    @usableFromInline
    var body: some SwiftUI.View {
        VStack(spacing: .zero) {
            HStack(alignment: .top, spacing: .zero) {
                ForEach(0 ..< self.presenter.columns, id: \.self) { column in
                    VStack(alignment: .leading, spacing: .zero) {
                        ForEach(0 ..< self.presenter.rows, id: \.self) { row in
                            if let cell = self.presenter.cell(column: column, row: row) {
                                CellView(cell: cell)
                            }
                        }
                    }
                }
            }
            .padding(24.0)
            HStack {
                Button("Start") {
                    self.presenter.start()
                }
            }
            .padding([.bottom], 28.0)
        }
    }
}

private struct CellView: SwiftUI.View {
    var cell: GridCell

    private var foregroundColor: Color {
        cell.state.color
    }

    var body: some SwiftUI.View {
        Rectangle()
            .foregroundColor(foregroundColor)
            .frame(width: 11.0, height: 11.0)
            .overlay(
                Rectangle()
                    .strokeBorder(Color.black.opacity(0.3), lineWidth: 0.5, antialiased: true)
            )
    }
}

extension State {
    var color: Color {
        switch self {
        case .alive:
            return .black
        case .dead:
            return .white
        }
    }
}
