//
//  TrackViewController.swift
//  Music
//
//  Created by Alice Romanova on 31.08.2022.
//

import UIKit
import MediaPlayer

protocol TrackDiasplayLogic: AnyObject {
    func displayData(data: TrackModels.ModelType.ViewModel.ViewModelType)
}
 

final class TrackViewController: UIViewController {

    var interactor: TrackBisnessLogic?
    var router: TrackRoutingLogic?
    
    //MARK: - Properties
    private let player = AVPlayer()
    
    private let albumImageView = UIImageView()
    
    private let trackNameLabel = UILabel()
    private let artistNameLabel = UILabel()
    private let timeLabel = UILabel()
    
    private let maxVolumeImageView = UIImageView()
    private let minVolumeImageView = UIImageView()
    
    private let trackSlider = UISlider()
    private let volumeSlider = UISlider()
    
    private let backButton = UIButton()
    private let pauseButton = UIButton()
    private let forwardButton = UIButton()
    private let addingButton = UIButton()
     
    //MARK: - Track components
    private var currentTrack: String!
    private var currentAlbumImageView: UIImageView?
    private var currentTrackName: String!
    private var currentArtistName: String!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
//        navigationItem.hidesBackButton = true

        setupAlbumImageView()
        setupConstraintsForAlbumImageView()

        setupTrackNameLabel()
        setupConstraintsForTrackNameLabel()

        setupArtistNameLabel()
        setupConstraintsForArtistNameLabel()

        setupTrackSlider()
        setupConstraintsForTrackSlider()

        setupTimeLabel()
        setupConstraintsForTimeLabel()

        setupBackButton()
        setupConstraintsForBackButton()

        setupPauseButton()
        setupConstraintsForPauseButton()

        setupForwardButton()
        setupConstraintsForForwardButton()

        setupVolumeSlider()
        setupConstraintsForVolumeSlider()


   
    }
    
    override func loadView() {
        super.loadView()
        player.automaticallyWaitsToMinimizeStalling = false
        
        guard let track = URL(string: currentTrack) else { return }
        
        let item = AVPlayerItem(url: track)
        player.replaceCurrentItem(with: item)
        player.play()
    }
    
    //MARK: - setupAlbumImageView
    
    private func setupAlbumImageView() {
        
        guard let currentAlbumImageView = currentAlbumImageView else { return }
        
        albumImageView.backgroundColor = .gray
        albumImageView.image = currentAlbumImageView.image
        albumImageView.clipsToBounds = true
        albumImageView.layer.cornerRadius = 10
        
    }
    
    private func setupConstraintsForAlbumImageView() {
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(albumImageView)
        
        albumImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 87).isActive = true
        albumImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 23).isActive = true
        albumImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -23).isActive = true
        albumImageView.heightAnchor.constraint(equalToConstant: 325).isActive = true
    }
    
    //MARK: - setupTrackNameLabel
    
    private func setupTrackNameLabel() {
        trackNameLabel.backgroundColor = .clear
        trackNameLabel.text = currentTrackName
        trackNameLabel.font = .systemFont(ofSize: 25, weight: .bold)
        trackNameLabel.textAlignment = .center
    }
    
    private func setupConstraintsForTrackNameLabel() {
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(trackNameLabel)
        
        trackNameLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 50).isActive = true
        trackNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        trackNameLabel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        trackNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    //MARK: - setupArtistNameLabel
    
    private func setupArtistNameLabel() {
        artistNameLabel.backgroundColor = .clear
        artistNameLabel.text = currentArtistName
        artistNameLabel.font = .systemFont(ofSize: 25, weight: .medium)
        artistNameLabel.alpha = 0.4
        artistNameLabel.textAlignment = .center
    }
    
    private func setupConstraintsForArtistNameLabel() {
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(artistNameLabel)
        
        artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 5).isActive = true
        artistNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        artistNameLabel.widthAnchor.constraint(equalTo: trackNameLabel.widthAnchor).isActive = true
        artistNameLabel.heightAnchor.constraint(equalTo: trackNameLabel.heightAnchor).isActive = true
    }
    
    //MARK: - setupTrackSlider
    
    private func setupTrackSlider() {

    }
    
    private func setupConstraintsForTrackSlider() {
        trackSlider.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(trackSlider)
        
        trackSlider.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 30).isActive = true
        trackSlider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        trackSlider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        trackSlider.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    //MARK: - setupTimeLabel
    
    private func setupTimeLabel() {
        timeLabel.backgroundColor = .green
    }
    
    private func setupConstraintsForTimeLabel() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(timeLabel)
        
        timeLabel.topAnchor.constraint(equalTo: trackSlider.bottomAnchor, constant: 15).isActive = true
        timeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    //MARK: - setupBackButton
    
    private func setupBackButton() {
        backButton.setImage(UIImage(named: "fast-forward"), for: .normal)
    }
    
    private func setupConstraintsForBackButton() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backButton)
        
        backButton.transform = backButton.transform.rotated(by: .pi)
        backButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 65).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    //MARK: - setupPauseButton
    
    private func setupPauseButton() {
        pauseButton.setImage(UIImage(named: "pause"), for: .normal)
        pauseButton.addTarget(self, action: #selector(stop), for: .touchUpInside)
    }
    
    private func setupConstraintsForPauseButton() {
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(pauseButton)
        
        pauseButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 60).isActive = true
        pauseButton.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 50).isActive = true
        pauseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pauseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    //MARK: - setupForwardButton
    
    private func setupForwardButton() {
        forwardButton.setImage(UIImage(named: "fast-forward"), for: .normal)
    }
    
    private func setupConstraintsForForwardButton() {
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(forwardButton)
        
        forwardButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 65).isActive = true
        forwardButton.leftAnchor.constraint(equalTo: pauseButton.rightAnchor, constant: 50).isActive = true
        forwardButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        forwardButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    //MARK: - setupAddingButton
    
    private func setupAddingButton() {
        
    }
    
    private func setupConstraintsForAddingButton() {
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(artistNameLabel)
        
        artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 5).isActive = true
        artistNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        artistNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        artistNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    //MARK: - setupVolumeSlider
    
    private func setupVolumeSlider() {
        volumeSlider.maximumValueImage = UIImage(named: "max")
        volumeSlider.minimumValueImage = UIImage(named: "min")
    }
    
    private func setupConstraintsForVolumeSlider() {
        volumeSlider.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(volumeSlider)
        
        volumeSlider.topAnchor.constraint(equalTo: pauseButton.bottomAnchor, constant: 50).isActive = true
        volumeSlider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        volumeSlider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
    }
    
    
    
    
    @objc private func stop() {

        if player.timeControlStatus == .playing {
            player.pause()
            pauseButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player.play()
            pauseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
}





//MARK: - TrackDiasplayLogic

extension TrackViewController: TrackDiasplayLogic {
    
    func displayData(data: TrackModels.ModelType.ViewModel.ViewModelType) {
        switch data {
            
        case .displaySongParameters(name: let name, artistName: let artistName, imageView: let imageView, track: let track):
            
            currentTrack = track
            currentAlbumImageView = imageView
            currentTrackName = name
            currentArtistName = artistName
        }
    }
}
