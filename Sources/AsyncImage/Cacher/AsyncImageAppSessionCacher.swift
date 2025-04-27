//
//  ImageCasher.swift
//  AsyncImageApp
//
//  Created by Omar Elsayed on 21/04/2025.
//

import Foundation

/// A singleton cache manager that stores image data for the duration of the application session.
///
/// `AsyncImageAppSessionCacher` provides a centralized caching mechanism for storing and retrieving
/// image data using URLs as keys. The cache persists for the lifetime of the application and allows
/// for efficient reuse of downloaded images without requiring additional network requests.
///
/// This class implements the Singleton pattern through the `shared` static property and cannot be
/// directly initialized.
///
/// ## Topics
/// ### Accessing the Cache
/// - ``shared``
///
/// ### Managing Cached Images
/// - ``fetchImageForURL(_:)``
/// - ``cacheImage(_:forURL:)``
/// - ``removeCachedImage(forURL:)``
/// - ``removeAllCachedImages()``
///
/// ## See Also
/// - ``AsyncImage``
/// - ``CachingPolicy``
final public class AsyncImageAppSessionCacher: Sendable {
    /// The shared instance of the image cacher.
    ///
    /// Use this property to access the singleton instance of the cacher. The cache is shared
    /// across the entire application, allowing for efficient reuse of image data.
    ///
    /// ## Example
    /// ```swift
    /// let cachedImageData = AsyncImageAppSessionCacher.shared.fetchImageForURL(imageURL)
    /// ```
    public static let shared = AsyncImageAppSessionCacher()

    /// The underlying cache storage mechanism.
    private let cache = _AsyncImageCacher<String, Data>()

    /// Private initializer to enforce singleton pattern.
    private init() {}

    /// Retrieves cached image data for the specified URL.
    ///
    /// This method attempts to retrieve previously cached image data associated with the given URL.
    /// The URL's absolute string is used as the cache key.
    ///
    /// - Parameter url: The URL for which to retrieve cached image data.
    ///
    /// - Returns: The cached image data if available, or `nil` if no cached data exists for the URL.
    ///
    /// ## Example
    /// ```swift
    /// if let cachedData = AsyncImageAppSessionCacher.shared.fetchImageForURL(url),
    ///    let image = Image(data: cachedData) {
    ///     // Use the cached image
    /// } else {
    ///     // Download the image
    /// }
    /// ```
    public func fetchImageForURL(_ url: URL) -> Data? {
        let urlString = url.absoluteString
        return cache.fetchCachedValue(forKey: urlString)
    }

    /// Stores image data in the cache for the specified URL.
    ///
    /// This method caches the provided image data with the URL's absolute string as the key.
    /// The data will remain cached for the duration of the application session unless explicitly removed.
    ///
    /// - Parameters:
    ///   - imageData: The image data to cache.
    ///   - url: The URL to associate with the cached image data.
    ///
    /// ## Example
    /// ```swift
    /// if let data = try? Data(contentsOf: imageURL) {
    ///     AsyncImageAppSessionCacher.shared.cacheImage(data, forURL: imageURL)
    /// }
    /// ```
    public func cacheImage(_ imageData: Data, forURL url: URL) {
        let urlString = url.absoluteString
        cache.cache(imageData, forKey: urlString)
    }

    /// Removes cached image data for the specified URL.
    ///
    /// This method removes any cached image data associated with the given URL.
    ///
    /// - Parameter url: The URL for which to remove cached image data.
    ///
    /// ## Example
    /// ```swift
    /// // Remove cached data for a specific image
    /// AsyncImageAppSessionCacher.shared.removeCachedImage(forURL: imageURL)
    /// ```
    public func removeCachedImage(forURL url: URL) {
        let urlString = url.absoluteString
        cache.removeCachedValue(forKey: urlString)
    }

    /// Removes all cached image data.
    ///
    /// This method clears the entire cache, removing all stored image data.
    /// Use this method when you need to free up memory or reset the cache state.
    ///
    /// ## Example
    /// ```swift
    /// // Clear all cached images, for example when logging out a user
    /// AsyncImageAppSessionCacher.shared.removeAllCachedImages()
    /// ```
    public func removeAllCachedImages() {
        cache.removeAllCachedValues()
    }
}
