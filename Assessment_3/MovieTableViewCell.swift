//
//  MovieTableViewCell.swift
//  Assessment_3
//
//  Created by Collin Cannavo on 6/16/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieSummaryLabel: UILabel!
    @IBOutlet weak var moviePosterImage: UIImageView!
  
    var movies: Movie? {
        didSet{
         
            updateViews()
        }
    }
    
    
    func updateViews() {
        guard let movie = movies else { return }
        
        movieTitleLabel.text = movie.title
        movieRatingLabel.text = "Rating: \(movie.rating)"
        movieSummaryLabel.text = movie.summary
        
        DispatchQueue.main.async {
            MovieController.shared.getPoster(imageEndpoint: movie.imageEndpoint) { (image) in
                self.moviePosterImage.image = image
            }
        }
    }

}
