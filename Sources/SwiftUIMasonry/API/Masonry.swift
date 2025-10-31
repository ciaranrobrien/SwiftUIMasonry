/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2025
*  MIT license, see LICENSE file for details
*/

import SwiftUI

public struct Masonry<Data, ID, Content>: View
where Data : RandomAccessCollection,
      ID : Hashable,
      Content : View
{
    public var body: some View {
        GeometryReader { geometry in
            MasonryLayout(
                axis: axis,
                content: content,
                data: data,
                horizontalSpacing: max(horizontalSpacing ?? defaultSpacing, 0),
                id: id,
                itemContent: itemContent,
                lines: lines,
                lineSpan: lineSpan,
                size: geometry.size,
                verticalSpacing: max(verticalSpacing ?? defaultSpacing, 0)
            )
            .transaction {
                updateTransaction($0)
            }
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .onAppear { contentSize = geometry.size }
                        .onChange(of: geometry.size) { newValue in
                            DispatchQueue.main.async {
                                withTransaction(transaction) {
                                    contentSize = newValue
                                }
                            }
                        }
                }
                .hidden()
            )
        }
        .frame(
            width: axis == .horizontal ? contentSize.width : nil,
            height: axis == .vertical ? contentSize.height : nil
        )
    }
    
    @State private var contentSize = CGSize.zero
    @State private var transaction = Transaction()
    
    private var axis: Axis
    private var content: (() -> Content)?
    private var data: Data?
    private var horizontalSpacing: CGFloat?
    private var id: KeyPath<Data.Element, ID>?
    private var itemContent: ((Data.Element) -> Content)?
    private var lines: MasonryLines
    private var lineSpan: ((Data.Element) -> MasonryLines)?
    private var verticalSpacing: CGFloat?
}


public extension Masonry
where Data == [Never],
      ID == Never
{
    /// A view that arranges its children in a masonry.
    ///
    /// This view returns a flexible preferred size, orthogonal to the layout axis, to its parent layout.
    ///
    /// - Parameters:
    ///   - axis: The layout axis of this masonry.
    ///   - lines: The number of lines in the masonry.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the masonry to choose a default distance for each pair of
    ///     subviews.
    ///   - content: A view builder that creates the content of this masonry.
    init(_ axis: Axis,
         lines: MasonryLines,
         spacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.axis = axis
        self.content = content
        self.data = nil
        self.horizontalSpacing = spacing
        self.id = nil
        self.itemContent = nil
        self.lines = lines
        self.lineSpan = nil
        self.verticalSpacing = spacing
    }
    
    /// A view that arranges its children in a masonry.
    ///
    /// This view returns a flexible preferred size, orthogonal to the layout axis, to its parent layout.
    ///
    /// - Parameters:
    ///   - axis: The layout axis of this masonry.
    ///   - lines: The number of lines in the masonry.
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - content: A view builder that creates the content of this masonry.
    init(_ axis: Axis,
         lines: MasonryLines,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.axis = axis
        self.content = content
        self.data = nil
        self.horizontalSpacing = horizontalSpacing
        self.id = nil
        self.itemContent = nil
        self.lines = lines
        self.lineSpan = nil
        self.verticalSpacing = verticalSpacing
    }
}


public extension Masonry {
    
    /// A view that arranges its children in a masonry.
    ///
    /// This view returns a flexible preferred size, orthogonal to the layout axis, to its parent layout.
    ///
    /// - Parameters:
    ///   - axis: The layout axis of this masonry.
    ///   - lines: The number of lines in the masonry.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the masonry to choose a default distance for each pair of
    ///     subviews.
    ///   - data: The data that the masonry uses to create views dynamically.
    ///   - id: The key path to the provided data's identifier.
    ///   - content: A view builder that creates the content of this masonry.
    ///   - lineSpan: The number of lines the content for a given element will
    ///     span.
    init(_ axis: Axis,
         lines: MasonryLines,
         spacing: CGFloat? = nil,
         data: Data,
         id: KeyPath<Data.Element, ID>,
         @ViewBuilder content: @escaping (Data.Element) -> Content,
         lineSpan: ((Data.Element) -> MasonryLines)? = nil)
    {
        self.axis = axis
        self.content = nil
        self.data = data
        self.horizontalSpacing = spacing
        self.id = id
        self.itemContent = content
        self.lines = lines
        self.lineSpan = lineSpan
        self.verticalSpacing = spacing
    }
    
    /// A view that arranges its children in a masonry.
    ///
    /// This view returns a flexible preferred size, orthogonal to the layout axis, to its parent layout.
    ///
    /// - Parameters:
    ///   - axis: The layout axis of this masonry.
    ///   - lines: The number of lines in the masonry.
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - data: The data that the masonry uses to create views dynamically.
    ///   - id: The key path to the provided data's identifier.
    ///   - content: A view builder that creates the content of this masonry.
    ///   - lineSpan: The number of lines the content for a given element will
    ///     span.
    init(_ axis: Axis,
         lines: MasonryLines,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         data: Data,
         id: KeyPath<Data.Element, ID>,
         @ViewBuilder content: @escaping (Data.Element) -> Content,
         lineSpan: ((Data.Element) -> MasonryLines)? = nil)
    {
        self.axis = axis
        self.content = nil
        self.data = data
        self.horizontalSpacing = horizontalSpacing
        self.id = id
        self.itemContent = content
        self.lines = lines
        self.lineSpan = lineSpan
        self.verticalSpacing = verticalSpacing
    }
}


public extension Masonry
where Data.Element : Identifiable,
      Data.Element.ID == ID
{
    
    /// A view that arranges its children in a masonry.
    ///
    /// This view returns a flexible preferred size, orthogonal to the layout axis, to its parent layout.
    ///
    /// - Parameters:
    ///   - axis: The layout axis of this masonry.
    ///   - lines: The number of lines in the masonry.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the masonry to choose a default distance for each pair of
    ///     subviews.
    ///   - data: The identified data that the masonry uses to create views
    ///     dynamically.
    ///   - content: A view builder that creates the content of this masonry.
    ///   - lineSpan: The number of lines the content for a given element will
    ///     span.
    init(_ axis: Axis,
         lines: MasonryLines,
         spacing: CGFloat? = nil,
         data: Data,
         @ViewBuilder content: @escaping (Data.Element) -> Content,
         lineSpan: ((Data.Element) -> MasonryLines)? = nil)
    {
        self.axis = axis
        self.content = nil
        self.data = data
        self.horizontalSpacing = spacing
        self.id = \.id
        self.itemContent = content
        self.lines = lines
        self.lineSpan = lineSpan
        self.verticalSpacing = spacing
    }
    
    /// A view that arranges its children in a masonry.
    ///
    /// This view returns a flexible preferred size, orthogonal to the layout axis, to its parent layout.
    ///
    /// - Parameters:
    ///   - axis: The layout axis of this masonry.
    ///   - lines: The number of lines in the masonry.
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - data: The identified data that the masonry uses to create views
    ///     dynamically.
    ///   - content: A view builder that creates the content of this masonry.
    ///   - lineSpan: The number of lines the content for a given element will
    ///     span.
    init(_ axis: Axis,
         lines: MasonryLines,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         data: Data,
         @ViewBuilder content: @escaping (Data.Element) -> Content,
         lineSpan: ((Data.Element) -> MasonryLines)? = nil)
    {
        self.axis = axis
        self.content = nil
        self.data = data
        self.horizontalSpacing = horizontalSpacing
        self.id = \.id
        self.itemContent = content
        self.lines = lines
        self.lineSpan = lineSpan
        self.verticalSpacing = verticalSpacing
    }
}


private extension Masonry {
    func updateTransaction(_ newValue: Transaction) {
        if transaction.animation != newValue.animation
            || transaction.disablesAnimations != newValue.disablesAnimations
            || transaction.isContinuous != newValue.isContinuous
        {
            DispatchQueue.main.async {
                transaction = newValue
            }
        }
    }
}
