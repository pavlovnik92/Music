//
//  SearchViewController.swift
//  Music
//
//  Created by Alice Romanova on 28.08.2022.
//

import UIKit

protocol SearchDisplaylogic: AnyObject {
    func displayData(viewModel: Models.ModelType.ViewModel.ViewModelType)
}


final class SearchViewController: UIViewController {
    
    var interactor: SearchBisnessLigic?
    var router: SearchRoutingLogic?
    
    //MARK: - Properties
    let musicTableView = UITableView()
    
    var albumImage: UIImage!
    // По другому не получилось вытащить массив из функции
    var musicArray: [SongParameters] = []
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupSearchBar()
        
        setupTableView()
        setupConstraintsForTableView()
    }
    
    //MARK: - setupSearchBar
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.delegate = self
    }
    
    //MARK: - setupTableView
    
    private func setupTableView() {
        musicTableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
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

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        interactor?.makeRequest(request: Models.ModelType.Request.RequestType.requestMusic(searchText: searchText))
    }
}

//MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(musicArray)
        return musicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell

        let track = musicArray[indexPath.row]
        cell.trackNameLabel.text = track.trackName
        cell.artistNameLabel.text = track.artistName
        
        interactor?.requestAlbumImage(request: Models.ModelType.Request.RequestType.requestAlbumImage(URLString: track.artworkUrl100))
        
        cell.albumImageView.image = albumImage

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

//MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
}

//MARK: - SearchDisplaylogic

extension SearchViewController: SearchDisplaylogic {
    func displayData(viewModel: Models.ModelType.ViewModel.ViewModelType) {
        switch viewModel {
            
        case .displayMusic(let music):
            
            guard let music = music else { return }

            musicArray = music
            
            musicTableView.reloadData()
        }
    }
}
