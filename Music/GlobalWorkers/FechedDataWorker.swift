//
//  FechedDataWorker.swift
//  Music
//
//  Created by Alice Romanova on 28.08.2022.
//

import UIKit
import SDWebImage

protocol FechedDataLogic: AnyObject {
    func fetchMusic(request: String?, completion: @escaping (SearchResaults?) -> Void)
    func fetchImage(URLString: String) -> UIImageView?
}


final class FechedDataWorker: FechedDataLogic {
    
    var requestDataWorker: RequestDataLogic?
    
    
    func fetchImage(URLString: String) -> UIImageView? {
        let new = URLString.replacingOccurrences(of: "100x100", with: "500x500")
        let imageView = UIImageView()
        let url = URL(string: new)
       
        imageView.sd_setImage(with: url)
        
        return imageView
    }
    
    func fetchMusic(request: String?, completion: @escaping (SearchResaults?) -> Void) {

        requestDataWorker?.createRequest(request: request, completion: { data, error in
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
