//
//  SearchRouter.swift
//  Music
//
//  Created by Alice Romanova on 28.08.2022.
//

import UIKit

protocol SearchRoutingLogic: AnyObject {
    func pushViewController()
    func popViewController()
}
  

final class SearchRouter: SearchRoutingLogic {
    
     var navigationController: UINavigationController?
    
    
    func pushViewController() {
        
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
