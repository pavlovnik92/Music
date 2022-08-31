//
//  SearchPresenter.swift
//  Music
//
//  Created by Alice Romanova on 28.08.2022.
//

import Foundation

protocol SearchPresentationLogic: AnyObject {
    func presentData(response: Models.ModelType.Response.responseType)
}


final class SearchPresenter: SearchPresentationLogic {
    
    weak var view: SearchDisplaylogic?
    
    
    func presentData(response: Models.ModelType.Response.responseType) {
        
        switch response {
            
        case .presentMusic(searchResponse: let searchResponse):
            
            let cells = searchResponse?.results
            
            view?.displayData(data: Models.ModelType.ViewModel.ViewModelType.displayMusic(music: cells))
            
        case .presentAlbumImage(imageView: let imageView):
            
            view?.displayData(data: Models.ModelType.ViewModel.ViewModelType.displayAlbumImage(imageView: imageView))
        }
    }
}
