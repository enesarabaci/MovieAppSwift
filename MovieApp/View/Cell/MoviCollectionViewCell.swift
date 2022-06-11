//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Enes on 4.05.2022.
//  Copyright © 2022 Enes. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    //@IBOutlet weak var moviePoster: UIImageView!
    //@IBOutlet weak var movieTitle: UILabel!
    private var movie: Movie? {
        didSet {
            //if let movie = movie {
            //    movieTitle.text = movie.title
            //}
        }
    }
    
    private let poster = UIImageView()
    private var title: UILabel {
        let title = UILabel()
        title.textColor = .black
        //title.textAlignment = .center
        title.numberOfLines = 1
        return title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddSubview(_ subview: UIView) {
        poster.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height-20)
        //title.frame = CGRect(x: 0, y: poster.bounds.height, width: //self.bounds.width, height: 20)
        
        title.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addSubview(poster)
        addSubview(title)
        
        title.text = "Deneme"
    }
    
    func setMovie(movie: Movie) {
        print("setMovie: \(movie)")
        self.movie = movie
        //movieTitle.text = "movie.title"
    }

}
