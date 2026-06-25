/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2026
*  MIT license, see LICENSE file for details
*/

import SwiftUI

/// Constants that define the number of columns in a VMasonry layout.
public enum MasonryColumnCount: Equatable, ExpressibleByIntegerLiteral, Sendable, SendableMetatype {
    
    /// A variable number of columns.
    ///
    /// This case uses the provided `widthConstraint` to decide the exact
    /// number of columns.
    case adaptive(widthConstraint: AdaptiveWidthConstraint)
    
    /// A constant number of columns.
    case fixed(Int)
}


public extension MasonryColumnCount {
    
    /// A variable number of columns.
    ///
    /// This case uses the provided `minWidth` to decide the exact number of
    /// columns.
    static func adaptive(minWidth: CGFloat) -> MasonryColumnCount {
        .adaptive(widthConstraint: .min(minWidth))
    }
    
    /// A variable number of columns.
    ///
    /// This case uses the provided `maxWidth` to decide the exact number of
    /// columns.
    static func adaptive(maxWidth: CGFloat) -> MasonryColumnCount {
        .adaptive(widthConstraint: .max(maxWidth))
    }
}


public extension MasonryColumnCount {
    
    /// Constants that constrain the bounds of an adaptive column in a
    /// VMasonry layout.
    enum AdaptiveWidthConstraint: Equatable, Sendable, SendableMetatype {
        
        /// The minimum width of a column in a given axis.
        case min(CGFloat)
        
        /// The maximum width of a column in a given axis.
        case max(CGFloat)
    }
}


public extension MasonryColumnCount {
    init(integerLiteral value: Int) {
        self = .fixed(value)
    }
}
