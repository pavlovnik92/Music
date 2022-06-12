//
//  NetworkDataFetcher.swift
//  Music
//
//  Created by Alice Romanova on 10.06.2022.
//

import Foundation


class NetworkDataFetcher {
    
    private var networkService = NetworkService()
    
    func fetchMusic(request: String?, completion: @escaping (SearchResaults?) -> Void) {
        
        networkService.createRequest(request: request) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, data: Data?) -> T? {
        let decoder = JSONDecoder()
        
        guard let data = data else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch {
           print("Faild to decode JSON")
            return nil
        }
    }
}
