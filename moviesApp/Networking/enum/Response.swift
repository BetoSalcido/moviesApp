//
//  Response.swift
//  moviesApp
//
//  Created by Beto Salcido on 01/02/21.
//

import Foundation

enum Response<T> {
    case success(T)
    case failure(Error)
}

enum CodeError: Error {
    case unknownError
    case connectionError
    case invalidCredentials
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
    case timeOut
    case unsuppotedURL
    case next
    case custom(errorDescription: String?)
    
    class Enums { }
}

extension CodeError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .custom(let errorDescription): return errorDescription
            case .unknownError: return ""
            case .connectionError: return ""
            case .invalidCredentials: return ""
            case .invalidRequest: return ""
            case .notFound: return ""
            case .invalidResponse: return ""
            case .serverError: return ""
            case .serverUnavailable: return ""
            case .next: return ""
            case .timeOut: return ""
            case .unsuppotedURL: return ""
        }
            
    }
}

extension CodeError.Enums {
    enum custom {
        case custom(errorCode: Int?, errorDescription: String?)
    }
}

extension CodeError.Enums.custom: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .custom(_, let errorDescription): return errorDescription
        }
    }

    var errorCode: Int? {
        switch self {
            case .custom(let errorCode, _): return errorCode
        }
    }
}


// MARK: - ServerResponseError
struct ServerResponseError: Codable {
    let error: ServerError?
}

// MARK: - Error
struct ServerError: Codable {
    let statusCode: Int?
    let message: String?
}
