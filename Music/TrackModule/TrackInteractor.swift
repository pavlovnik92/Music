//
//  TrackInteractor.swift
//  Music
//
//  Created by Alice Romanova on 01.09.2022.
//

import Foundation

protocol TrackBisnessLogic: AnyObject {
    func makeRequest(request: TrackModels.ModelType.Request.RequestType)
}


final class TrackInteractor: TrackBisnessLogic {
    
    var presenter: TrackPresentationLogic?
    var service: FechedDataLogic?
    var searchInteractor: SearchBisnessLigic?
    
    func makeRequest(request: TrackModels.ModelType.Request.RequestType) {
        switch request {

        case .giveSongParameters(name: let name, artistName: let artistName, albumImage: let albumImage, track: let track):
            guard let albumImage = albumImage else { return }
         
            let imageView = service?.fetchImage(URLString: albumImage)
            
            presenter?.presentData(response: TrackModels.ModelType.Response.responseType.presentSongParameters(name: name, artistName: artistName, imageView: imageView, track: track))
        }
    }
}

