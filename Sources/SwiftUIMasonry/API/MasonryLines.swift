/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2022
*  MIT license, see LICENSE file for details
*/

import SwiftUI

/// Constants that define the number of lines in a masonry view.
public enum MasonryLines: Equatable {
    
    /// A variable number of lines.
    ///
    /// This case places one or more lines into the masonry view, using
    /// the provided bounds to decide exactly how many lines fit. This
    /// approach prefers to insert as many lines of the `minSize` as
    /// possible but lets them increase to the `maxSize`.
    case adaptive(minSize: CGFloat, maxSize: CGFloat = .infinity)
    
    /// A constant number of lines.
    case fixed(Int)
}
