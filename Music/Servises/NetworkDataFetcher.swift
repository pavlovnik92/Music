//
//  NetworkDataFetcher.swift
//  Music
//
//  Created by Alice Romanova on 10.06.2022.
//

import Foundation
import UIKit


final class NetworkDataFetcher {
    
    static let shared = NetworkDataFetcher()
    
    func fetchImage(imageView: UIImageView, URLString: String?) {
        
        if let URLString = URLString {
            let URL = URL(string: URLString)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: URL!) { data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
    
    private var networkService = NetworkService()
    
    func fetchMusic(request: String?, completion: @escaping (SearchResaults?) -> Void) {
        
        networkService.createRequest(request: request) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: SearchResaults.self, data: data)
            completion(decode)
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
