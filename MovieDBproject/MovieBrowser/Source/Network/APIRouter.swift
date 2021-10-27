//
//  APIRouter.swift
//  MovieBrowser
//
//  Created by Ranjith on 10/18/21.
//

import Foundation

public typealias Parameters = [String: Any]

/// Types adopting the `URLRequestConvertible` protocol can be used to safely construct `URLRequest`s.
public protocol URLRequestConvertible {
    /// Returns a `URLRequest` or throws if an `Error` was encountered.
    ///
    /// - Returns: A `URLRequest`.
    /// - Throws:  Any error thrown while constructing the `URLRequest`.
    func asURLRequest() throws -> URLRequest
}


enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

// Custom Error object API Calls.
enum APIError: Error {
    case runtimeError(String)
}

// Request parameter types.
enum RequestParams {
    case body(_:Parameters)
}

enum ContentType: String {
    case json = "application/json"
}

/// Builds the URLRequest object.
enum APIRouter: URLRequestConvertible {
    case getSearchData(searchText: String)

    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .getSearchData:
            return .get
        }
    }

    // MARK: - url
    private var urlPath: String {
        switch self {
        case let .getSearchData(searchText: searchText):
            return String(format: AppConstants.searchURL,Network().apiKey ,searchText)
        }
    }

    // MARK: - Parameters
    private var parameters: RequestParams? {
        switch self {
        case .getSearchData:
            return nil
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try urlPath.asURL()
        var urlRequest = URLRequest(url: url)
        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        // Headers
        switch self {
        case .getSearchData:
            break
        }

        // Parameters
        if let parameters = parameters {
            switch parameters {
            case .body(let params):
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }
        }
        return urlRequest
    }
}
