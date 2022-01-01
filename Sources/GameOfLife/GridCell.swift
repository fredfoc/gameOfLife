//
//  File.swift
//
//
//  Created by Frederic FAUQUETTE on 01/01/2022.
//

import Foundation

@usableFromInline
struct GridCell {
    let column: Int
    let row: Int
    var state: State
}

extension GridCell: Equatable {
    @usableFromInline
    static func == (lhs: GridCell, rhs: GridCell) -> Bool {
        lhs.column == rhs.column && lhs.row == rhs.row
    }
}
