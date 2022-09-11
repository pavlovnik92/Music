//
//  TrackViewController.swift
//  Music
//
//  Created by Alice Romanova on 31.08.2022.
//

import AVKit
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
    
    //MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupPlayer()
    }
    
    //MARK: - Animations
    
    private func setPauseAnimation() {
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveLinear) {
            self.albumImageView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        } completion: { _ in
      }
    }
    
    private func setPlayAnimation() {
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1,
                       options: .curveLinear) {
            self.albumImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        } completion: { _ in
      }
    }
    
    //MARK: - setupPlayer
    
    private func setupPlayer() {
        let url = URL(string: currentTrack)
        let item = AVPlayerItem(url: url!)

        player.automaticallyWaitsToMinimizeStalling = false
        player.replaceCurrentItem(with: item)
        player.play()
        
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 10), queue: .main) {
            [weak self] time in

            //почему-то если тянуть ползунок и отмотать на десятую секунду, то показывает 00:010, а когда он сам идет такого нет
            if time.seconds < 10 {
                self?.timeLabel.text = "00:0\(NSString(format: "%.0f", time.seconds))"
            } else {
                self?.timeLabel.text = "00:\(NSString(format: "%.0f", time.seconds))"
            }
            self?.trackSlider.value = Float(time.seconds)
        }
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
        trackNameLabel.font = .systemFont(ofSize: 25, weight: .medium)
        trackNameLabel.textAlignment = .center
    }
    
    private func setupConstraintsForTrackNameLabel() {
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(trackNameLabel)
        
        trackNameLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 40).isActive = true
        trackNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        trackNameLabel.widthAnchor.constraint(equalToConstant: 340).isActive = true
        trackNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    //MARK: - setupArtistNameLabel
    
    private func setupArtistNameLabel() {
        artistNameLabel.backgroundColor = .clear
        artistNameLabel.text = currentArtistName
        artistNameLabel.font = .systemFont(ofSize: 25, weight: .light)
        artistNameLabel.alpha = 0.5
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
        trackSlider.maximumValue = Float(player.currentItem?.asset.duration.seconds ?? 30)
        trackSlider.addTarget(self, action: #selector(rearrange), for: .valueChanged)
        trackSlider.minimumTrackTintColor = .systemGray2
      
    }
    
    private func setupConstraintsForTrackSlider() {
        trackSlider.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(trackSlider)
        
        trackSlider.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 30).isActive = true
        trackSlider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        trackSlider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    //MARK: - setupTimeLabel
    
    private func setupTimeLabel() {
        timeLabel.text = "00:00"
        timeLabel.font = .systemFont(ofSize: 15, weight: .light)
        timeLabel.alpha = 0.5
    }
    
    private func setupConstraintsForTimeLabel() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(timeLabel)
        
        timeLabel.topAnchor.constraint(equalTo: trackSlider.bottomAnchor, constant: 10).isActive = true
        timeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 23).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
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
        backButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 45).isActive = true
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
        
        pauseButton.topAnchor.constraint(equalTo: backButton.topAnchor).isActive = true
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
        
        forwardButton.topAnchor.constraint(equalTo: pauseButton.topAnchor, constant: 3).isActive = true
        forwardButton.leftAnchor.constraint(equalTo: pauseButton.rightAnchor, constant: 50).isActive = true
        forwardButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        forwardButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    //MARK: - setupVolumeSlider
    
    private func setupVolumeSlider() {
        volumeSlider.value = player.volume
        
        volumeSlider.maximumValueImage = UIImage(named: "max")
        volumeSlider.minimumValueImage = UIImage(named: "min")
        
        volumeSlider.addTarget(self, action: #selector(changeVolume), for: .valueChanged)
    }
    
    private func setupConstraintsForVolumeSlider() {
        volumeSlider.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(volumeSlider)
        
        volumeSlider.topAnchor.constraint(equalTo: pauseButton.bottomAnchor, constant: 50).isActive = true
        volumeSlider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        volumeSlider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
    }
    
    //MARK: - @objc method "stop"
    
    @objc private func stop() {
        if player.timeControlStatus == .paused {
            setPlayAnimation()
            player.play()
            pauseButton.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            player.pause()
            setPauseAnimation()
            pauseButton.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    //MARK: - @objc method "rearrange"
    
    @objc private func rearrange() {
        player.seek(to: CMTime(seconds: Double(trackSlider.value), preferredTimescale: 10))
    }
    
    //MARK: - @objc method "changeVolume"
    
    @objc private func changeVolume() {
        player.volume = volumeSlider.value
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
