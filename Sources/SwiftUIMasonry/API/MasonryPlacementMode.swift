/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2026
*  MIT license, see LICENSE file for details
*/

import SwiftUI

/// Constants that define how a masonry's subviews are placed in the available
/// space.
public enum MasonryPlacementMode: CaseIterable, Hashable, Sendable, SendableMetatype {
    
    /// Place each subview in the column/row with the most available space. This is the
    /// default behaviour.
    case fill
    
    /// Place each subview in view tree order.
    case order
}
