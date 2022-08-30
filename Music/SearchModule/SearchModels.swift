//
//  SearchModels.swift
//  Music
//
//  Created by Alice Romanova on 28.08.2022.
//

import UIKit

enum Models {
    
    enum ModelType {
        
        struct Request {
            enum RequestType {
                case requestMusic(searchText: String)
                case requestAlbumImage(URLString: String?)
            }
        }
        
        struct Response {
            enum responseType {
                case presentMusic(searchResponse: SearchResaults?)
                case presentAlbumImage(image: UIImage?)
                
            }
        }
        
        struct ViewModel {
            enum ViewModelType {
                case displayMusic(music: [SongParameters]?)
                case displayAlbumImage(image: UIImage?, searchText: String)
            }
        }
    }
}
