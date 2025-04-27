//
//  AsyncImageUseCase.swift
//  AsyncImage
//
//  Created by Omar Elsayed on 22/04/2025.
//

import SwiftUI

struct _AsyncImageUseCase: Sendable {
    private let imageFetcher: _AsyncImageFetcher = .init()
    private let imageAppSessionCacher: AsyncImageAppSessionCacher = .shared
}

// MARK: - Fetch Method
extension _AsyncImageUseCase {
    func fetchImage(url: URL?, for cachingPolicy: CachingPolicy) async throws(AsyncImageError) -> Image {
        guard let url = url else { throw .invilaedUrl(url) }
        if let cachedImageData = checkCachedImageData(for: url), cachingPolicy != .withViewCycle {
           guard let image = Image(data: cachedImageData) else { throw .invalidData(cachedImageData) }

            return image
        } else {
            let finalImageData = try await getImageFrom(from: url)
            guard let finalImage = Image(data: finalImageData) else { throw AsyncImageError.invalidData(finalImageData) }
            cacheImage(for: cachingPolicy, finalImageData, url)

            return finalImage
        }
    }
}

// MARK: - Private Methods
extension _AsyncImageUseCase {
    private func getImageFrom(from url: URL?) async throws(AsyncImageError) -> Data {
        return try await imageFetcher.fetchImage(at: url)
    }

    private func checkCachedImageData(for url: URL) -> Data? {
        return imageAppSessionCacher.fetchImageForURL(url)
    }

    private func cacheImage(for cachingPolicy: CachingPolicy, _ image: Data, _ url: URL?) {
        switch cachingPolicy {
        case .duringAppSession:
            imageAppSessionCacher.cacheImage(image, forURL: url!)
        case .withViewCycle:
            break
        }
    }
}
