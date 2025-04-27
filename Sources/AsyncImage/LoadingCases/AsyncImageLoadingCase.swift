//
//  AsyncImageLoadingCase.swift
//  AsyncImageApp
//
//  Created by Omar Elsayed on 21/04/2025.
//

import SwiftUI

/// Represents the possible states during asynchronous image loading.
///
/// `AsyncImageLoadingCase` is used to communicate the current state of an image loading operation:
/// - `.loading`: The image is currently being loaded
/// - `.success`: The image was successfully loaded
/// - `.failure`: The image failed to load with a specific error
///
/// This enum allows for handling different loading states in the UI, such as
/// displaying a loading indicator, the successfully loaded image, or an error view.
///
/// ## Topics
/// ### Checking Loading Status
/// - ``loading``
/// - ``success(_:)``
/// - ``failure(_:)``
///
/// ## See Also
/// - ``AsyncImage``
/// - ``AsyncImageError``

public enum AsyncImageLoadingCase {
    /// Indicates that the image is currently being loaded.
    ///
    /// Use this case to display a loading indicator or placeholder while waiting for
    /// the image to load.
    case loading

    /// Indicates that the image was successfully loaded.
    ///
    /// This case contains the loaded `Image` that can be displayed.
    ///
    /// - Parameter Image: The successfully loaded SwiftUI `Image`.
    ///
    case success(Image)

    /// Indicates that the image loading operation failed.
    ///
    /// This case contains an `AsyncImageError` that provides details about the failure.
    ///
    /// - Parameter AsyncImageError: The error that occurred during image loading.
    ///
    /// - Note: The loading state will transition to `.failure` if the URL is nil or invalid,
    ///   in addition to network errors, decoding errors, or other failures during the loading process.
    ///
    case failure(AsyncImageError)
}
