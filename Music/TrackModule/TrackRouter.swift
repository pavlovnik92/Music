//
//  TrackRouter.swift
//  Music
//
//  Created by Alice Romanova on 01.09.2022.
//

import UIKit

protocol TrackRoutingLogic: AnyObject {
    func popViewController()
}


final class TrackRouter: TrackRoutingLogic {
    
    var navigationController: UINavigationController?
    
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
