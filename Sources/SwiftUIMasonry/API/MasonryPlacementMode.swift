/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2022
*  MIT license, see LICENSE file for details
*/

/// Constants that define how a masonry's subviews are placed in the available space.
public enum MasonryPlacementMode: Hashable, CaseIterable {
    
    /// Place each subview in the line with the most available space.
    case fill
    
    /// Place each subview in view tree order.
    case order
}
