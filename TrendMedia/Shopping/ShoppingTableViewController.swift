//
//  ShoppingTableViewController.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/07/19.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    
    @IBOutlet weak var shoppingTextField: UITextField!
    @IBOutlet weak var restoreButton: UIButton!
    
    
    
    var shoppingList = ["그립톡 구매하기", "사이다 구매", "아이패드 최저가 알아보기", "양말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.rowHeight = 60
        
        restoreButton.setTitle("추가", for: .normal)
        restoreButton.setTitleColor(.black, for: .normal)
        restoreButton.backgroundColor = UIColor.lightGray
        restoreButton.layer.cornerRadius = 4
        
        shoppingTextField.attributedPlaceholder = NSAttributedString(string: "무엇을 구매하실 건가요?", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        shoppingTextField.backgroundColor = .systemGray5
       
    }

    @IBAction func shoppingListTextField(_ sender: UITextField) {
        
    }
    
    @IBAction func restoreButtonTapped(_ sender: UIButton) {
        
        guard let shopping = shoppingTextField.text else { return }
        
        shoppingList.append(shopping)
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell", for: indexPath) as! ShoppingListTableViewCell
        
        cell.shoppingListLabel.text = shoppingList[indexPath.row]
        cell.shoppingListLabel.font = .boldSystemFont(ofSize: 13)
        
//        cell.bookmarkButton.setImage(UIImage(systemName: "star"), for: .normal)
//        cell.checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        
        cell.backgroundColor = .systemGray5
        
        cell.bookmarkButtonTapped(cell.bookmarkButton)
        cell.checkboxButtonTapped(cell.checkboxButton)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            
            shoppingList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
   
    
    /*
     고찰
     
     button Text 어떻게 지우고 시작할지?
     버튼 눌리면서 구현하는 방법
     section 추가하는 방법 custom cell
     textfiled 레이아웃 다시 구현...
     
     */
    
    

}
