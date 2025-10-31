/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2025
*  MIT license, see LICENSE file for details
*/

import SwiftUI

/// Constants that define the number of lines in a masonry view.
public enum MasonryLines: ExpressibleByIntegerLiteral {
    
    /// A variable number of lines.
    ///
    /// This case uses the provided `lengthConstraint` to decide the exact
    /// number of lines.
    case adaptive(lengthConstraint: AdaptiveLengthConstraint)
    
    /// A constant number of lines.
    case fixed(Int)
}


public extension MasonryLines {
    
    /// A variable number of lines.
    ///
    /// This case uses the provided `minLength` to decide the exact number of
    /// lines.
    static func adaptive(minLength: CGFloat) -> MasonryLines {
        .adaptive(lengthConstraint: .min(minLength))
    }
    
    /// A variable number of lines.
    ///
    /// This case uses the provided `maxLength` to decide the exact number of
    /// lines.
    static func adaptive(maxLength: CGFloat) -> MasonryLines {
        .adaptive(lengthConstraint: .max(maxLength))
    }
}


public extension MasonryLines {
    /// Constants that constrain the bounds of an adaptive line in a masonry
    /// view.
    enum AdaptiveLengthConstraint: Equatable {
        
        /// The minimum length of a line in a given axis.
        case min(CGFloat)
        
        /// The maximum length of a line in a given axis.
        case max(CGFloat)
    }
}


public extension MasonryLines {
    init(integerLiteral value: Int) {
        self = .fixed(value)
    }
}
