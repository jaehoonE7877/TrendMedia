//
//  ItemViewController.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/08/23.
//

import UIKit

import RealmSwift

class ItemViewController: UIViewController {
    
    static let identifier = "ItemViewController"
    
    let localRealm = try! Realm()
    
    lazy var objectId = ObjectId()
    
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    @IBOutlet weak var checkMarkLabel: UILabel!
    
    @IBOutlet weak var bookMarkButton: UIButton!
   
    @IBOutlet weak var detailTextView: UITextView!
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    var tasks: Results<UserShopping>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configureUI()
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }
    

    
    func configureUI(){
        
        guard let itemTitle = localRealm.object(ofType: UserShopping.self, forPrimaryKey: objectId)?.shoppingList else { return }
        guard let checkMarkValue = localRealm.object(ofType: UserShopping.self, forPrimaryKey: objectId)?.checkMark else { return }
        guard let bookMarkValue = localRealm.object(ofType: UserShopping.self, forPrimaryKey: objectId)?.bookMark else { return }
        
        itemTitleLabel.text = itemTitle
        itemTitleLabel.font = .boldSystemFont(ofSize: 28)
        itemTitleLabel.textAlignment = .center
        itemTitleLabel.textColor = .white
        itemTitleLabel.layer.borderColor = UIColor.white.cgColor
        itemTitleLabel.layer.borderWidth = 1
        itemTitleLabel.layer.masksToBounds = true
        itemTitleLabel.layer.cornerRadius = 8
        
        detailTextView.font = .systemFont(ofSize: 14)
        detailTextView.textColor = .white
        detailTextView.backgroundColor = .darkGray
        detailTextView.layer.borderColor = UIColor.white.cgColor
        detailTextView.layer.borderWidth = 1
        detailTextView.layer.masksToBounds = true
        detailTextView.layer.cornerRadius = 8
        
        let checkMarkText = checkMarkValue ? "구매 완료했습니다!" : "아직 완료되지 않았습니다!"
        print(checkMarkValue, bookMarkValue)
        checkMarkLabel.text = checkMarkText
        checkMarkLabel.font = .boldSystemFont(ofSize: 16)
        checkMarkLabel.textAlignment = .center
        
        let bookImage = bookMarkValue ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        bookMarkButton.setImage(bookImage, for: .normal)
        bookMarkButton.tintColor = .systemPink
        
        itemImageView.contentMode = .scaleToFill
        itemImageView.image = loadImageFromDocument(fileName: "\(objectId)")
        
    }
    
    
    
}
