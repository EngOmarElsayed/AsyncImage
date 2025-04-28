//
//  AsyncImageFetcher.swift
//  AsyncImageApp
//
//  Created by Omar Elsayed on 21/04/2025.
//

import Foundation

struct _AsyncImageFetcher: Sendable {
    private let urlSession: URLSession = .shared

    func fetchImage(at url: URL?) async throws -> Data {
        do {
            guard let url else { throw AsyncImageError.invilaedUrl(url) }
            let (data, reponse) = try await urlSession.data(from: url)
            guard let reponse = reponse as? HTTPURLResponse, reponse.statusCode == 200 else { throw AsyncImageError.invalidResponse }

            return data
        } catch {
            throw AsyncImageError.urlSessionError(error)
        }
    }
}
