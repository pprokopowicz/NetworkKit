NetworkKit
========
NetworkKit is a simple, easy to use and lightweight netowkring library written in pure Swift. It uses `URLSession` under the hood.

## Platforms

- iOS 13+
- macOS 10.15+
- tvOS 13+
- watchOS 6+

## Installation

### Swift Package Manager

in `Package.swift` add the following:

```swift
dependencies: [
    ...
    .package(url: "https://github.com/pprokopowicz/NetworkKit.git", from: "0.6.0")
]
```

## Usage

- Create a base `NetworkEnvironment` which will provide base URL for your requests.
- Create new struct conforming to `NetworkRequest` protocol.
- Use `NetworkClient` to fetch data from the request.

For more detailed example chek out [example project](NetworkKitExample).

## Todo

- Rework middleware support.

## License

MIT license. See the [LICENSE file](LICENSE.md) for details.
