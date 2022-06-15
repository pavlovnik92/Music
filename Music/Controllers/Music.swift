//
//  Music.swift
//  Music
//
//  Created by Alice Romanova on 10.06.2022.
//

import UIKit

final class Music: UIViewController {
    
    //MARK: Private Properties
    private var musicTableView = UITableView()
    private var musicArray = [SongParameters]()

    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        createSearchBar()

        setupTableView()
        setupConstraintsForTableView()
    }
    
    //MARK: - SetupSearchBar
    private func createSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    //MARK: - SetupTableView
    private func setupTableView() {
        musicTableView.register(MusicCell.self, forCellReuseIdentifier: MusicCell.identifier)
        musicTableView.frame = view.bounds
        musicTableView.backgroundColor = .systemBackground
        musicTableView.separatorStyle = .none
        
        musicTableView.delegate = self
        musicTableView.dataSource = self
    }
    
    private func setupConstraintsForTableView() {
        view.addSubview(musicTableView)
        
        musicTableView.translatesAutoresizingMaskIntoConstraints = false
        
        musicTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        musicTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        musicTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        musicTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}





//MARK: - UISearchBarDelegate
extension Music: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        NetworkDataFetcher.shared.fetchMusic(request: searchText) { [weak self] (searchResults) in
            guard let fechedMusic = searchResults else { return }
            self?.musicArray = fechedMusic.results
            self?.musicTableView.reloadData()
            
        }
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource
extension Music: UITableViewDelegate, UITableViewDataSource {

    // number
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicArray.count
    }

    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: MusicCell.identifier, for: indexPath) as! MusicCell

        let track = musicArray[indexPath.row]
        cell.trackNameLabel.text = track.trackName
        cell.artistNameLabel.text = track.artistName

        NetworkDataFetcher.shared.fetchImage(imageView: cell.albumImageView, URLString: track.artworkUrl100)

        return cell
    }
    
    // height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
