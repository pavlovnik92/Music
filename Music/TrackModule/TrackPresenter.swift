//
//  TrackPresenter.swift
//  Music
//
//  Created by Alice Romanova on 01.09.2022.
//

import Foundation

protocol TrackPresentationLogic: AnyObject {
    func presentData(response: TrackModels.ModelType.Response.responseType)
}


final class TrackPresenter: TrackPresentationLogic {
    
    weak var view: TrackDiasplayLogic?
    
    
    func presentData(response: TrackModels.ModelType.Response.responseType) {
        switch response {
            
        case .presentSongParameters(name: let name, artistName: let artistName, imageView: let imageView, track: let track):
            
            view?.displayData(data: TrackModels.ModelType.ViewModel.ViewModelType.displaySongParameters(name: name,
                                                                                                        artistName: artistName,
                                                                                                        imageView: imageView,
                                                                                                        track: track))
        case .presentNextTrack(name: let name, artistName: let artistName, imageView: let imageView, track: let track):
            view?.displayData(data: TrackModels.ModelType.ViewModel.ViewModelType.displayNextTrack(name: name,
                                                                                                        artistName: artistName,
                                                                                                        imageView: imageView,
                                                                                                        track: track))
        case .presentBackTrack(name: let name, artistName: let artistName, imageView: let imageView, track: let track):
            view?.displayData(data: TrackModels.ModelType.ViewModel.ViewModelType.displayBackTrack(name: name, artistName: artistName, imageView: imageView, track: track))
        }
    }
}
