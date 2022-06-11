//
//  Service.swift
//  MovieApp
//
//  Created by Enes on 4.05.2022.
//  Copyright © 2022 Enes. All rights reserved.
//

import Foundation

class Service {
    public static let shared = Service()
    
    private let BASE_URL = "https://api.themoviedb.org/3/"
    private let API_KEY = "3bb3e67969473d0cb4a48a0dd61af747"
    
    func getMovieGenres(completion: @escaping (Genres?) -> ()) {
        let endpoint = BASE_URL + "genre/movie/list" + "?api_key=\(API_KEY)"
        
        makeRequest(endpoint: endpoint, type: Genres.self) { (result) in
            completion(result)
        }
    }
    
    func getMovies(genreId: String, completion: @escaping (Movies?) -> ()) {
        let endpoint = BASE_URL + "discover/movie" + "?api_key=\(API_KEY)" + "&with_genres=\(genreId)"
        
        makeRequest(endpoint: endpoint, type: Movies.self) { (result) in
            completion(result)
        }
    }
    
    func getPopularMovies(completion: @escaping (Movies?) -> ()) {
        let endpoint = BASE_URL + "movie/popular" + "?api_key=\(API_KEY)"
        
        makeRequest(endpoint: endpoint, type: Movies.self) { (result) in
            completion(result)
        }
    }
    
    private func makeRequest<T: Decodable>(endpoint: String, type: T.Type, completion: @escaping (T?) -> ()) {
        guard let url = URL(string: endpoint) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, dataResponse, error) in
            if error != nil {
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            
            let result = try? JSONDecoder().decode(T.self, from: data)
            completion(result)
        }
        task.resume()
    }
}
