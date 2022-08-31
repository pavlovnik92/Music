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
        navigationController?.pushViewController(AssemblyLayer.shared.createTrackModule(), animated: true)
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
