/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2022
*  MIT license, see LICENSE file for details
*/

import SwiftUI

public struct Masonry<Content>: View
where Content : View
{
    public var body: some View {
        GeometryReader { geometry in
            MasonryLayout(axis: axis,
                          content: content,
                          horizontalSpacing: max(horizontalSpacing ?? 8, 0),
                          lines: wrappedLines,
                          placementMode: placementMode,
                          size: geometry.size,
                          verticalSpacing: max(verticalSpacing ?? 8, 0))
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
        .frame(width: axis == .horizontal ? contentSize.width : nil,
               height: axis == .vertical ? contentSize.height : nil)
    }
    
    @State private var contentSize = CGSize.zero
    @State private var transaction = Transaction()
    
    private var axis: Axis
    private var content: () -> Content
    private var horizontalSpacing: CGFloat?
    private var lines: MasonryLines
    private var placementMode: MasonryPlacementMode
    private var verticalSpacing: CGFloat?
}


public extension Masonry {
    /// A view that arranges its children in a masonry.
    ///
    /// This view returns a flexible preferred size, orthogonal to the layout axis, to its parent layout.
    ///
    /// - Parameters:
    ///   - axis: The layout axis of this masonry.
    ///   - lines: The number of lines in the masonry.
    ///   - placementMode: The placement of subviews in the masonry.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the masonry to choose a default distance for each pair of
    ///     subviews.
    ///   - content: A view builder that creates the content of this masonry.
    init(_ axis: Axis,
         lines: MasonryLines,
         placementMode: MasonryPlacementMode = .fill,
         spacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.axis = axis
        self.content = content
        self.horizontalSpacing = spacing
        self.lines = lines
        self.placementMode = placementMode
        self.verticalSpacing = spacing
    }
    
    /// A view that arranges its children in a masonry.
    ///
    /// This view returns a flexible preferred size, orthogonal to the layout axis, to its parent layout.
    ///
    /// - Parameters:
    ///   - axis: The layout axis of this masonry.
    ///   - lines: The number of lines in the masonry.
    ///   - placementMode: The placement of subviews in the masonry.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the masonry to choose a default distance for each pair of
    ///     subviews.
    ///   - content: A view builder that creates the content of this masonry.
    init(_ axis: Axis,
         lines: Int,
         placementMode: MasonryPlacementMode = .fill,
         spacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.axis = axis
        self.content = content
        self.horizontalSpacing = spacing
        self.lines = .fixed(lines)
        self.placementMode = placementMode
        self.verticalSpacing = spacing
    }
    
    /// A view that arranges its children in a masonry.
    ///
    /// This view returns a flexible preferred size, orthogonal to the layout axis, to its parent layout.
    ///
    /// - Parameters:
    ///   - axis: The layout axis of this masonry.
    ///   - lines: The number of lines in the masonry.
    ///   - placementMode: The placement of subviews in the masonry.
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - content: A view builder that creates the content of this masonry.
    init(_ axis: Axis,
         lines: MasonryLines,
         placementMode: MasonryPlacementMode = .fill,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.axis = axis
        self.content = content
        self.horizontalSpacing = horizontalSpacing
        self.lines = lines
        self.placementMode = placementMode
        self.verticalSpacing = verticalSpacing
    }
    
    /// A view that arranges its children in a masonry.
    ///
    /// This view returns a flexible preferred size, orthogonal to the layout axis, to its parent layout.
    ///
    /// - Parameters:
    ///   - axis: The layout axis of this masonry.
    ///   - lines: The number of lines in the masonry.
    ///   - placementMode: The placement of subviews in the masonry.
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the masonry to choose a default distance
    ///     for each pair of subviews.
    ///   - content: A view builder that creates the content of this masonry.
    init(_ axis: Axis,
         lines: Int,
         placementMode: MasonryPlacementMode = .fill,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.axis = axis
        self.content = content
        self.horizontalSpacing = horizontalSpacing
        self.lines = .fixed(lines)
        self.placementMode = placementMode
        self.verticalSpacing = verticalSpacing
    }
}


private extension Masonry {
    var wrappedLines: MasonryLines {
        switch lines {
        case .adaptive(let minSize, let maxSize):
            return .adaptive(minSize: max(0, minSize), maxSize: max(0, maxSize))
        default:
            return lines
        }
    }
    
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
