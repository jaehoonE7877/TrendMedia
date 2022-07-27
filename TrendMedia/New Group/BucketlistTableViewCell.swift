//
//  BucketlistTableViewCell.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/07/19.
//

import UIKit

class BucketlistTableViewCell: UITableViewCell {

    //타입 속성으로 변경되지 않는 identifier 프로퍼티로 사용
    static let identifier = "BucketlistTableViewCell"
    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var bucklistLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
}
