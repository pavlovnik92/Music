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
            
        case .presentSongParameters(name: let name, artistName: let artistName, icon: let icon, song: let song):
            
            view?.displayData(data: TrackModels.ModelType.ViewModel.ViewModelType.displaySongParameters(name: name,
                                                                                                        artistName: artistName,
                                                                                                        icon: icon,
                                                                                                        song: song))
        }
    }
}
