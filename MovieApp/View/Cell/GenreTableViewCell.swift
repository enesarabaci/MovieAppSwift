//
//  GenreTableViewCell.swift
//  MovieApp
//
//  Created by Enes on 4.05.2022.
//  Copyright © 2022 Enes. All rights reserved.
//

import UIKit

class GenreTableViewCell: UITableViewCell {
    
    public static let identifier = "GenreTableViewCell"
    private var movieList: [Movie] = []
    
    private var collectionView: UICollectionView = {
        var collectionView = UICollectionViewFlowLayout()
        collectionView.scrollDirection = .horizontal
        collectionView.itemSize = CGSize(width: 130, height: 200)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionView)
        cv.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        collectionView.frame = contentView.bounds
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setData(movies: [Movie]) {
        movieList = movies
        collectionView.reloadData()
    }
}

extension GenreTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setMovie(movie: movieList[indexPath.row])
        cell.backgroundColor = .darkGray
        
        return cell
    }
}
