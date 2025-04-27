//
//  AsyncImageError.swift
//  AsyncImageApp
//
//  Created by Omar Elsayed on 21/04/2025.
//

import Foundation

/// Errors that can occur during asynchronous image loading.
///
/// `AsyncImageError` defines specific error cases that might occur when loading images
/// asynchronously from a URL. These errors help with debugging and displaying appropriate
/// error messages to users.
///
/// ## Topics
/// ### Error Cases
/// - ``urlSessionError(_:)``
/// - ``invalidResponse``
/// - ``invilaedUrl(_:)``
/// - ``invalidData(_:)``
///
/// ## See Also
/// - ``AsyncImage``
/// - ``AsyncImageLoadingCase``
public enum AsyncImageError: Error {
    /// Indicates that a networking error occurred during the URL session.
    ///
    /// This error wraps the underlying `Error` from URLSession, providing access to
    /// the original error details.
    ///
    /// - Parameter Error: The original networking error from URLSession.
    ///
    case urlSessionError(Error)
    
    /// Indicates that the server response was invalid or could not be processed.
    ///
    /// This error occurs when the HTTP response is unexpected, such as receiving
    /// a non-200 status code or missing response data.
    ///
    case invalidResponse
    
    /// Indicates that the provided URL is invalid or nil.
    ///
    /// This error occurs when the URL cannot be used to make a network request,
    /// either because it's nil, malformed, or uses an unsupported scheme.
    ///
    /// - Parameter URL?: The invalid URL that caused the error, if available.
    ///
    /// - Note: This case will be returned when attempting to load an image with a nil
    ///   or invalid URL reference.
    ///
    case invilaedUrl(URL?)
    
    /// Indicates that the received data could not be decoded as an image.
    ///
    /// This error occurs when the response data exists but cannot be converted
    /// to a valid image format.
    ///
    /// - Parameter Data: The invalid data that could not be decoded as an image.
    ///
    case invalidData(Data)
}
