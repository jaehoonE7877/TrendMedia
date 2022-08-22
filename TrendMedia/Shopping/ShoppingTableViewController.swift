//
//  ShoppingTableViewController.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/07/19.
//

import UIKit

import RealmSwift

class ShoppingTableViewController: UITableViewController {

    
    @IBOutlet weak var shoppingTextField: UITextField!
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var mainUIView: UIView!
    
    var shoppingList = ["그립톡 구매하기", "사이다 구매", "아이패드 최저가 알아보기", "양말"]
    
    let localRealm = try! Realm()

    var tasks: Results<UserShopping>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
        tasks = localRealm.objects(UserShopping.self).sorted(byKeyPath: "updatedDate", ascending: true)
        
        designUI()
       
    }
    
    func designUI() {
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
        
        let task = UserShopping(shoppingList: shopping, updatedDate: Date())
        
        try! localRealm.write {
            localRealm.add(task)    // Create(실제로 추가되는 것)
            print("Realm Succeed")
            
            self.tableView.reloadData()
            self.shoppingTextField.text = ""

            //dismiss(animated: true)     // dismiss 위치 => 조건에 따라서 성공시에만 dismiss되도록
        }
        
        view.endEditing(true)
    }
    
    
    func designTextField(item : UITextField) {
        item.attributedPlaceholder = NSAttributedString(string: "무엇을 구매하실 건가요?", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        item.backgroundColor = .systemGray5
        item.borderStyle = .none
    }
    
    
    
    // cell 개수 정해주기
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    // cell design 및 데이터
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.reuseIdentifier, for: indexPath) as? ShoppingListTableViewCell else { return UITableViewCell() }
        
        
        
        cell.configureUI()
        
        cell.shoppingListLabel.font = .boldSystemFont(ofSize: 13)
        cell.bookmarkButton.tintColor = .tintColor
        cell.checkboxButton.tintColor = .tintColor
        cell.bookmarkButton.backgroundColor = .clear
        cell.checkboxButton.backgroundColor = .clear
    
        cell.checkboxButton.addTarget(self, action: #selector(checkboxButtonTapped(_:)), for: .touchUpInside)
        //tasks[indexPath.row].checkMark = cell.checkboxButton.isSelected
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped(_:)), for: .touchUpInside)
        //tasks[indexPath.row].bookMark = cell.bookmarkButton.isSelected
        
        cell.shoppingListLabel.text = tasks[indexPath.row].shoppingList
        
        
        
        return cell
    }
    
    
    @objc
    func checkboxButtonTapped(_ sender: UIButton){
        
        if sender.isSelected {
            sender.isSelected = false
            sender.setImage(UIImage(systemName: "checkmark.square" ), for: .normal)
            
        } else { // 눌린 상태로
            sender.isSelected = true
            sender.setImage(UIImage(systemName: "checkmark.square.fill" ), for: .normal)
            
        }
        
    }
    
    @objc
    func bookmarkButtonTapped(_ sender: UIButton){
        // 초기 false
        if sender.isSelected {
            sender.isSelected = false
            sender.setImage(UIImage(systemName: "star"), for: .normal)
        } else {
            sender.isSelected = true
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            
            DispatchQueue.main.async {
                self.shoppingList.remove(at: indexPath.row)
                tableView.reloadData()
            }
            
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }

}

extension ShoppingTableViewController {
    
    // textfield 비어있을 때 alert action
    func showAlertController() {
        
        let alert = UIAlertController(title: "경고", message: "다시 입력해주세요", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
   
}
