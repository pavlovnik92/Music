//
//  AssemblyLayer.swift
//  Music
//
//  Created by Alice Romanova on 28.08.2022.
//

import UIKit

class AssemblyLayer {
    
    static let shared = AssemblyLayer()
    
    private let navigationController = UINavigationController()
    
     func createSearchModule() -> UIViewController {
        
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let viewController = SearchViewController()
        let router = SearchRouter()
        let requestWorker = SearchRequestWorker()
        let responseWorker = SearchResponseWorker()
        
        //connections
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        interactor.responseWorker = responseWorker
        
        presenter.view = viewController
        
        responseWorker.requestWorker = requestWorker
        
        router.navigationController = navigationController
        
        return viewController
    }
}
