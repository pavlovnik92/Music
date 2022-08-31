//
//  SearchViewController.swift
//  Music
//
//  Created by Alice Romanova on 28.08.2022.
//

import UIKit

protocol SearchDisplaylogic: AnyObject {
    func displayData(data: SearchModels.ModelType.ViewModel.ViewModelType)
}


final class SearchViewController: UIViewController {
    
    var interactor: SearchBisnessLigic?
    var router: SearchRoutingLogic?
    
    //MARK: - Properties
    private let musicTableView = UITableView()
    private let disappearinglabel = UILabel()
    private let spinner = UIActivityIndicatorView(style: .medium)
    
    private var timer: Timer?
    private var albumImageView = UIImageView()
    
    
    // По другому не получилось вытащить массив из функции, если использовать тип any, то все рушится
    var musicArray: [SongParameters] = []
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
   
        view.backgroundColor = .systemBackground
        
        setupSearchBar()
        
        setupTableView()
        setupConstraintsForTableView()
        
        setupDisappiaringLabel()
        setupConstraintsForDisappiaringLabel()
        
        setupSpinner()
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
    
    //MARK: - setupDisappiaringLabel
    
    private func setupDisappiaringLabel() {
        disappearinglabel.text = "Enter the text ↑"
        disappearinglabel.alpha = 0.5
    }
    
    private func setupConstraintsForDisappiaringLabel() {
        disappearinglabel.translatesAutoresizingMaskIntoConstraints = false
        
        musicTableView.addSubview(disappearinglabel)
        
        disappearinglabel.centerXAnchor.constraint(equalTo: musicTableView.centerXAnchor).isActive = true
        disappearinglabel.topAnchor.constraint(equalTo: musicTableView.topAnchor, constant: 50).isActive = true
    }
    
    //MARK: - setupSpinner
    private func setupSpinner() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}





//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        spinner.startAnimating()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] _ in
            
            self?.interactor?.makeRequest(request: SearchModels.ModelType.Request.RequestType.requestMusic(searchText: searchText))
        })
        
    }
}

//MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        disappearinglabel.isHidden = musicArray.count != 0
        return musicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell

        let track = musicArray[indexPath.row]
        cell.trackNameLabel.text = track.trackName
        cell.artistNameLabel.text = track.artistName
        
        interactor?.makeRequest(request: SearchModels.ModelType.Request.RequestType.requestAlbumImage(URLString: track.artworkUrl100))
        
        cell.albumImageView = albumImageView

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

//MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.pushViewController()
    }
}

//MARK: - SearchDisplaylogic

extension SearchViewController: SearchDisplaylogic {
    
    func displayData(data: SearchModels.ModelType.ViewModel.ViewModelType) {
        
        spinner.stopAnimating()
        
        switch data {
            
        case .displayMusic(music: let music):
            guard let music = music else { return }

            musicArray = music
            
            musicTableView.reloadData()
            
        case .displayAlbumImage(imageView: let imageView):
            guard let imageView = imageView else { return }
            
            self.albumImageView = imageView
        }
    }
}
