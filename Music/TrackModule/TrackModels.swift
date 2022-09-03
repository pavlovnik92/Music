//
//  TrackModels.swift
//  Music
//
//  Created by Alice Romanova on 01.09.2022.
//

import Foundation

enum TrackModels {
    
    enum ModelType {
        
        struct Request {
            enum RequestType {
                case giveSongParameters(name: String, artistName: String, icon: String?, song: String)
                
            }
        }
        
        struct Response {
            enum responseType {
                case presentSongParameters(name: String, artistName: String, icon: String?, song: String)
                
            }
        }
        
        struct ViewModel {
            enum ViewModelType {
                case displaySongParameters(name: String, artistName: String, icon: String?, song: String)
            }
        }
    }
}
