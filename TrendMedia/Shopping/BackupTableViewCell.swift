//
//  BackupTableViewCell.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/08/26.
//

import UIKit

class BackupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var fileSizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }
    
    private func configureCell() {
        fileNameLabel.font = .boldSystemFont(ofSize: 15)
        fileNameLabel.textColor = .white
        fileSizeLabel.font = .boldSystemFont(ofSize: 13)
        fileSizeLabel.textColor = .white
    }
    
    
    
}
