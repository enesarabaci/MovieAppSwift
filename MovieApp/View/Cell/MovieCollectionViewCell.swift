//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Enes on 4.05.2022.
//  Copyright © 2022 Enes. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
        
    static let identifier = "MovieCollectionViewCell"
    
    private let posterView: UIImageView = {
        let posterView = UIImageView()
        posterView.contentMode = .scaleToFill
        return posterView
    }()
    private let movieTitle: UILabel = {
        let movieTitle = UILabel()
        movieTitle.textColor = .white
        movieTitle.font = .systemFont(ofSize: 14, weight: .semibold)
        movieTitle.textAlignment = .center
        return movieTitle
    }()
    
    private var movie: Movie? {
        didSet {
            if let title = movie?.title {
                movieTitle.text = title
            }
            if let poster = movie?.poster_path {
                posterView.sd_setImage(with: poster.makePosterUrl(), completed: nil)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterView)
        contentView.addSubview(movieTitle)
    }
    
    override func layoutSubviews() {
        posterView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height-30)
        
        movieTitle.frame = CGRect(x: 5, y: posterView.frame.height, width: contentView.frame.width-10, height: 30)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setMovie(movie: Movie) {
        self.movie = movie
    }

}
