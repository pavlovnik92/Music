//
//  AssemblyLayer.swift
//  Music
//
//  Created by Alice Romanova on 28.08.2022.
//

import UIKit

class AssemblyLayer {
    
    static let shared = AssemblyLayer()
    
    
    func createNavigationController() -> UINavigationController {
        
        let navigationController = UINavigationController()
        let router = SearchRouter()
        
        router.navigationController = navigationController
        navigationController.viewControllers = [createSearchModule(router: router)]
        
        return navigationController
    }
    
    func createSearchModule(router: SearchRouter) -> UIViewController {
        
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        
        let viewController = SearchViewController()
        let requestWorker = SearchRequestWorker()
        let responseWorker = SearchResponseWorker()
        
        //connections
        
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        interactor.service = responseWorker
        
        presenter.view = viewController
        
        responseWorker.requestWorker = requestWorker

        return viewController
    }
}
