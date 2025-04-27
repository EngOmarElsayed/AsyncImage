//
//  AsyncImage.swift
//  AsyncImageApp
//
//  Created by Omar Elsayed on 21/04/2025.
//

import SwiftUI

/// A view that asynchronously loads and displays an image.
///
/// `AsyncImage` loads an image from a URL asynchronously, displaying different content
/// during the loading process. It provides flexible handling for various loading states
/// through its content closure.
///
/// The view manages image loading through a view model and caches images based on the
/// specified `CachingPolicy`.
///
/// ## Example
/// ```swift
/// AsyncImage(cachingPolicy: .duringAppSession, from: imageURL) { phase in
///     switch phase {
///     case .loading:
///         ProgressView()
///     case .success(let image):
///         image
///             .resizable()
///             .aspectRatio(contentMode: .fit)
///     case .failure:
///         Image(systemName: "exclamationmark.triangle")
///     }
/// }
/// ```
///
/// ## Topics
/// ### Creating an AsyncImage
/// - ``init(cachingPolicy:from:contentView:)``
///
/// ### Related Types
/// - ``AsyncImageLoadingCase``
/// - ``CachingPolicy``
/// - ``AsyncImageError``
///
public struct AsyncImage<Content: View>: View {
    @StateObject private var viewModel: _AsyncImageViewModel = .init()

    private let url: URL?
    private let cachingPolicy: CachingPolicy
    private let contentView: (AsyncImageLoadingCase) -> Content

    /// Creates an asynchronous image view that loads an image from the specified URL.
    ///
    /// Use this initializer to create a view that asynchronously loads and displays an image,
    /// with customizable content for each loading state.
    ///
    /// - Parameters:
    ///   - cachingPolicy: The policy determining how long the loaded image should remain cached.
    ///     See ``CachingPolicy`` for available options.
    ///   - url: The URL where the image is located. If `nil` or invalid, the loading will result
    ///     in a failure state.
    ///   - contentView: A closure that takes an ``AsyncImageLoadingCase`` and returns the view
    ///     to display for the current loading state.
    ///
    /// - Note: The `contentView` closure will be called with an updated loading case whenever
    ///   the loading state changes.
    ///
    /// ## Example
    /// ```swift
    /// AsyncImage(cachingPolicy: .duringAppSession, from: profileURL) { phase in
    ///     switch phase {
    ///     case .loading:
    ///         ProgressView()
    ///             .frame(width: 100, height: 100)
    ///     case .success(let image):
    ///         image
    ///             .resizable()
    ///             .aspectRatio(contentMode: .fill)
    ///             .frame(width: 100, height: 100)
    ///             .clipShape(Circle())
    ///     case .failure(let error):
    ///         Image(systemName: "person.fill")
    ///             .frame(width: 100, height: 100)
    ///             .background(Color.gray.opacity(0.3))
    ///             .clipShape(Circle())
    ///     }
    /// }
    /// ```
    public init(cachingPolicy: CachingPolicy, from url: URL?, @ViewBuilder contentView: @escaping (AsyncImageLoadingCase) -> Content) {
        self.url = url
        self.cachingPolicy = cachingPolicy
        self.contentView = contentView
    }

    /// The content and behavior of the view.
    ///
    /// This property provides the content view based on the current loading state and
    /// initiates the image loading process when the view appears.
    public var body: some View {
        contentView(viewModel.imageLoadingCase)
            .task {
                await viewModel.fetchImage(cachingPolicy: cachingPolicy, from: url)
            }
    }
}
