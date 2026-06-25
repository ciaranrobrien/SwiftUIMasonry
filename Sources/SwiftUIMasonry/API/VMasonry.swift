/**
 *  SwiftUIMasonry
 *  Copyright (c) Ciaran O'Brien 2026
 *  MIT license, see LICENSE file for details
 */

import SwiftUI

/// A layout that arranges its subviews in a vertical masonry.
public struct VMasonry: Layout {
    @Environment(\.masonryPlacementMode) internal var placementMode
    
    internal var columnCount: MasonryColumnCount
    internal var horizontalSpacing: CGFloat
    internal var verticalSpacing: CGFloat
}


public extension VMasonry {
    
    /// A layout that arranges its subviews in a vertical masonry.
    ///
    /// - Parameters:
    ///   - columnCount: The number of columns in the masonry.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the masonry to choose a default distance for each pair of
    ///     subviews.
    init(columns columnCount: MasonryColumnCount,
         spacing: CGFloat? = nil)
    {
        self.columnCount = columnCount
        self.horizontalSpacing = spacing ?? defaultSpacing
        self.verticalSpacing = spacing ?? defaultSpacing
    }
    
    /// A layout that arranges its subviews in a vertical masonry.
    ///
    /// - Parameters:
    ///   - columnCount: The number of columns in the masonry.
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    init(columns columnCount: MasonryColumnCount,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil)
    {
        self.columnCount = columnCount
        self.horizontalSpacing = horizontalSpacing ?? defaultSpacing
        self.verticalSpacing = verticalSpacing ?? defaultSpacing
    }
}
