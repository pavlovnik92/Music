//
//  SearchPresenter.swift
//  Music
//
//  Created by Alice Romanova on 28.08.2022.
//

import Foundation

protocol SearchPresentationLogic: AnyObject {
    func presentData(response: Models.ModelType.Response.responseType)
    func presentAlbumImage(response: Models.ModelType.Response.responseType)
}


final class SearchPresenter: SearchPresentationLogic {
    
    weak var view: SearchDisplaylogic?
    
    
    func presentData(response: Models.ModelType.Response.responseType) {
        
        switch response {
            
        case .presentMusic(let searchResponse):
            
            let cells = searchResponse?.results
            
            view?.displayData(viewModel: Models.ModelType.ViewModel.ViewModelType.displayMusic(music: cells))
            
        }
    }
}
