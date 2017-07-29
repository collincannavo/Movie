//
//  MovieListTableViewController.swift
//  Assessment_3
//
//  Created by Collin Cannavo on 6/16/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, UISearchBarDelegate {

    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text else { return }
        
        DispatchQueue.main.async {
            MovieController.shared.getMovies(title: searchText) { (movie) in
                guard let movie = movie else { return }
                self.movies = movie
            }
        }
        searchBar.text = ""
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else { return MovieTableViewCell() }

        let movie = movies[indexPath.row]

        cell.movies = movie

        return cell
    }


}
