/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2022
*  MIT license, see LICENSE file for details
*/

import SwiftUI

public struct VMasonry<Content>: View
where Content : View
{
    public var body: some View {
        Masonry(.vertical,
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


public extension VMasonry {
    /// A view that arranges its children in a vertical masonry.
    ///
    /// This view returns a flexible preferred width to its parent layout.
    ///
    /// - Parameters:
    ///   - columns: The number of columns in the masonry.
    ///   - placementMode: The placement of subviews in the masonry.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the masonry to choose a default distance for each pair of
    ///     subviews.
    ///   - content: A view builder that creates the content of this masonry.
    init(columns: MasonryLines,
         placementMode: MasonryPlacementMode = .fill,
         spacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.content = content
        self.horizontalSpacing = spacing
        self.lines = columns
        self.placementMode = placementMode
        self.verticalSpacing = spacing
    }
    
    /// A view that arranges its children in a vertical masonry.
    ///
    /// This view returns a flexible preferred width to its parent layout.
    ///
    /// - Parameters:
    ///   - columns: The number of columns in the masonry.
    ///   - placementMode: The placement of subviews in the masonry.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the masonry to choose a default distance for each pair of
    ///     subviews.
    ///   - content: A view builder that creates the content of this masonry.
    init(columns: Int,
         placementMode: MasonryPlacementMode = .fill,
         spacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.content = content
        self.horizontalSpacing = spacing
        self.lines = .fixed(columns)
        self.placementMode = placementMode
        self.verticalSpacing = spacing
    }
    
    /// A view that arranges its children in a vertical masonry.
    ///
    /// This view returns a flexible preferred width to its parent layout.
    ///
    /// - Parameters:
    ///   - columns: The number of columns in the masonry.
    ///   - placementMode: The placement of subviews in the masonry.
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - content: A view builder that creates the content of this masonry.
    init(columns: MasonryLines,
         placementMode: MasonryPlacementMode = .fill,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.content = content
        self.horizontalSpacing = horizontalSpacing
        self.lines = columns
        self.placementMode = placementMode
        self.verticalSpacing = verticalSpacing
    }
    
    /// A view that arranges its children in a vertical masonry.
    ///
    /// This view returns a flexible preferred width to its parent layout.
    ///
    /// - Parameters:
    ///   - columns: The number of columns in the masonry.
    ///   - placementMode: The placement of subviews in the masonry.   
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - content: A view builder that creates the content of this masonry.
    init(columns: Int,
         placementMode: MasonryPlacementMode = .fill,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.content = content
        self.horizontalSpacing = horizontalSpacing
        self.lines = .fixed(columns)
        self.placementMode = placementMode
        self.verticalSpacing = verticalSpacing
    }
}

