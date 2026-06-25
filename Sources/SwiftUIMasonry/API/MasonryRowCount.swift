/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2026
*  MIT license, see LICENSE file for details
*/

import SwiftUI

/// Constants that define the number of rows in a HMasonry layout.
public enum MasonryRowCount: Equatable, ExpressibleByIntegerLiteral, Sendable, SendableMetatype {
    
    /// A variable number of rows.
    ///
    /// This case uses the provided `heightConstraint` to decide the exact
    /// number of rows.
    case adaptive(heightConstraint: AdaptiveHeightConstraint)
    
    /// A constant number of rows.
    case fixed(Int)
}


public extension MasonryRowCount {
    
    /// A variable number of rows.
    ///
    /// This case uses the provided `minHeight` to decide the exact number of
    /// rows.
    static func adaptive(minHeight: CGFloat) -> MasonryRowCount {
        .adaptive(heightConstraint: .min(minHeight))
    }
    
    /// A variable number of rows.
    ///
    /// This case uses the provided `maxHeight` to decide the exact number of
    /// rows.
    static func adaptive(maxHeight: CGFloat) -> MasonryRowCount {
        .adaptive(heightConstraint: .max(maxHeight))
    }
}


public extension MasonryRowCount {
    
    /// Constants that constrain the bounds of an adaptive row in a
    /// HMasonry layout.
    enum AdaptiveHeightConstraint: Equatable, Sendable, SendableMetatype {
        
        /// The minimum height of a row in a given axis.
        case min(CGFloat)
        
        /// The maximum height of a row in a given axis.
        case max(CGFloat)
    }
}


public extension MasonryRowCount {
    init(integerLiteral value: Int) {
        self = .fixed(value)
    }
}
