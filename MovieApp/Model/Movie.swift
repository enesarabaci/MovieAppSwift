//
//  Movie.swift
//  MovieApp
//
//  Created by Enes on 4.05.2022.
//  Copyright © 2022 Enes. All rights reserved.
//

import Foundation

struct Movies: Decodable {
    let results: [Movie]
    
    func toMoviesData(genreName: String) -> MoviesData {
        return MoviesData.init(movies: results, genreName: genreName)
    }
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let poster_path: String
}

struct MoviesData {
    let movies: [Movie]
    let genreName: String
}
