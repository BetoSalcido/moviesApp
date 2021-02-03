//
//  MoviesRequest.swift
//  moviesApp
//
//  Created by Beto Salcido on 01/02/21.
//

import Foundation

class MoviesRequest {
    var apiRequest: ApiRequest
    
    init(apiRequest: ApiRequest) {
        self.apiRequest = apiRequest
    }
    
    private func getBaseUrl(baseUrl: Bool, apiKey: Bool) -> String {
        if let data = GetAppSettings.getValusFromAppConfig() {
            return baseUrl ? data.apiUrl : data.apiKey
        }
        
        return ""
    }
    
    func getMovies(orderBy: String, completion: @escaping(Response<Movies?>) -> Void ) {
//        http://api.themoviedb.org/3/movie/popular?api_key=fc15afc1056ba0f2ee4a99e3d82c035e
        var baseUrl = getBaseUrl(baseUrl: true, apiKey: false)
        let apiKey = getBaseUrl(baseUrl: false, apiKey: true)
        baseUrl = "\(baseUrl)\(orderBy)?api_key=\(apiKey)"
        
        apiRequest.get(url: baseUrl, decode: { (response) -> Movies? in
            guard let data = response as? Movies else {
                return nil
            }
            return data
        }, completion: completion)
    }
}
