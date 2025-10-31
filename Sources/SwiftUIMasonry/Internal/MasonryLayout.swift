/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2025
*  MIT license, see LICENSE file for details
*/

import SwiftUI

internal struct MasonryLayout<Data, ID, Content>: View
where Data : RandomAccessCollection,
      ID : Hashable,
      Content : View
{
    @Environment(\.masonryPlacementMode) private var placementMode
    
    var axis: Axis
    var content: (() -> Content)?
    var data: Data?
    var horizontalSpacing: CGFloat
    var id: KeyPath<Data.Element, ID>?
    var itemContent: ((Data.Element) -> Content)?
    var lines: MasonryLines
    var lineSpan: ((Data.Element) -> MasonryLines)?
    var size: CGSize
    var verticalSpacing: CGFloat
    
    var body: some View {
        let defaultIndex = defaultIndex
        let lineCount = lineCount
        let lineLength = lineLength(for: lineCount)
        
        var alignments = Array(repeating: CGFloat.zero, count: lineCount)
        var currentIndex = defaultIndex
        var currentLineSpan = 1
        var top: CGFloat = 0
        
        ZStack(alignment: .topLeading) {
            Group {
                if let content {
                    content()
                        .frame(
                            width: axis == .vertical ? lineLength : nil,
                            height: axis == .horizontal ? lineLength : nil
                        )
                } else if let data, let id, let itemContent {
                    MasonryDynamicViewBuilder(
                        axis: axis,
                        content: itemContent,
                        data: data,
                        horizontalSpacing: horizontalSpacing,
                        id: id,
                        lineCount: lineCount,
                        lineLength: lineLength,
                        lineSpan: lineSpan,
                        verticalSpacing: verticalSpacing
                    )
                }
            }
            .fixedSize(horizontal: axis == .horizontal, vertical: axis == .vertical)
            .alignmentGuide(.leading) { dimensions in
                let dimensions = CGSize(width: dimensions.width, height: dimensions.height)
                
                return MainActor.assumeIsolated {
                    @MainActor
                    func updateCurrentLineSpan() {
                        currentLineSpan = switch axis {
                        case .horizontal:
                            Int(round((dimensions.height + verticalSpacing) / (lineLength + verticalSpacing)))
                        case .vertical:
                            Int(round((dimensions.width + horizontalSpacing) / (lineLength + horizontalSpacing)))
                        }
                    }
                    
                    switch placementMode {
                    case .fill:
                        updateCurrentLineSpan()
                        
                        currentIndex = alignments
                            .enumerated()
                            .map { enumerated -> (element: CGFloat, offset: Int) in
                                let element = (0..<currentLineSpan).reduce(enumerated.element) { alignment, span in
                                    guard alignments.indices.contains(enumerated.offset + span)
                                    else { return -.infinity }
                                    return min(alignment, alignments[enumerated.offset + span])
                                }
                                return (element, enumerated.offset)
                            }
                            .sorted { $0.element > $1.element }
                            .first!
                            .offset
                        
                    case .order:
                        currentIndex += currentLineSpan
                        
                        updateCurrentLineSpan()
                        
                        if currentIndex + currentLineSpan > lineCount {
                            currentIndex = 0
                        }
                    }
                    
                    switch axis {
                    case .horizontal:
                        let leading = alignments[currentIndex..<min(currentIndex + currentLineSpan, lineCount)].min()!
                        top = CGFloat(-currentIndex) * (lineLength + verticalSpacing)
                        for index in currentIndex..<min(currentIndex + currentLineSpan, lineCount) {
                            alignments[index] = leading - dimensions.width - horizontalSpacing
                        }
                        return leading
                        
                    case .vertical:
                        top = alignments[currentIndex..<min(currentIndex + currentLineSpan, lineCount)].min()!
                        for index in currentIndex..<min(currentIndex + currentLineSpan, lineCount) {
                            alignments[index] = top - dimensions.height - verticalSpacing
                        }
                        return CGFloat(-currentIndex) * (lineLength + horizontalSpacing)
                    }
                }
            }
            .alignmentGuide(.top) { _ in
                MainActor.assumeIsolated {
                    top
                }
            }
            
            Color.clear
                .frame(width: 1, height: 1)
                .hidden()
                .alignmentGuide(.leading) { _ in
                    MainActor.assumeIsolated {
                        alignments = Array(repeating: .zero, count: lineCount)
                        currentIndex = defaultIndex
                        currentLineSpan = 1
                        top = 0
                        return 0
                    }
                }
        }
    }
    
    private var defaultIndex: Int {
        switch placementMode {
        case .fill: return 0
        case .order: return -1
        }
    }
    private var lineCount: Int {
        let currentLength: CGFloat
        let currentSpacing: CGFloat
        
        switch axis {
        case .horizontal:
            currentLength = size.height
            currentSpacing = verticalSpacing
        case .vertical:
            currentLength = size.width
            currentSpacing = horizontalSpacing
        }
        
        var count: Int
        let minCount = 1
        let maxCount = max(Int(ceil((currentLength + currentSpacing) / (1 + currentSpacing))), 1)
        
        switch lines {
        case .adaptive(let lengthConstraint):
            switch lengthConstraint {
            case .min(let length):
                let value = floor((currentLength + currentSpacing) / (max(length, 0) + currentSpacing))
                count = Int(value.isFinite ? value : 0)
                
            case .max(let length):
                let value = ceil((currentLength + currentSpacing) / (max(length, 0) + currentSpacing))
                count = Int(value.isFinite ? value : 0)
            }
            
        case .fixed(let fixedCount):
            count = fixedCount
        }
        
        return min(max(count, minCount), maxCount)
    }
    
    private func lineLength(for lineCount: Int) -> CGFloat {
        let currentLength: CGFloat
        let currentSpacing: CGFloat
        
        switch axis {
        case .horizontal:
            currentLength = size.height
            currentSpacing = verticalSpacing
        case .vertical:
            currentLength = size.width
            currentSpacing = horizontalSpacing
        }
        
        return max((currentLength - (currentSpacing * CGFloat(lineCount - 1))) / CGFloat(lineCount), 0)
    }
}
