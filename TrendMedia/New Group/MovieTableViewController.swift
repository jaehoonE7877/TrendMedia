//
//  MovieTableViewController.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/07/20.
//

import UIKit

class MovieTableViewController: UITableViewController {

    let movieList = MovieInfo()
    //["도둑들", "국제시장", "어벤져스 엔드게임", "택시운전사", "해리포터와 해리포터의 아들들의 유쾌한 반란", "라인언 일병 구하기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.movie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        let data = movieList.movie[indexPath.row]
        cell.configureCell(data: data)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle = .delete {
//
//
//        }
//    }

}
