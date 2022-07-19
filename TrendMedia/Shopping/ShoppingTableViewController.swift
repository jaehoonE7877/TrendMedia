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
    @IBOutlet weak var mainUIView: UIView!
    
    
    
    var shoppingList = ["그립톡 구매하기", "사이다 구매", "아이패드 최저가 알아보기", "양말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 상단 뷰 설정
        mainUIView.backgroundColor = .systemGray5
        mainUIView.layer.cornerRadius = 8
        
        tableView.rowHeight = 56
        
        restoreButton.setTitle("추가", for: .normal)
        restoreButton.setTitleColor(.black, for: .normal)
        restoreButton.backgroundColor = UIColor.systemGray4
        restoreButton.layer.cornerRadius = 4
        
        designTextField(item: shoppingTextField)
       
    }
    // textField action
    @IBAction func shoppingListTextField(_ sender: UITextField) {
        
    }
    
    // 추가 버튼 action(버튼을 누르면 textfield 비워주고, 키보드 올라와있으면 내려주고, 빈칸일 때 누르면 alert띄워주기)
    @IBAction func restoreButtonTapped(_ sender: UIButton) {
        
        guard let shopping = shoppingTextField.text else { return }
        
        shopping == "" ? showAlertController() : shoppingList.append(shopping)

        tableView.reloadData()
        shoppingTextField.text = ""
        view.endEditing(true)
    }
    
    
    func designTextField(item : UITextField) {
        item.attributedPlaceholder = NSAttributedString(string: "무엇을 구매하실 건가요?", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        item.backgroundColor = .systemGray5
        item.borderStyle = .none
    }
    
    
    
    // cell 개수 정해주기
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    // cell design 및 데이터
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell", for: indexPath) as! ShoppingListTableViewCell
        // cell의 design + data
        cell.backgroundColor = .systemGray5
        
        cell.shoppingListLabel.text = shoppingList[indexPath.row]
        cell.shoppingListLabel.font = .boldSystemFont(ofSize: 13)
        
        // cell안에있는 button 활성화
        cell.bookmarkButton.tintColor = .black
        cell.checkboxButton.tintColor = .black
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
    
    // textfield 비어있을 때 alert action
    func showAlertController() {
        
        let alert = UIAlertController(title: "경고", message: "다시 입력해주세요", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
   
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    
    /*
     고찰
     line 80 -> button tapped 함수 구현
     cell 마다 여백주기
     uiview 사용하지 않고, textfield랑 button을 포함하는 custom cell 만드는 방법(Section 추가)
     */
    
    

}
