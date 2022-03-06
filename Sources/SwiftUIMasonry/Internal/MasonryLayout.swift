/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2022
*  MIT license, see LICENSE file for details
*/

import SwiftUI

internal struct MasonryLayout<Content>: View
where Content : View
{
    var axis: Axis
    var content: () -> Content
    var horizontalSpacing: CGFloat
    var lines: MasonryLines
    var placementMode: MasonryPlacementMode
    var size: CGSize
    var verticalSpacing: CGFloat
    
    var body: some View {
        var alignments = Array(repeating: CGFloat.zero, count: lineCount)
        var currentIndex = defaultIndex
        var top: CGFloat = 0
        
        ZStack(alignment: .topLeading) {
            content()
                .frame(minWidth: minWidth, maxWidth: maxWidth, minHeight: minHeight, maxHeight: maxHeight)
                .frame(width: axis == .vertical ? lineSize : nil, height: axis == .horizontal ? lineSize : nil)
                .fixedSize(horizontal: axis == .horizontal, vertical: axis == .vertical)
                .alignmentGuide(.leading) { dimensions in
                    switch placementMode {
                    case .fill:
                        currentIndex = alignments
                            .enumerated()
                            .sorted { $0.element > $1.element }
                            .first!
                            .offset
                        
                    case .order:
                        currentIndex += 1
                        
                        if currentIndex >= lineCount {
                            currentIndex = 0
                        }
                    }
                    
                    switch axis {
                    case .horizontal:
                        let leading = alignments[currentIndex]
                        top = CGFloat(-currentIndex) * (lineSize + verticalSpacing)
                        alignments[currentIndex] -= (dimensions.width + horizontalSpacing)
                        return leading
                        
                    case .vertical:
                        top = alignments[currentIndex]
                        alignments[currentIndex] -= (dimensions.height + verticalSpacing)
                        return CGFloat(-currentIndex) * (lineSize + horizontalSpacing)
                    }
                }
                .alignmentGuide(.top) { _ in
                    top
                }
            
            Color.clear
                .frame(width: 1, height: 1)
                .hidden()
                .alignmentGuide(.leading) { _ in
                    alignments = Array(repeating: .zero, count: lineCount)
                    currentIndex = defaultIndex
                    top = 0
                    return 0
                }
        }
        .offset(offset)
    }
    
    private var defaultIndex: Int {
        switch placementMode {
        case .fill: return 0
        case .order: return -1
        }
    }
    private var lineCount: Int {
        let currentSize: CGFloat
        let currentSpacing: CGFloat
        
        switch axis {
        case .horizontal:
            currentSize = size.height
            currentSpacing = verticalSpacing
        case .vertical:
            currentSize = size.width
            currentSpacing = horizontalSpacing
        }
        
        let count: Int
        let minCount = 1
        let maxCount = max(Int(ceil((currentSize + currentSpacing) / (1 + currentSpacing))), 1)
        
        switch lines {
        case .adaptive(let minSize, _):
            count = Int(floor((currentSize + currentSpacing) / (minSize + currentSpacing)))
        case .fixed(let fixedCount):
            count = fixedCount
        }
        
        return min(max(count, minCount), maxCount)
    }
    private var lineSize: CGFloat {
        let currentSize: CGFloat
        let currentSpacing: CGFloat
        
        switch axis {
        case .horizontal:
            currentSize = size.height
            currentSpacing = verticalSpacing
        case .vertical:
            currentSize = size.width
            currentSpacing = horizontalSpacing
        }
        
        let lineSize = max((currentSize - (currentSpacing * CGFloat(lineCount - 1))) / CGFloat(lineCount), 0)
        
        switch lines {
        case .adaptive(_, let maxSize): return min(maxSize, lineSize)
        case .fixed: return lineSize
        }
    }
    private var maxHeight: CGFloat? {
        switch lines {
        case .adaptive(_, let maxSize):
            switch axis {
            case .horizontal: return maxSize
            case .vertical: return nil
            }
        case .fixed: return nil
        }
    }
    private var maxWidth: CGFloat? {
        switch lines {
        case .adaptive(_, let maxSize):
            switch axis {
            case .horizontal: return nil
            case .vertical: return maxSize
            }
        case .fixed: return nil
        }
    }
    private var minHeight: CGFloat? {
        switch lines {
        case .adaptive(let minSize, let maxSize):
            switch axis {
            case .horizontal: return min(minSize, maxSize)
            case .vertical: return nil
            }
        case .fixed: return nil
        }
    }
    private var minWidth: CGFloat? {
        switch lines {
        case .adaptive(let minSize, let maxSize):
            switch axis {
            case .horizontal: return nil
            case .vertical: return min(minSize, maxSize)
            }
        case .fixed: return nil
        }
    }
    private var offset: CGSize {
        switch axis {
        case .horizontal:
            let padding = size.height - (lineSize * CGFloat(lineCount)) - (verticalSpacing * CGFloat(lineCount - 1))
            return CGSize(width: 0, height: padding / 2)
        case .vertical:
            let padding = size.width - (lineSize * CGFloat(lineCount)) - (horizontalSpacing * CGFloat(lineCount - 1))
            return CGSize(width: padding / 2, height: 0)
        }
    }
}
