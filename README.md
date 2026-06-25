# SwiftUI Masonry
SwiftUI layouts that arrange their subviews in a Pinterest-like grid.

![Demo](./Resources/Demo.gif "Demo")

## VMasonry
A layout that arranges its subviews in a vertical masonry.

### Usage
```swift
ScrollView(.vertical) {
    VMasonry(columns: 2) {
        // Masonry content
    }
}
```

### Parameters
* `columns`: The number of columns in the masonry.
* `spacing`: The distance between adjacent subviews, or `nil` if you want the masonry to choose a default distance for each pair of subviews.
* `placementMode`: The placement mode for subviews in this masonry.

## HMasonry
A layout that arranges its subviews in a horizontal masonry.

### Usage
```swift
ScrollView(.horizontal) {
    HMasonry(rows: 2) {
        // Masonry content
    }
}
```

### Parameters
* `rows`: The number of rows in the masonry.
* `spacing`: The distance between adjacent subviews, or `nil` if you want the masonry to choose a default distance for each pair of subviews.
* `placementMode`: The placement mode for subviews in this masonry.

## Advanced Usage
### Layout
`VMasonry` and `HMasonry` both conform to SwiftUI's [Layout](https://developer.apple.com/documentation/swiftui/layout) protocol. Use [AnyLayout](https://developer.apple.com/documentation/swiftui/anylayout) to switch between `VMasonry`, `HMasonry` or any other layout at runtime.

### Spacing & Placement
The placement of subviews can be controlled by using the `placementMode` parameter. Provide a `MasonryPlacementMode` case:
* `fill`: Place each subview in the column/row with the most available space. This is the default behaviour.
* `order`: Place each subview in view tree order.

The distance between adjacent subviews can be controlled by using the `spacing` or `horizontalSpacing`/`verticalSpacing` parameters.
```swift
VMasonry(columns: 2, spacing: 12, placementMode: .fill) {
    // Masonry content
}

// Or

VMasonry(columns: 2, horizontalSpacing: 8, verticalSpacing: 12, placementMode: .order) {
    // Masonry content
}
```

### Columns & Rows
The `masonryColumnSpan`/`masonryRowSpan` view modifiers can be used to control the number of columns/rows a subview will span in a parent masonry layout. Subviews span 1 column/row by default.

The `columns`/`rows` masonry parameters and `masonryColumnSpan`/`masonryRowSpan` view modifiers can either be provided with an `Int` or with a `MasonryColumnCount`/`MasonryRowCount`:
* `adaptive`: A variable number of columns/rows. This case uses the provided constraint to decide the exact number of columns/rows.
* `fixed`: A constant number of columns/rows.

```swift
VMasonry(columns: .adaptive(minWidth: 128)) {
    // Other masonry content

    MyCellView()
        .masonryColumnSpan(.fixed(2))
    
    // Other masonry content
}
```

## Requirements
* iOS 16.0+, macOS 13.0+, tvOS 16.0+, visionOS 1.0+ or watchOS 9.0+
* Xcode 26.0+

## Installation
* Install with [Swift Package Manager](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).
* Import `SwiftUIMasonry` to start using.
