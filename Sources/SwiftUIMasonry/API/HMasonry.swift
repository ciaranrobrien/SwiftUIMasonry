/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2022
*  MIT license, see LICENSE file for details
*/

import SwiftUI

public struct HMasonry<Content>: View
where Content : View
{
    public var body: some View {
        Masonry(.horizontal,
                lines: lines,
                placementMode: placementMode,
                horizontalSpacing: horizontalSpacing,
                verticalSpacing: verticalSpacing,
                content: content)
    }
    
    private var content: () -> Content
    private var horizontalSpacing: CGFloat?
    private var lines: MasonryLines
    private var placementMode: MasonryPlacementMode
    private var verticalSpacing: CGFloat?
}


public extension HMasonry {
    /// A view that arranges its children in a horizontal masonry.
    ///
    /// This view returns a flexible preferred height to its parent layout.
    ///
    /// - Parameters:
    ///   - rows: The number of rows in the masonry.
    ///   - placementMode: The placement of subviews in the masonry.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the masonry to choose a default distance for each pair of
    ///     subviews.
    ///   - content: A view builder that creates the content of this masonry.
    init(rows: MasonryLines,
         placementMode: MasonryPlacementMode = .fill,
         spacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.content = content
        self.horizontalSpacing = spacing
        self.lines = rows
        self.placementMode = placementMode
        self.verticalSpacing = spacing
    }
    
    /// A view that arranges its children in a horizontal masonry.
    ///
    /// This view returns a flexible preferred height to its parent layout.
    ///
    /// - Parameters:
    ///   - rows: The number of rows in the masonry.
    ///   - placementMode: The placement of subviews in the masonry.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the masonry to choose a default distance for each pair of
    ///     subviews.
    ///   - content: A view builder that creates the content of this masonry.
    init(rows: Int,
         placementMode: MasonryPlacementMode = .fill,
         spacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.content = content
        self.horizontalSpacing = spacing
        self.lines = .fixed(rows)
        self.placementMode = placementMode
        self.verticalSpacing = spacing
    }
    
    /// A view that arranges its children in a horizontal masonry.
    ///
    /// This view returns a flexible preferred height to its parent layout.
    ///
    /// - Parameters:
    ///   - rows: The number of rows in the masonry.
    ///   - placementMode: The placement of subviews in the masonry.
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - content: A view builder that creates the content of this masonry.
    init(rows: MasonryLines,
         placementMode: MasonryPlacementMode = .fill,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.content = content
        self.horizontalSpacing = horizontalSpacing
        self.lines = rows
        self.placementMode = placementMode
        self.verticalSpacing = verticalSpacing
    }
    
    /// A view that arranges its children in a horizontal masonry.
    ///
    /// This view returns a flexible preferred height to its parent layout.
    ///
    /// - Parameters:
    ///   - rows: The number of rows in the masonry.
    ///   - placementMode: The placement of subviews in the masonry.   
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - content: A view builder that creates the content of this masonry.
    init(rows: Int,
         placementMode: MasonryPlacementMode = .fill,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.content = content
        self.horizontalSpacing = horizontalSpacing
        self.lines = .fixed(rows)
        self.placementMode = placementMode
        self.verticalSpacing = verticalSpacing
    }
}

