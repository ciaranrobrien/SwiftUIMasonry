/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2022
*  MIT license, see LICENSE file for details
*/

import SwiftUI

internal struct MasonryDynamicViewBuilder<Data, ID, Content>: View
where Data : RandomAccessCollection,
      ID : Hashable,
      Content : View
{
    var axis: Axis
    var content: (Data.Element) -> Content
    var data: Data
    var horizontalSpacing: CGFloat
    var id: KeyPath<Data.Element, ID>
    var lineCount: Int
    var lineSize: CGFloat
    var lineSpan: ((Data.Element) -> MasonryLines)?
    var verticalSpacing: CGFloat
    
    var body: some View {
        ForEach(data, id: id) { element in
            let size = itemSize(element)
            
            content(element)
                .frame(width: axis == .vertical ? size : nil, height: axis == .horizontal ? size : nil)
        }
    }
    
    private var currentSpacing: CGFloat {
        switch axis {
        case .horizontal: return verticalSpacing
        case .vertical: return horizontalSpacing
        }
    }
    
    private func itemSize(_ element: Data.Element) -> CGFloat {
        guard lineSize > 0
        else { return 0 }
        
        let elementLines = lineSpan?(element) ?? .fixed(1)
        var lineSpan: Int

        switch elementLines {
        case .adaptive(let sizeConstraint):
            switch sizeConstraint {
            case .min(let size):
                let value = floor(size / lineSize)
                lineSpan = Int(value.isFinite ? value : 0)
                
            case .max(let size):
                let value = ceil(size / lineSize)
                lineSpan = Int(value.isFinite ? value : 0)
            }
            
        case .fixed(let count):
            lineSpan = count
        }
        
        return ((lineSize + currentSpacing) * CGFloat(min(max(lineSpan, 1), lineCount))) - currentSpacing
    }
}
