//
//  ShoppingListTableViewCell.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/07/19.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var shoppingListLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var shoppingImageView: UIImageView!
    
    func configureUI(){
        //checkboxButton.layer.borderColor = UIColor.black.cgColor
        //bookmarkButton.layer.borderColor = UIColor.black.cgColor
        checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        bookmarkButton.setImage(UIImage(systemName: "heart"), for: .normal)
        shoppingImageView.contentMode = .scaleAspectFill
    }
        
}

