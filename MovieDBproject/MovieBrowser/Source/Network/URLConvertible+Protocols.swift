//
//  URLConvertible+Protocols.swift
//  MovieBrowser
//
//  Created by Ranjith on 10/18/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

/// Types adopting the `URLConvertible` protocol can be used to construct `URL`s, which can then be used to construct
/// `URLRequests`.
public protocol URLConvertible {
    /// Returns a `URL` from the conforming instance or throws.
    ///
    /// - Returns: The `URL` created from the instance.
    /// - Throws:  Any error thrown while creating the `URL`.
    func asURL() throws -> URL
}

extension String: URLConvertible {
    /// Returns a `URL` if `self` can be used to initialize a `URL` instance, otherwise throws.
    ///
    /// - Returns: The `URL` initialized with `self`.
    /// - Throws:  An `AFError.invalidURL` instance.
    public func asURL() throws -> URL {
        guard let str = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: str) else { throw AFError.invalidURL(url: self) }

        return url
    }
}

extension URL: URLConvertible {
    /// Returns `self`.
    public func asURL() throws -> URL { self }
}

public enum AFError: Error {
    case invalidURL(url: URLConvertible)
}
