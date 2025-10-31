/**
 *  SwiftUIMasonry
 *  Copyright (c) Ciaran O'Brien 2025
 *  MIT license, see LICENSE file for details
 */

import SwiftUI

public struct VMasonry<Data, ID, Content>: View
where Data : RandomAccessCollection,
      ID : Hashable,
      Content : View
{
    public var body: Masonry<Data, ID, Content>
}


public extension VMasonry
where Data == [Never],
      ID == Never
{
    /// A view that arranges its children in a vertical masonry.
    ///
    /// This view returns a flexible preferred width to its parent layout.
    ///
    /// - Parameters:
    ///   - columns: The number of columns in the masonry.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the masonry to choose a default distance for each pair of
    ///     subviews.
    ///   - content: A view builder that creates the content of this masonry.
    init(columns: MasonryLines,
         spacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.body = Masonry(
            .vertical,
            lines: columns,
            spacing: spacing,
            content: content
        )
    }
    
    /// A view that arranges its children in a vertical masonry.
    ///
    /// This view returns a flexible preferred width to its parent layout.
    ///
    /// - Parameters:
    ///   - columns: The number of columns in the masonry.
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - content: A view builder that creates the content of this masonry.
    init(columns: MasonryLines,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.body = Masonry(
            .vertical,
            lines: columns,
            horizontalSpacing: horizontalSpacing,
            verticalSpacing: verticalSpacing,
            content: content
        )
    }
}


public extension VMasonry {
    
    /// A view that arranges its children in a vertical masonry.
    ///
    /// This view returns a flexible preferred width to its parent layout.
    ///
    /// - Parameters:
    ///   - columns: The number of columns in the masonry.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the masonry to choose a default distance for each pair of
    ///     subviews.
    ///   - data: The data that the masonry uses to create views dynamically.
    ///   - id: The key path to the provided data's identifier.
    ///   - content: A view builder that creates the content of this masonry.
    ///   - columnSpan: The number of columns the content for a given element
    ///     will span.
    init(columns: MasonryLines,
         spacing: CGFloat? = nil,
         data: Data,
         id: KeyPath<Data.Element, ID>,
         @ViewBuilder content: @escaping (Data.Element) -> Content,
         columnSpan: ((Data.Element) -> MasonryLines)? = nil)
    {
        self.body = Masonry(
            .vertical,
            lines: columns,
            spacing: spacing,
            data: data,
            id: id,
            content: content,
            lineSpan: columnSpan
        )
    }
    
    /// A view that arranges its children in a vertical masonry.
    ///
    /// This view returns a flexible preferred width to its parent layout.
    ///
    /// - Parameters:
    ///   - columns: The number of columns in the masonry.
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - data: The data that the masonry uses to create views dynamically.
    ///   - id: The key path to the provided data's identifier.
    ///   - content: A view builder that creates the content of this masonry.
    ///   - columnSpan: The number of columns the content for a given element
    ///     will span.
    init(columns: MasonryLines,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         data: Data,
         id: KeyPath<Data.Element, ID>,
         @ViewBuilder content: @escaping (Data.Element) -> Content,
         columnSpan: ((Data.Element) -> MasonryLines)? = nil)
    {
        self.body = Masonry(
            .vertical,
            lines: columns,
            horizontalSpacing: horizontalSpacing,
            verticalSpacing: verticalSpacing,
            data: data,
            id: id,
            content: content,
            lineSpan: columnSpan
        )
    }
}


public extension VMasonry
where Data.Element : Identifiable,
      Data.Element.ID == ID
{
    
    /// A view that arranges its children in a vertical masonry.
    ///
    /// This view returns a flexible preferred width to its parent layout.
    ///
    /// - Parameters:
    ///   - columns: The number of columns in the masonry.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the masonry to choose a default distance for each pair of
    ///     subviews.
    ///   - data: The identified data that the masonry uses to create views
    ///     dynamically.
    ///   - content: A view builder that creates the content of this masonry.
    ///   - columnSpan: The number of columns the content for a given element
    ///     will span.
    init(columns: MasonryLines,
         spacing: CGFloat? = nil,
         data: Data,
         @ViewBuilder content: @escaping (Data.Element) -> Content,
         columnSpan: ((Data.Element) -> MasonryLines)? = nil)
    {
        self.body = Masonry(
            .vertical,
            lines: columns,
            spacing: spacing,
            data: data,
            content: content,
            lineSpan: columnSpan
        )
    }
    
    /// A view that arranges its children in a vertical masonry.
    ///
    /// This view returns a flexible preferred width to its parent layout.
    ///
    /// - Parameters:
    ///   - columns: The number of columns in the masonry.
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - data: The identified data that the masonry uses to create views
    ///     dynamically.
    ///   - content: A view builder that creates the content of this masonry.
    ///   - columnSpan: The number of columns the content for a given element
    ///     will span.
    init(columns: MasonryLines,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         data: Data,
         @ViewBuilder content: @escaping (Data.Element) -> Content,
         columnSpan: ((Data.Element) -> MasonryLines)? = nil)
    {
        self.body = Masonry(
            .vertical,
            lines: columns,
            horizontalSpacing: horizontalSpacing,
            verticalSpacing: verticalSpacing,
            data: data,
            content: content,
            lineSpan: columnSpan
        )
    }
}
