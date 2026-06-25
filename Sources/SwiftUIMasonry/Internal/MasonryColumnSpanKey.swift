/**
*  SwiftUIMasonry
*  Copyright (c) Ciaran O'Brien 2026
*  MIT license, see LICENSE file for details
*/

import SwiftUI

internal struct MasonryColumnSpanKey: LayoutValueKey {
    static let defaultValue = MasonryColumnCount.fixed(1)
}
