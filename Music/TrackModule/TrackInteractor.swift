//
//  TrackInteractor.swift
//  Music
//
//  Created by Alice Romanova on 01.09.2022.
//

import Foundation

protocol TrackBisnessLogic: AnyObject {
    
}


final class TrackInteractor: TrackBisnessLogic {
    
    var presenter: TrackPresentationLogic?
    var service: FechedDataLogic?
}
