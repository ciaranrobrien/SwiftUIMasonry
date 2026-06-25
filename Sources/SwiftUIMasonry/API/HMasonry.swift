/**
 *  SwiftUIMasonry
 *  Copyright (c) Ciaran O'Brien 2026
 *  MIT license, see LICENSE file for details
 */

import SwiftUI

/// A layout that arranges its subviews in a horizontal masonry.
public struct HMasonry: Layout {
    internal var horizontalSpacing: CGFloat
    internal var placementMode: MasonryPlacementMode
    internal var rowCount: MasonryRowCount
    internal var verticalSpacing: CGFloat
}


public extension HMasonry {
    
    /// A layout that arranges its subviews in a horizontal masonry.
    ///
    /// - Parameters:
    ///   - rowCount: The number of rows in the masonry.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the masonry to choose a default distance for each pair of
    ///     subviews.
    ///   - placementMode: The placement mode for subviews in this masonry.
    init(rows rowCount: MasonryRowCount,
         spacing: CGFloat? = nil,
         placementMode: MasonryPlacementMode = defaultPlacementMode)
    {
        self.horizontalSpacing = spacing ?? defaultSpacing
        self.placementMode = placementMode
        self.rowCount = rowCount
        self.verticalSpacing = spacing ?? defaultSpacing
    }
    
    /// A layout that arranges its subviews in a horizontal masonry.
    ///
    /// - Parameters:
    ///   - rowCount: The number of rows in the masonry.
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - placementMode: The placement mode for subviews in this masonry.
    init(rows rowCount: MasonryRowCount,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         placementMode: MasonryPlacementMode = defaultPlacementMode)
    {
        self.horizontalSpacing = horizontalSpacing ?? defaultSpacing
        self.placementMode = placementMode
        self.rowCount = rowCount
        self.verticalSpacing = verticalSpacing ?? defaultSpacing
    }
}
