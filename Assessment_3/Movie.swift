//
//  Movie.swift
//  Assessment_3
//
//  Created by Collin Cannavo on 6/16/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import Foundation
import UIKit

struct Movie {

    static let titleKey = "title"
    static let ratingKey = "vote_average"
    static let summaryKey = "overview"
    static let imageEndpointKey = "poster_path"
    
    let title: String
    let rating: Double
    let summary: String
    let imageEndpoint: String
    
    init(title: String, rating: Double, summary: String, imageEndpoint: String) {
    
        self.title = title
        self.rating = rating
        self.summary = summary
        self.imageEndpoint = imageEndpoint
        
    }
    
    
}

extension Movie {
    
    init?(dictionary: [String:Any]) {
        guard let title = dictionary[Movie.titleKey] as? String,
            let rating = dictionary[Movie.ratingKey] as? Double,
            let summary = dictionary[Movie.summaryKey] as? String,
            let imageEndpoint = dictionary[Movie.imageEndpointKey] as? String
            else { return nil}
     
        self.init(title: title, rating: rating, summary: summary, imageEndpoint: imageEndpoint)
        
    }

}
