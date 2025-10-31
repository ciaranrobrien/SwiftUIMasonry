/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2025
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
    var lineLength: CGFloat
    var lineSpan: ((Data.Element) -> MasonryLines)?
    var verticalSpacing: CGFloat
    
    var body: some View {
        ForEach(data, id: id) { element in
            let length = itemLength(element)
            
            content(element)
                .frame(width: axis == .vertical ? length : nil, height: axis == .horizontal ? length : nil)
        }
    }
    
    private var currentSpacing: CGFloat {
        switch axis {
        case .horizontal: return verticalSpacing
        case .vertical: return horizontalSpacing
        }
    }
    
    private func itemLength(_ element: Data.Element) -> CGFloat {
        guard lineLength > 0
        else { return 0 }
        
        let elementLines = lineSpan?(element) ?? .fixed(1)
        var lineSpan: Int

        switch elementLines {
        case .adaptive(let lengthConstraint):
            switch lengthConstraint {
            case .min(let length):
                let value = floor(length / lineLength)
                lineSpan = Int(value.isFinite ? value : 0)
                
            case .max(let length):
                let value = ceil(length / lineLength)
                lineSpan = Int(value.isFinite ? value : 0)
            }
            
        case .fixed(let count):
            lineSpan = count
        }
        
        return ((lineLength + currentSpacing) * CGFloat(min(max(lineSpan, 1), lineCount))) - currentSpacing
    }
}
