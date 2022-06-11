//
//  TableHeaderView.swift
//  MovieApp
//
//  Created by Enes on 22.05.2022.
//  Copyright © 2022 Enes. All rights reserved.
//

import UIKit

class TableHeaderView: UIScrollView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(movies: [Movie]) {
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.isPagingEnabled = true
        var contentWidth = CGFloat(0)
        
        var index = 0
        movies.forEach { (movie: Movie) in
            let imageView = UIImageView()
        
            imageView.contentMode = .scaleToFill
            imageView.sd_setImage(with: movie.poster_path.makePosterUrl(), completed: nil)
            
            let xCoordinate = frame.width * CGFloat(index)
            imageView.frame = CGRect(x: xCoordinate, y: 0, width: frame.width, height: frame.height)
            self.addSubview(imageView)
            contentWidth += frame.width
            index = index + 1
        }
        self.contentSize = CGSize(width: contentWidth, height: frame.height)
    }
}
