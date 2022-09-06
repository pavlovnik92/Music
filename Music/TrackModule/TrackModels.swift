//
//  TrackModels.swift
//  Music
//
//  Created by Alice Romanova on 01.09.2022.
//

import UIKit

enum TrackModels {
    
    enum ModelType {
        
        struct Request {
            enum RequestType {
                case giveSongParameters(name: String, artistName: String, albumImage: String?, track: String)
            }
        }
        
        struct Response {
            enum responseType {
                case presentSongParameters(name: String, artistName: String, imageView: UIImageView?, track: String)
            }
        }
        
        struct ViewModel {
            enum ViewModelType {
                case displaySongParameters(name: String, artistName: String, imageView: UIImageView?, track: String)
            }
        }
    }
}
