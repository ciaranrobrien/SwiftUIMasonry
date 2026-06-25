/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2026
*  MIT license, see LICENSE file for details
*/

import SwiftUI

public extension HMasonry {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
        let size = proposal.replacingUnspecifiedDimensions()
        
        if let cachedValues = cache.heightValues[size.height] {
            return cachedValues.sizeThatFits
        }
        
        let rowCount = rowCount(size: size)
        let rowHeight = max((size.height - (verticalSpacing * CGFloat(rowCount - 1))) / CGFloat(rowCount), 0)
        
        var currentRowIndex = 0
        var rowWidths = Array(repeating: CGFloat.zero, count: rowCount)
        var subviewRects = Array(repeating: CGRect.zero, count: subviews.count)
        
        for subviewIndex in subviews.indices {
            let subview = subviews[subviewIndex]
            let subviewRowSpan = subview[MasonryRowSpanKey.self]
            let subviewRowCount: Int

            switch subviewRowSpan {
            case .adaptive(let heightConstraint):
                switch heightConstraint {
                case .min(let minHeight):
                    let value = floor(minHeight / rowHeight)
                    subviewRowCount = Int(value.isFinite ? value : 0)
                    
                case .max(let maxHeight):
                    let value = ceil(maxHeight / rowHeight)
                    subviewRowCount = Int(value.isFinite ? value : 0)
                }
            case .fixed(let count):
                subviewRowCount = count
            }
            
            let subviewSize = subview.sizeThatFits(.init(
                width: nil,
                height: ((rowHeight + verticalSpacing) * CGFloat(subviewRowCount)) - verticalSpacing
            ))
            
            let subviewColumnIndices: Range<Int>
            let subviewMaxRowWidth: CGFloat
            
            switch placementMode {
            case .fill:
                (subviewColumnIndices, subviewMaxRowWidth) = rowWidths.indices
                    .compactMap { rowIndex -> (subviewColumnIndices: Range<Int>, subviewMaxRowWidth: CGFloat)? in
                        let endRowIndex = rowIndex + subviewRowCount
                        
                        guard rowWidths.endIndex >= endRowIndex || rowIndex == 0
                        else { return nil }
                        
                        let subviewColumnIndices = rowIndex..<min(endRowIndex, rowWidths.endIndex)
                        let subviewMaxRowWidth = subviewColumnIndices.map { rowWidths[$0] }.max()!
                        return (subviewColumnIndices, subviewMaxRowWidth)
                    }
                    .min {
                        $0.subviewMaxRowWidth < $1.subviewMaxRowWidth
                    }!
                
                currentRowIndex = subviewColumnIndices.lowerBound
                
            case .order:
                if currentRowIndex + subviewRowCount > rowCount {
                    currentRowIndex = 0
                }
                
                subviewColumnIndices = currentRowIndex..<(currentRowIndex + subviewRowCount)
                subviewMaxRowWidth = subviewColumnIndices.map { rowWidths[$0] }.max() ?? .zero
            }
            
            let updatedRowWidth = subviewMaxRowWidth + subviewSize.width + horizontalSpacing
            let subviewOrigin = CGPoint(
                x: updatedRowWidth,
                y: CGFloat(currentRowIndex) * (rowHeight + verticalSpacing)
            )
            
            subviewRects[subviewIndex] = CGRect(origin: subviewOrigin, size: subviewSize)
            
            for subviewColumnIndex in subviewColumnIndices {
                rowWidths[subviewColumnIndex] = updatedRowWidth
            }
            
            switch placementMode {
            case .fill: break
            case .order: currentRowIndex += subviewRowCount
            }
            
        }
        
        let maxRowWidth = rowWidths.max() ?? .zero
        let sizeThatFits = CGSize(
            width: maxRowWidth == .zero ? .zero : maxRowWidth - horizontalSpacing,
            height: size.height,
        )
        
        cache.heightValues[size.height] = CachedValues(sizeThatFits: sizeThatFits, subviewRects: subviewRects)
        return sizeThatFits
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
        guard let subviewRects = cache.heightValues[bounds.height]?.subviewRects
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
        cache.heightValues.removeAll()
    }
    
    struct Cache {
        internal var heightValues = [CGFloat : CachedValues]()
    }
}


internal extension HMasonry {
    struct CachedValues: Equatable {
        let sizeThatFits: CGSize
        let subviewRects: [CGRect]
    }
    
    func rowCount(size: CGSize) -> Int {
        let count: Int
        let minCount = 1
        let maxCount = max(Int(ceil((size.height + verticalSpacing) / (1 + verticalSpacing))), 1)
        
        switch rowCount {
        case .adaptive(let heightConstraint):
            switch heightConstraint {
            case .min(let minHeight):
                let value = floor((size.height + verticalSpacing) / (max(minHeight, 0) + verticalSpacing))
                count = Int(value.isFinite ? value : 0)
                
            case .max(let maxHeight):
                let value = ceil((size.height + verticalSpacing) / (max(maxHeight, 0) + verticalSpacing))
                count = Int(value.isFinite ? value : 0)
            }
            
        case .fixed(let fixedCount):
            count = fixedCount
        }
        
        return min(max(count, minCount), maxCount)
    }
}
