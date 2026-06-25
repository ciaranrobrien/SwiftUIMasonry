/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2026
*  MIT license, see LICENSE file for details
*/

import SwiftUI

public extension VMasonry {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
        let size = proposal.replacingUnspecifiedDimensions()
        
        if let cachedValues = cache.widthValues[size.width] {
            return cachedValues.sizeThatFits
        }
        
        let columnCount = columnCount(size: size)
        let columnWidth = max((size.width - (horizontalSpacing * CGFloat(columnCount - 1))) / CGFloat(columnCount), 0)
        
        var currentColumnIndex = 0
        var columnHeights = Array(repeating: CGFloat.zero, count: columnCount)
        var subviewRects = Array(repeating: CGRect.zero, count: subviews.count)
        
        for subviewIndex in subviews.indices {
            let subview = subviews[subviewIndex]
            let subviewColumnSpan = subview[MasonryColumnSpanKey.self]
            let subviewColumnCount: Int

            switch subviewColumnSpan {
            case .adaptive(let widthConstraint):
                switch widthConstraint {
                case .min(let minWidth):
                    let value = floor(minWidth / columnWidth)
                    subviewColumnCount = Int(value.isFinite ? value : 0)
                    
                case .max(let maxWidth):
                    let value = ceil(maxWidth / columnWidth)
                    subviewColumnCount = Int(value.isFinite ? value : 0)
                }
            case .fixed(let count):
                subviewColumnCount = count
            }
            
            let subviewSize = subview.sizeThatFits(.init(
                width: ((columnWidth + horizontalSpacing) * CGFloat(subviewColumnCount)) - horizontalSpacing,
                height: nil
            ))
            
            let subviewColumnIndices: Range<Int>
            let subviewMaxColumnHeight: CGFloat
            
            switch placementMode {
            case .fill:
                (subviewColumnIndices, subviewMaxColumnHeight) = columnHeights.indices
                    .compactMap { columnIndex -> (subviewColumnIndices: Range<Int>, subviewMaxColumnHeight: CGFloat)? in
                        let endColumnIndex = columnIndex + subviewColumnCount
                        
                        guard columnHeights.endIndex >= endColumnIndex || columnIndex == 0
                        else { return nil }
                        
                        let subviewColumnIndices = columnIndex..<min(endColumnIndex, columnHeights.endIndex)
                        let subviewMaxColumnHeight = subviewColumnIndices.map { columnHeights[$0] }.max()!
                        return (subviewColumnIndices, subviewMaxColumnHeight)
                    }
                    .min {
                        $0.subviewMaxColumnHeight < $1.subviewMaxColumnHeight
                    }!
                
                currentColumnIndex = subviewColumnIndices.lowerBound
                
            case .order:
                if currentColumnIndex + subviewColumnCount > columnCount {
                    currentColumnIndex = 0
                }
                
                subviewColumnIndices = currentColumnIndex..<(currentColumnIndex + subviewColumnCount)
                subviewMaxColumnHeight = subviewColumnIndices.map { columnHeights[$0] }.max() ?? .zero
            }
            
            let updatedColumnHeight = subviewMaxColumnHeight + subviewSize.height + verticalSpacing
            let subviewOrigin = CGPoint(
                x: CGFloat(currentColumnIndex) * (columnWidth + horizontalSpacing),
                y: subviewMaxColumnHeight
            )
            
            subviewRects[subviewIndex] = CGRect(origin: subviewOrigin, size: subviewSize)
            
            for subviewColumnIndex in subviewColumnIndices {
                columnHeights[subviewColumnIndex] = updatedColumnHeight
            }
            
            switch placementMode {
            case .fill: break
            case .order: currentColumnIndex += subviewColumnCount
            }
            
        }
        
        let maxColumnHeight = columnHeights.max() ?? .zero
        let sizeThatFits = CGSize(
            width: size.width,
            height: maxColumnHeight == .zero ? .zero : maxColumnHeight - verticalSpacing
        )
        
        cache.widthValues[size.width] = CachedValues(sizeThatFits: sizeThatFits, subviewRects: subviewRects)
        return sizeThatFits
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
        guard let subviewRects = cache.widthValues[bounds.width]?.subviewRects
        else { return }
        
        for subviewIndex in subviews.indices {
            let subview = subviews[subviewIndex]
            let subviewRect = subviewRects[subviewIndex]
            
            subview.place(
                at: .init(x: subviewRect.origin.x + bounds.origin.x, y: subviewRect.origin.y + bounds.origin.y),
                proposal: .init(subviewRect.size)
            )
        }
    }
    
    func makeCache(subviews: Subviews) -> Cache {
        Cache()
    }
    
    func updateCache(_ cache: inout Cache, subviews: Subviews) {
        cache.widthValues.removeAll()
    }
    
    struct Cache {
        internal var widthValues = [CGFloat : CachedValues]()
    }
}


internal extension VMasonry {
    struct CachedValues: Equatable {
        let sizeThatFits: CGSize
        let subviewRects: [CGRect]
    }
    
    func columnCount(size: CGSize) -> Int {
        let count: Int
        let minCount = 1
        let maxCount = max(Int(ceil((size.width + horizontalSpacing) / (1 + horizontalSpacing))), 1)
        
        switch columnCount {
        case .adaptive(let widthConstraint):
            switch widthConstraint {
            case .min(let minWidth):
                let value = floor((size.width + horizontalSpacing) / (max(minWidth, 0) + horizontalSpacing))
                count = Int(value.isFinite ? value : 0)
                
            case .max(let maxWidth):
                let value = ceil((size.width + horizontalSpacing) / (max(maxWidth, 0) + horizontalSpacing))
                count = Int(value.isFinite ? value : 0)
            }
            
        case .fixed(let fixedCount):
            count = fixedCount
        }
        
        return min(max(count, minCount), maxCount)
    }
}
