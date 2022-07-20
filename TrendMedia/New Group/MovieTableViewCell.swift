//
//  MovieTableViewCell.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/07/20.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    
    func configureCell(data: Movie) {
        movieLabel.text = data.title
        movieLabel.font = .boldSystemFont(ofSize: 15)
        releasedLabel.text = "\(data.releaseDate) | \(data.runtime)분 | \(data.rate)점"
        plotLabel.text = data.overview
        plotLabel.numberOfLines = 0
        
    }
    
    
}
