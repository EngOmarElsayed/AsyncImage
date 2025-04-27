//
//  Image+Extension.swift
//  AsyncImageApp
//
//  Created by Omar Elsayed on 21/04/2025.
//

import SwiftUI

public extension Image {
    /// Creates a SwiftUI `Image` from raw image data.
    ///
    /// This initializer attempts to create a SwiftUI `Image` from the provided data.
    /// It first tries to convert the data to a platform-specific image object and then
    /// wraps it as a SwiftUI `Image`.
    ///
    /// - Parameter data: The raw image data to convert into an image.
    ///
    /// - Note: This initializer supports all image formats that the platform's native image type supports,
    ///   including PNG, JPEG, GIF, HEIC, and others.
    ///
    /// ## Example
    /// ```swift
    /// if let imageData = try? Data(contentsOf: imageURL),
    ///    let image = Image(data: imageData) {
    ///     image
    ///         .resizable()
    ///         .aspectRatio(contentMode: .fit)
    /// } else {
    ///     Text("Failed to load image")
    /// }
    /// ```
    init?(data: Data) {
        #if os(iOS) || os(tvOS) || os(watchOS)
        guard let uiImage = UIImage(data: data) else { return nil }
        self.init(uiImage: uiImage)
        #elseif os(macOS)
        guard let nsImage = NSImage(data: data) else { return nil }
        self.init(nsImage: nsImage)
        #else
        return nil
        #endif
    }
}
