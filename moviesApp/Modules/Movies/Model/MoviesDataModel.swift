//
//  MoviesDataModel.swift
//  moviesApp
//
//  Created by Beto Salcido on 01/02/21.
//

import Foundation
import Reachability

protocol MoviesDataModelDelegate: AnyObject {
    func didReceiveData(response: Movies)
    func didFail(error: CodeError)
}

class MoviesDataModel {
    
    private let moviesRequest = MoviesRequest(apiRequest: ApiRequest.shared)
    private let reachability = try! Reachability()
    
    weak var delegate: MoviesDataModelDelegate?
    
    private func isConnectionAvailable() -> Bool {
        if reachability.connection != .unavailable {
            return true
        } else {
            return false
        }
    }
    
    func getMovies(orderBy: String) {
        if isConnectionAvailable() {
            moviesRequest.getMovies(orderBy: orderBy) {[weak self] (response) in
                guard let self = self else { return }
                switch response {
                case .success(let response):
                    if let data = response {
                        self.delegate?.didReceiveData(response: data)
                    } else {
                        self.delegate?.didFail(error: CodeError.invalidResponse)
                    }
                case .failure( _):
                    self.delegate?.didFail(error: .serverError)
                }
            }
        } else {
            self.delegate?.didFail(error: .connectionError)
        }
        
    }
}

