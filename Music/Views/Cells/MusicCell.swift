//
//  MusicCell.swift
//  Music
//
//  Created by Alice Romanova on 10.06.2022.
//

import UIKit

class MusicCell: UITableViewCell {
    
    //MARK: Static properties
    static let identifier = "TableViewCell"

    //MARK: Private properties
    private let albumImageView = UIImageView()
    private let artistNameLabel = UILabel()
    private let trackNameLabel = UILabel()
    
    
    //MARK: LayoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupAlbumImage()
        setupConstraintsForAlbumImage()
        
        setupTrackName()
        setupConstraintsForTrackName()
        
        setupArtistNameLabel()
        setupConstraintsForArtistNameLabel()
  
    }
    
    //MARK: - SetupAlbumImage
    private func setupAlbumImage() {
        albumImageView.backgroundColor = .gray
        albumImageView.layer.cornerRadius = 3
        contentView.addSubview(albumImageView)
    }
    
    private func setupConstraintsForAlbumImage() {
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        
        albumImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        albumImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        albumImageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        albumImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    //MARK: - SetupTrackName
    private func setupTrackName() {
        trackNameLabel.text = "Happy Little Pill"
        trackNameLabel.font = .systemFont(ofSize: 16, weight: .regular)
        trackNameLabel.textColor = .label
        contentView.addSubview(trackNameLabel)
    }
    
    private func setupConstraintsForTrackName() {
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        trackNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 11).isActive = true
        trackNameLabel.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: 18).isActive = true
        trackNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        trackNameLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    //MARK: - SetupArtistNameLabel
    private func setupArtistNameLabel() {
        artistNameLabel.text = "Eminem"
        artistNameLabel.textColor = .gray
        artistNameLabel.font = .systemFont(ofSize: 13, weight: .light)
        contentView.addSubview(artistNameLabel)
    }
    
    private func setupConstraintsForArtistNameLabel() {
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 4).isActive = true
        artistNameLabel.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: 18).isActive = true
        artistNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        artistNameLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
}
