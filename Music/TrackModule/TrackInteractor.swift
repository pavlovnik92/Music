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
    
    
    func makeRequest(request: TrackModels.ModelType.Request.RequestType) {
    
    }
}
