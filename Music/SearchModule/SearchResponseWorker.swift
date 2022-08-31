//
//  SearchResponseWorker.swift
//  Music
//
//  Created by Alice Romanova on 28.08.2022.
//

import UIKit

protocol SearchResponseLogic: AnyObject {
    func fetchMusic(request: String?, completion: @escaping (SearchResaults?) -> Void)
    func fetchImage(URLString: String?) -> UIImageView?
}


final class SearchResponseWorker: SearchResponseLogic {
    
    var requestWorker: SearchRequestLogic?
    
    func fetchImage(URLString: String?) -> UIImageView? {
        var imageview = UIImageView()
        print("service", URLString)
        if let URLString = URLString {
            let URL = URL(string: URLString)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: URL!) { data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    imageview.image = UIImage(data: data)
                }
            }
            task.resume()
        }
        return imageview
    }
    
    func fetchMusic(request: String?, completion: @escaping (SearchResaults?) -> Void) {

        requestWorker?.createRequest(request: request, completion: { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: SearchResaults.self, data: data)
            completion(decode)
        })
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
