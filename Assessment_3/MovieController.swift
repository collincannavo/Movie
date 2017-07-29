//
//  MovieController.swift
//  Assessment_3
//
//  Created by Collin Cannavo on 6/16/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import Foundation
import UIKit

class MovieController {
    
    static let shared = MovieController()
    
    let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie?")
    let imageURL = URL(string: "http://image.tmdb.org/t/p/w185/")
    
    func getMovies(title: String, completion: @escaping ([Movie]?) -> Void) {
        guard let unwrappedURL = baseURL else { completion([]); return }
        
        var components = URLComponents(url: unwrappedURL, resolvingAgainstBaseURL: true)
        
        let apiQueryItems = URLQueryItem(name: "api_key", value: "f2343bba5b16b29ae9f0dc3fdf262555")
        let searchQueryItems = URLQueryItem(name: "query", value: title)
        
        components?.queryItems = [apiQueryItems, searchQueryItems]
        
        guard let url = components?.url else { completion([]); return }
        
        var request = URLRequest(url: url)
        request.httpBody = nil
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let data = data,
                let responseDataString = String(data: data, encoding: .utf8)
                else { completion([]); return }
            
            guard let serializedDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any],
            let arrayOfMovieDictionaries = serializedDictionary["results"] as? [[String: Any]]
            else { completion([]); return }
            
            let moviesArray = arrayOfMovieDictionaries.flatMap { Movie(dictionary: $0) }
            
            completion(moviesArray)
            
        }
        
        dataTask.resume()
    }
    
     func getPoster(imageEndpoint: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let imageURL = imageURL?.appendingPathComponent(imageEndpoint) else { completion(nil); return }
        
        let dataTask = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return }
            
            guard let data = data,
            let image = UIImage(data: data)
                else { completion(nil); return }
            
            DispatchQueue.main.async {
                completion(image)
                
            }
            
        }
        
        dataTask.resume()
    }
    
    func finishFetchingPoster() {
        
        let google = URL(fileURLWithPath: "www.google.com")
        let name = String(contentsOf: google, usedEncoding: &<#T##String.Encoding#>)
        
        
    }
    
}








