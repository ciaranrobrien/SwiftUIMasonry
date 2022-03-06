# SwiftUI Masonry

SwiftUI views that arrange their children in a Pinterest-like layout.

![Demo](./Resources/Demo.gif "Demo")

## HMasonry
A view that arranges its children in a horizontal masonry.

### Usage
```swift
ScrollView(.horizontal) {
    HMasonry(rows: 2) {
        //Masonry content
    }
}
```

### Parameters
* `rows`: The number of rows in the masonry.
* `placementMode`: The placement of subviews in the masonry.
* `horizontalSpacing`: The distance between horizontally adjacent subviews, or `nil` if you want the masonry to choose a default distance for each pair of subviews.
* `verticalSpacing`: The distance between vertically adjacent subviews, or `nil` if you want the masonry to choose a default distance for each pair of subviews.
* `content`: A view builder that creates the content of this masonry.

## VMasonry
A view that arranges its children in a vertical masonry.

### Usage
```swift
ScrollView(.vertical) {
    VMasonry(columns: 2) {
        //Masonry content
    }
}
```

### Parameters
* `columns`: The number of columns in the masonry.
* `placementMode`: The placement of subviews in the masonry.
* `horizontalSpacing`: The distance between horizontally adjacent subviews, or `nil` if you want the masonry to choose a default distance for each pair of subviews.
* `verticalSpacing`: The distance between vertically adjacent subviews, or `nil` if you want the masonry to choose a default distance for each pair of subviews.
* `content`: A view builder that creates the content of this masonry.

## Masonry
A view that arranges its children in a masonry.

### Usage
```swift
ScrollView(.vertical) {
    Masonry(.vertical, lines: 2) {
        //Masonry content
    }
}
```

### Parameters
* `axis`: The layout axis of this masonry.
* `columns`: The number of columns in the masonry.
* `placementMode`: The placement of subviews in the masonry.
* `horizontalSpacing`: The distance between horizontally adjacent subviews, or `nil` if you want the masonry to choose a default distance for each pair of subviews.
* `verticalSpacing`: The distance between vertically adjacent subviews, or `nil` if you want the masonry to choose a default distance for each pair of subviews.
* `content`: A view builder that creates the content of this masonry.

## Requirements

* iOS 14.0+, macOS 11.0+, tvOS 14.0+ or watchOS 7.0+
* Xcode 12.0+

## Installation

* Install with [Swift Package Manager](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).
* Import `SwiftUIMasonry` to start using.

## Contact

[@ciaranrobrien](https://twitter.com/ciaranrobrien) on Twitter.

