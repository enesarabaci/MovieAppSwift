//
//  Extension.swift
//  MovieApp
//
//  Created by Enes on 13.05.2022.
//  Copyright © 2022 Enes. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func makePosterUrl() -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/w300\(self)")
    }
}
