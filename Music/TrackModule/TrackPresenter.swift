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
        
    }
}
