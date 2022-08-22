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
    
    func configureUI(){
        //checkboxButton.layer.borderColor = UIColor.black.cgColor
        //bookmarkButton.layer.borderColor = UIColor.black.cgColor
        checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        bookmarkButton.setImage(UIImage(systemName: "star"), for: .normal)
        
    }
        
}

