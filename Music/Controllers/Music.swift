//
//  Music.swift
//  Music
//
//  Created by Alice Romanova on 10.06.2022.
//

import UIKit

class Music: UIViewController {
    
    //MARK: Private Properties
    private let musicTableView = UITableView()

    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        createSearchBar()
    }
    
    //MARK: - SetupSearchBar
    private func createSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        
        searchController.delegate = self
    }
    
    //MARK: - SetupTableView
    private func setupTableView() {
        musicTableView.register(MusicCell.self, forCellReuseIdentifier: MusicCell.identifier)
        musicTableView.backgroundColor = view.backgroundColor
        
        musicTableView.delegate = self
        musicTableView.dataSource = self
    }
    
    private func setupConstraintsFortavleView() {
        view.addSubview(musicTableView)
        
        musicTableView.translatesAutoresizingMaskIntoConstraints = false
        
        musicTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        musicTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        musicTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        musicTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
