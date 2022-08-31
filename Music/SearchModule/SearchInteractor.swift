//
//  SearchInteractor.swift
//  Music
//
//  Created by Alice Romanova on 28.08.2022.
//

import UIKit

protocol SearchBisnessLigic: AnyObject {
    func makeRequest(request: Models.ModelType.Request.RequestType)
}


final class SearchInteractor: SearchBisnessLigic {
    
    var service: SearchResponseLogic?
    var presenter: SearchPresentationLogic?
    
    func makeRequest(request: Models.ModelType.Request.RequestType) {
        
        switch request {
            
        case .requestMusic(searchText: let searchText):
            service?.fetchMusic(request: searchText, completion: { [weak self] searchResaults in
                
                guard let searchResaults = searchResaults else { return }
                
                self?.presenter?.presentData(response: Models.ModelType.Response.responseType.presentMusic(searchResponse: searchResaults))
            })
            
        case .requestAlbumImage(URLString: let URLString):
            let image = service?.fetchImage(URLString: URLString)
            print("interactor", URLString)
            print(image)
            presenter?.presentData(response: Models.ModelType.Response.responseType.presentAlbumImage(imageView: image))
        }
        
    }
}
