//
//  AssemblyLayer.swift
//  Music
//
//  Created by Alice Romanova on 28.08.2022.
//

import UIKit

class AssemblyLayer {
    
    static let shared = AssemblyLayer()
    
    
    let searchRouter = SearchRouter()
    let trackRouter = TrackRouter()
    
    let requestDataWorker = RequestDataWorker()
    let fechedDataWorker = FechedDataWorker()
    
    
    func createNavigationController() -> UINavigationController {
        
        let navigationController = UINavigationController()
        
        searchRouter.navigationController = navigationController
        trackRouter.navigationController = navigationController
        
        fechedDataWorker.requestDataWorker = requestDataWorker
        
        navigationController.viewControllers = [createSearchModule()]
        
        return navigationController
    }
    
    func createSearchModule() -> UIViewController {
        
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let viewController = SearchViewController()
        
        //connections
        viewController.interactor = interactor
        viewController.router = searchRouter
        
        interactor.presenter = presenter
        interactor.service = fechedDataWorker
        
        presenter.view = viewController

        
        return viewController
    }
    
    func createTrackModule() -> UIViewController {
        
        let interactor = TrackInteractor()
        let presenter = TrackPresenter()
        let viewController = TrackViewController()
        
        //connections
        viewController.interactor = interactor
        viewController.router = trackRouter
        
        interactor.presenter = presenter
        interactor.service = fechedDataWorker
        
        presenter.view = viewController

        
        return viewController
    }
}
