//
//  ViewController.swift
//  MovieApp
//
//  Created by Enes on 3.05.2022.
//  Copyright © 2022 Enes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private var moviesDataList: [MoviesData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.register(GenreTableViewCell.self, forCellReuseIdentifier: GenreTableViewCell.identifier)
        
        view.addSubview(tableView)
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        
        title = "Movies"
        
        self.view.backgroundColor = UIColor.black
        tableView.backgroundColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self
                        
        getMovieGenres()
        getPopularMovies()
    }
 
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    private func getMovieGenres() {
        Service.shared.getMovieGenres { (result: Genres?) in
            if result == nil {
                print("An error occurred for movie genres")
            }
            else {
                DispatchQueue.main.async {
                    self.getMovies(genres: result!)
                }
            }
        }
    }
    private func getPopularMovies() {
        Service.shared.getPopularMovies { (result: Movies?) in
            if result == nil {
                print("An error occured for popular movies")
            }
            else {
                DispatchQueue.main.async {
                    let tableHeaderView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 400))
                    tableHeaderView.setData(movies: result!.results)
                    self.tableView.tableHeaderView = tableHeaderView
                }
            }
        }
    }
    private func getMovies(genres: Genres) {
        genres.genres.forEach { (genre: Genre) in
            Service.shared.getMovies(genreId: String(genre.id)) { (result: Movies?) in
                if result == nil {
                    print("An error occured for movies")
                }
                else {
                    DispatchQueue.main.async {
                        self.moviesDataList.append(result!.toMoviesData(genreName: genre.name))
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return moviesDataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .black
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let genreLabel = UILabel()
        genreLabel.textColor = .white
        genreLabel.font = .systemFont(ofSize: 18, weight: .bold)
        genreLabel.text = moviesDataList[section].genreName
        genreLabel.frame = CGRect(x: 8, y: 8, width: view.frame.width-16, height: view.frame.height-16)
        view.addSubview(genreLabel)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GenreTableViewCell.identifier, for: indexPath) as! GenreTableViewCell
        cell.setData(movies: moviesDataList[indexPath.section].movies)
        
        return cell
    }
}
