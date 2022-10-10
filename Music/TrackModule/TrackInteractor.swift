//
//  TrackInteractor.swift
//  Music
//
//  Created by Alice Romanova on 01.09.2022.
//

import Foundation

protocol TrackBisnessLogic: AnyObject {
    func makeRequest(request: TrackModels.ModelType.Request.RequestType)
}


final class TrackInteractor: TrackBisnessLogic {
    
    var presenter: TrackPresentationLogic?
    var service: FechedDataLogic?
    
    private var trackCounter = 1
    private var array: [SongParameters]!
    private var index: IndexPath!
    
    func makeRequest(request: TrackModels.ModelType.Request.RequestType) {
        switch request {
            
        case .giveCurrentTrack(indexPath: let indexPath, array: let array):
            
            self.array = array
            self.index = indexPath
            
            let trackName = array[indexPath.row].trackName
            let artistName = array[indexPath.row].artistName
            let albumImage = array[indexPath.row].artworkUrl100
            let duration = array[indexPath.row].previewUrl
            
            let imageView = service?.fetchImage(URLString: albumImage!)
            
            presenter?.presentData(response: TrackModels.ModelType.Response.responseType.presentSongParameters(name: trackName, artistName: artistName, imageView: imageView, track: duration))
     
        case .next:
            let nextTrackName = array[index.row + trackCounter].trackName
            let nextArtistName = array[index.row + trackCounter].artistName
            let nextAlbumImage = array[index.row + trackCounter].artworkUrl100
            let nextDuration = array[index.row + trackCounter].previewUrl
            
            let nextImageView = service?.fetchImage(URLString: nextAlbumImage!)
            
            presenter?.presentData(response: TrackModels.ModelType.Response.responseType.presentNextTrack(name: nextTrackName, artistName: nextArtistName, imageView: nextImageView, track: nextDuration))
            
            trackCounter += 1
            
        case .back:
            let backTrackName = array[index.row - trackCounter].trackName
            let backArtistName = array[index.row - trackCounter].artistName
            let backAlbumImage = array[index.row - trackCounter].artworkUrl100
            let backDuration = array[index.row - trackCounter].previewUrl
            
            let backImageView = service?.fetchImage(URLString: backAlbumImage!)
            
            presenter?.presentData(response: TrackModels.ModelType.Response.responseType.presentNextTrack(name: backTrackName, artistName: backArtistName, imageView: backImageView, track: backDuration))
            
            trackCounter += 1
        }
    }
}

