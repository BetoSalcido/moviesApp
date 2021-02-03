//
//  ApiRequest.swift
//  calzzapato
//
//  Created by Beto Salcido on 01/02/21.
//  Copyright © 2020 BetoSalcido. All rights reserved.
//

import Foundation

class ApiRequest {
    static let shared = ApiRequest()
    private init() {}
    
    func post<T: Decodable>(url: String, request: [String: Any], decode: @escaping (Decodable) -> T?, completion:  @escaping(Response<T>) -> Void) {
        
        DispatchQueue.main.async {
            let task = self.requestPost(url: url, requestData: request, decodingType: T.self) { (response, error) in
                guard let response = response else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(CodeError.invalidResponse))
                    }
                    return
                }
                
                if let responseData = decode(response) {
                    completion(.success(responseData))
                } else {
                    completion(.failure(CodeError.invalidResponse))
                }
            }
            task.resume()
        }
        
        
    }
    
    func get<T: Decodable>(url: String, decode:  @escaping (Decodable) -> T?, completion:  @escaping(Response<T>) -> Void) {
        
        DispatchQueue.main.async {
            let task = self.requestGet(url: url, decodingType: T.self) { (response, error) in
                guard let response = response else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(CodeError.invalidResponse))
                    }
                    return
                }
                if let value = decode(response) {
                    completion(.success(value))
                } else {
                    completion(.failure(CodeError.invalidResponse))
                }
            }
            
            task.resume()
        }
    }
}

private extension ApiRequest {
    typealias JSONTaskCompletionHandler = (Decodable?, Error?) -> Void
    
    func requestPost<T: Decodable>(url: String, requestData: [String: Any], decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let jsonUrlString = url
        guard let url = URL(string: jsonUrlString) else { fatalError("Could not create URL from components") }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestData, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                    if let data = data {
                       do {
                        let serverResponse = try JSONDecoder().decode(ServerResponseError.self, from: data)
                        let error = CodeError.custom(errorDescription: serverResponse.error?.message ?? "")
                        completion(nil, error)
                       } catch {
                        completion(nil, CodeError.serverError)
                       }
                   } else if let error = error {
                       completion(nil, error)
                   }
                } else {
                    if let data = data {
                        do {
                            let response = try JSONDecoder().decode(decodingType, from: data)
                            completion(response, error)
                        } catch {
                            completion(nil, error)
                        }
                    } else if let error = error {
                        completion(nil, error)
                    }
                }
            }
        }
        return task
    }
    
    func requestGet<T: Decodable>(url: String, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let jsonUrlString = url
        guard let escapedQuery = jsonUrlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let url = URL(string: escapedQuery) else { fatalError("Could not create URL from components") }
        
        //guard let URL = URL(string: jsonUrlString) else { fatalError("Could not create URL from components") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("identity", forHTTPHeaderField: "Accept-Encoding")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                     if let data = data {
                        do {
                         let serverResponse = try JSONDecoder().decode(ServerResponseError.self, from: data)
                         let error = CodeError.custom(errorDescription: serverResponse.error?.message ?? "")
                         completion(nil, error)
                        } catch {
                         completion(nil, CodeError.serverError)
                        }
                    } else if let error = error {
                        completion(nil, error)
                    }
                } else {
                    if let data = data {
                        do {
                            let response = try JSONDecoder().decode(decodingType, from: data)
                            completion(response, error)
                        } catch {
                            completion(nil, error)
                        }
                    } else if let error = error {
                        completion(nil, error)
                    }
                }
            }
        }
        return task
    }
    
    func requestPatch<T: Decodable>(url: String, requestData: [String: Any], decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let jsonUrlString = url
        guard let url = URL(string: jsonUrlString) else { fatalError("Could not create URL from components") }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestData, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                    completion(nil, error)
                } else {
                    if let data = data {
                        do {
                            let response = try JSONDecoder().decode(decodingType, from: data)
                            completion(response, error)
                        } catch {
                            completion(nil, error)
                        }
                    } else if let error = error {
                        completion(nil, error)
                    }
                }
            }
        }
        return task
    }
}


