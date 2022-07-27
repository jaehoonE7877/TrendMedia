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
    
    
    // option command / -> 함수에 대한 정보와 파라미터에 대한 값
    /// <#Description#>
    /// - Parameter data: <#data description#>
    func configureCell(data: Movie) {
        movieLabel.text = data.title
        movieLabel.font = .boldSystemFont(ofSize: 15)
        releasedLabel.text = "\(data.releaseDate) | \(data.runtime)분 | \(data.rate)점"
        plotLabel.text = data.overview
        plotLabel.numberOfLines = 0
        
    }
    
    
}
