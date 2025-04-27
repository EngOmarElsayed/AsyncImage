# AsyncImage

A lightweight, customizable Swift Package for asynchronously loading and displaying images with flexible caching options.

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FEngOmarElsayed%2FAsyncImage%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/EngOmarElsayed/AsyncImage)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FEngOmarElsayed%2FAsyncImage%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/EngOmarElsayed/AsyncImage)

[![Swift](https://img.shields.io/badge/Swift-5.5+-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-15.0+-blue.svg)](https://developer.apple.com/ios/)
[![macOS](https://img.shields.io/badge/macOS-13.0+-blue.svg)](https://developer.apple.com/macos/)
[![watchOS](https://img.shields.io/badge/watchOS-6.0+-blue.svg)](https://developer.apple.com/watchos/)

## Features

- ✅ Asynchronous image loading from URLs
- ✅ State-based content display (loading, success, failure)
- ✅ Flexible caching policies for memory management
- ✅ Cross-platform support (iOS, macOS, watchOS)
- ✅ SwiftUI integration
- ✅ Compatibale with Swift 6

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/engomarelsayed/AsyncImage.git", from: "1.0.0")
]
```

Or add it directly in Xcode:
1. Go to `File` > `Add Packages...`
2. Paste the repository URL: `https://github.com/engomarelsayed/AsyncImage.git`
3. Click `Add Package`

## Usage

### Basic Usage

```swift
import AsyncImage
import SwiftUI

struct ContentView: View {
    var body: some View {
        AsyncImage(cachingPolicy: .duringAppSession, from: URL(string: "https://example.com/image.jpg")) { phase in
            switch phase {
            case .loading:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
            }
        }
    }
}
```

### Caching Policies

AsyncImage offers two caching policies:

```swift
// Cache only while the view is active
AsyncImage(cachingPolicy: .withViewCycle, from: imageURL) { ... }

// Cache for the entire app session
AsyncImage(cachingPolicy: .duringAppSession, from: imageURL) { ... }
```

## Documentation

For detailed API documentation, visit:
[AsyncImage Documentation](https://engomarelsayed.github.io/AsyncImage/documentation/asyncimage)

## Requirements

- Swift 5.7+
- iOS 15.0+
- macOS 13.0+
- watchOS 6.0+
- tvOS 14.0+

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

AsyncImage is available under the MIT license. See the LICENSE file for more info.
