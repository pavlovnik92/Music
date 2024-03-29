//
//  SearchInteractor.swift
//  Music
//
//  Created by Alice Romanova on 28.08.2022.
//

import Foundation

protocol SearchBisnessLigic: AnyObject {
    func makeRequest(request: SearchModels.ModelType.Request.RequestType)
}


final class SearchInteractor: SearchBisnessLigic {
    
    var service: FechedDataLogic?
    var presenter: SearchPresentationLogic?
    var trackInteractor: TrackBisnessLogic?
    
    func makeRequest(request: SearchModels.ModelType.Request.RequestType) {
        switch request {
            
        case .requestMusic(searchText: let searchText):
            
            service?.fetchMusic(request: searchText, completion: { [weak self] searchResaults in
                guard let searchResaults = searchResaults else { return }
                
                self?.presenter?.presentData(response: SearchModels.ModelType.Response.responseType.presentMusic(searchResponse: searchResaults))
            })
            
        case .requestAlbumImage(URLString: let URLString):
            guard let URLString = URLString else { return }
            
            let imageView = service?.fetchImage(URLString: URLString)
            
            presenter?.presentData(response: SearchModels.ModelType.Response.responseType.presentAlbumImage(imageView: imageView))

        case .giveCurrentTrack(indexPath: let indexPath, musicArray: let musicArray):
            
            trackInteractor?.makeRequest(request: TrackModels.ModelType.Request.RequestType.giveCurrentTrack(indexPath: indexPath, array: musicArray))
        }
    }
}
