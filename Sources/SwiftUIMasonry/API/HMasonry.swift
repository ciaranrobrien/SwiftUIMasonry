/**
 *  SwiftUIMasonry
 *  Copyright (c) Ciaran O'Brien 2025
 *  MIT license, see LICENSE file for details
 */

import SwiftUI

public struct HMasonry<Data, ID, Content>: View
where Data : RandomAccessCollection,
      ID : Hashable,
      Content : View
{
    public var body: Masonry<Data, ID, Content>
}


public extension HMasonry
where Data == [Never],
      ID == Never
{
    /// A view that arranges its children in a horizontal masonry.
    ///
    /// This view returns a flexible preferred height to its parent layout.
    ///
    /// - Parameters:
    ///   - rows: The number of rows in the masonry.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the masonry to choose a default distance for each pair of
    ///     subviews.
    ///   - content: A view builder that creates the content of this masonry.
    init(rows: MasonryLines,
         spacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.body = Masonry(
            .horizontal,
            lines: rows,
            spacing: spacing,
            content: content
        )
    }
    
    /// A view that arranges its children in a horizontal masonry.
    ///
    /// This view returns a flexible preferred height to its parent layout.
    ///
    /// - Parameters:
    ///   - rows: The number of rows in the masonry.
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - content: A view builder that creates the content of this masonry.
    init(rows: MasonryLines,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.body = Masonry(
            .horizontal,
            lines: rows,
            horizontalSpacing: horizontalSpacing,
            verticalSpacing: verticalSpacing,
            content: content
        )
    }
}


public extension HMasonry {
    
    /// A view that arranges its children in a horizontal masonry.
    ///
    /// This view returns a flexible preferred height to its parent layout.
    ///
    /// - Parameters:
    ///   - rows: The number of rows in the masonry.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the masonry to choose a default distance for each pair of
    ///     subviews.
    ///   - data: The data that the masonry uses to create views dynamically.
    ///   - id: The key path to the provided data's identifier.
    ///   - content: A view builder that creates the content of this masonry.
    ///   - rowSpan: The number of rows the content for a given element will
    ///     span.
    init(rows: MasonryLines,
         spacing: CGFloat? = nil,
         data: Data,
         id: KeyPath<Data.Element, ID>,
         @ViewBuilder content: @escaping (Data.Element) -> Content,
         rowSpan: ((Data.Element) -> MasonryLines)? = nil)
    {
        self.body = Masonry(
            .horizontal,
            lines: rows,
            spacing: spacing,
            data: data,
            id: id,
            content: content,
            lineSpan: rowSpan
        )
    }
    
    /// A view that arranges its children in a horizontal masonry.
    ///
    /// This view returns a flexible preferred height to its parent layout.
    ///
    /// - Parameters:
    ///   - rows: The number of rows in the masonry.
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - data: The data that the masonry uses to create views dynamically.
    ///   - id: The key path to the provided data's identifier.
    ///   - content: A view builder that creates the content of this masonry.
    ///   - rowSpan: The number of rows the content for a given element will
    ///     span.
    init(rows: MasonryLines,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         data: Data,
         id: KeyPath<Data.Element, ID>,
         @ViewBuilder content: @escaping (Data.Element) -> Content,
         rowSpan: ((Data.Element) -> MasonryLines)? = nil)
    {
        self.body = Masonry(
            .horizontal,
            lines: rows,
            horizontalSpacing: horizontalSpacing,
            verticalSpacing: verticalSpacing,
            data: data,
            id: id,
            content: content,
            lineSpan: rowSpan
        )
    }
}


public extension HMasonry
where Data.Element : Identifiable,
      Data.Element.ID == ID
{
    
    /// A view that arranges its children in a horizontal masonry.
    ///
    /// This view returns a flexible preferred height to its parent layout.
    ///
    /// - Parameters:
    ///   - rows: The number of rows in the masonry.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the masonry to choose a default distance for each pair of
    ///     subviews.
    ///   - data: The identified data that the masonry uses to create views
    ///     dynamically.
    ///   - content: A view builder that creates the content of this masonry.
    ///   - rowSpan: The number of rows the content for a given element will
    ///     span.
    init(rows: MasonryLines,
         spacing: CGFloat? = nil,
         data: Data,
         @ViewBuilder content: @escaping (Data.Element) -> Content,
         rowSpan: ((Data.Element) -> MasonryLines)? = nil)
    {
        self.body = Masonry(
            .horizontal,
            lines: rows,
            spacing: spacing,
            data: data,
            content: content,
            lineSpan: rowSpan
        )
    }
    
    /// A view that arranges its children in a horizontal masonry.
    ///
    /// This view returns a flexible preferred height to its parent layout.
    ///
    /// - Parameters:
    ///   - rows: The number of rows in the masonry.
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - data: The identified data that the masonry uses to create views
    ///     dynamically.
    ///   - content: A view builder that creates the content of this masonry.
    ///   - rowSpan: The number of rows the content for a given element will
    ///     span.
    init(rows: MasonryLines,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         data: Data,
         @ViewBuilder content: @escaping (Data.Element) -> Content,
         rowSpan: ((Data.Element) -> MasonryLines)? = nil)
    {
        self.body = Masonry(
            .horizontal,
            lines: rows,
            horizontalSpacing: horizontalSpacing,
            verticalSpacing: verticalSpacing,
            data: data,
            content: content,
            lineSpan: rowSpan
        )
    }
}
