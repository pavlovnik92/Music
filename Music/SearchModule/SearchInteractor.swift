//
//  SearchInteractor.swift
//  Music
//
//  Created by Alice Romanova on 28.08.2022.
//

import Foundation

protocol SearchBisnessLigic: AnyObject {
    func makeRequest(request: Models.ModelType.Request.RequestType)
}


final class SearchInteractor: SearchBisnessLigic {
    
    var responseWorker: SearchResponseLogic?
    var presenter: SearchPresentationLogic?
    
    func makeRequest(request: Models.ModelType.Request.RequestType) {
        
    }
}
