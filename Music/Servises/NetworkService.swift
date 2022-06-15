//
//  NetworkService.swift
//  Music
//
//  Created by Alice Romanova on 10.06.2022.
//

import Foundation


class NetworkService {
    
    func createRequest(request: String?, completion: @escaping (Data?, Error?) -> Void) {
        
        let parameters = prepareParameters(request: request)
        let url = setupURL(parameters: parameters)
print(url)
        var request = URLRequest(url: url)
        
        request.httpMethod = "get"
        
        let task = createDataTask(request: request, completion: completion)
        task.resume()
    }
    
    private func prepareParameters(request: String?) -> [String: String] {
        var parameters = [String: String]()
        
        parameters["term"] = request
        parameters["media"] = "music"
        
        return parameters
    }
    
    private func setupURL(parameters: [String: String]) -> URL {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/search"
        components.queryItems = parameters.map{ URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
    
    private func createDataTask(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
