//
//  AsyncImageViewModel.swift
//  AsyncImageApp
//
//  Created by Omar Elsayed on 21/04/2025.
//

import SwiftUI

@MainActor
final class _AsyncImageViewModel: ObservableObject {
    @Published var imageLoadingCase: AsyncImageLoadingCase = .loading

    private let imageFetcher: _AsyncImageUseCase = .init()
}

// MARK: - AsyncImageViewModel Methods
extension _AsyncImageViewModel {
    func fetchImage(cachingPolicy: CachingPolicy, from url: URL?) async {
        do {
            let image = try await imageFetcher.fetchImage(url: url, for: cachingPolicy)
            imageLoadingCase = .success(image)
        } catch {
            imageLoadingCase = .failure(error)
        }
    }
}
