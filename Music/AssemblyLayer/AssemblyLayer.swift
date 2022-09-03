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
    
    let trackInteractor = TrackInteractor()
    let searchInteractor = SearchInteractor()
    
    
    
    func createNavigationController() -> UINavigationController {
        
        let navigationController = UINavigationController()
        
        searchRouter.navigationController = navigationController
        trackRouter.navigationController = navigationController
        
        fechedDataWorker.requestDataWorker = requestDataWorker
        
        navigationController.viewControllers = [createSearchModule()]
        
        return navigationController
    }
    
    func createSearchModule() -> UIViewController {
        

        let presenter = SearchPresenter()
        let viewController = SearchViewController()
        
        //connections
        viewController.interactor = searchInteractor
        viewController.router = searchRouter
        
        searchInteractor.presenter = presenter
        searchInteractor.service = fechedDataWorker
        searchInteractor.trackInteractor = trackInteractor
        
        presenter.view = viewController

        
        return viewController
    }
    
    func createTrackModule() -> UIViewController {
        
        let presenter = TrackPresenter()
        let viewController = TrackViewController()
        
        //connections
        viewController.interactor = trackInteractor
        viewController.router = trackRouter
        
        trackInteractor.presenter = presenter
        trackInteractor.service = fechedDataWorker
        trackInteractor.searchInteractor = searchInteractor
        
        presenter.view = viewController

        
        return viewController
    }
}
