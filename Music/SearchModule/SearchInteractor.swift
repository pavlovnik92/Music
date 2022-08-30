//
//  SearchInteractor.swift
//  Music
//
//  Created by Alice Romanova on 28.08.2022.
//

import UIKit

protocol SearchBisnessLigic: AnyObject {
    func makeRequest(request: Models.ModelType.Request.RequestType)
    func requestAlbumImage(request: Models.ModelType.Request.RequestType)
}


final class SearchInteractor: SearchBisnessLigic {
    
    var service: SearchResponseLogic?
    var presenter: SearchPresentationLogic?
    
    func makeRequest(request: Models.ModelType.Request.RequestType) {
        
        switch request {
            
        case .requestMusic(let searchText):
            service?.fetchMusic(request: searchText, completion: { [weak self] searchResaults in
                
                guard let searchResaults = searchResaults else { return }
                
                self?.presenter?.presentData(response: Models.ModelType.Response.responseType.presentMusic(searchResponse: searchResaults))
            })
        }
        
    }
    
    func requestAlbumImage(request: Models.ModelType.Request.RequestType) {
        
        switch request {
            
        case .requestMusic(searchText: let searchText):
            <#code#>
        case .requestAlbumImage(URLString: let URLString):
            <#code#>
        }
    }
}
