/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2026
*  MIT license, see LICENSE file for details
*/

import SwiftUI

public extension View {
    
    /// Sets the number of rows this subview will span in a parent HMasonry layout.
    func masonryRowSpan(_ rowCount: MasonryRowCount) -> some View {
        layoutValue(key: MasonryRowSpanKey.self, value: rowCount)
    }
    
    /// Sets the number of columns this subview will span in a parent VMasonry layout.
    func masonryColumnSpan(_ columnCount: MasonryColumnCount) -> some View {
        layoutValue(key: MasonryColumnSpanKey.self, value: columnCount)
    }
}
