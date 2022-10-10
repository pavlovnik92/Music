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
                case giveCurrentTrack(indexPath: IndexPath, array: [SongParameters])
                case next
                case back
            }
        }
        
        struct Response {
            enum responseType {
                case presentSongParameters(name: String, artistName: String, imageView: UIImageView?, track: String)
                case presentNextTrack(name: String, artistName: String, imageView: UIImageView?, track: String)
                case presentBackTrack(name: String, artistName: String, imageView: UIImageView?, track: String)
            }
        }
        
        struct ViewModel {
            enum ViewModelType {
                case displaySongParameters(name: String, artistName: String, imageView: UIImageView?, track: String)
                case displayNextTrack(name: String, artistName: String, imageView: UIImageView?, track: String)
                case displayBackTrack(name: String, artistName: String, imageView: UIImageView?, track: String)
            }
        }
    }
}
