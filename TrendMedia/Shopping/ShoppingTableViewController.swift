//
//  ShoppingTableViewController.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/07/19.
//

import UIKit

import RealmSwift
import Kingfisher

class ShoppingTableViewController: UITableViewController {
    
    
    @IBOutlet weak var shoppingTextField: UITextField!
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var mainUIView: UIView!
    
    let localRealm = try! Realm()
    
    var shoppingImageURL: String?
    
    var tasks: Results<UserShopping>!{
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
        designUI()
        fetchRealm()
        
        self.tableView.reloadData()
    }
    
    
    func fetchRealm() {
        tasks = localRealm.objects(UserShopping.self).sorted(byKeyPath: "updatedDate", ascending: true)
    }
    
    func designUI() {
        // 상단 뷰 설정
        mainUIView.backgroundColor = .systemGray5
        mainUIView.layer.cornerRadius = 8
        
        tableView.rowHeight = 100
        
        restoreButton.setTitle("추가", for: .normal)
        restoreButton.setTitleColor(.white, for: .normal)
        restoreButton.backgroundColor = UIColor.systemGray4
        restoreButton.layer.cornerRadius = 4
        
        designTextField(item: shoppingTextField)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "정렬", image: nil, primaryAction: nil, menu: sortActionSet())
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: self, action: #selector(settingButtonTapped))
    }
    
    @objc
    func settingButtonTapped(){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "BackupTableViewController") as? BackupTableViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // textField action
    @IBAction func shoppingListTextField(_ sender: UITextField) {
        
    }
    
    // 추가 버튼 action(버튼을 누르면 textfield 비워주고, 키보드 올라와있으면 내려주고, 빈칸일 때 누르면 alert띄워주기)
    
    @IBAction func restoreButtonTapped(_ sender: UIButton) {
        
        guard let shopping = shoppingTextField.text else { return }
        
        ImageSearchAPIManager.shared.fetchImageData(query: shopping) { value in
            
            self.shoppingImageURL = value
            
            DispatchQueue.main.async {
                
                let task = UserShopping(shoppingList: shopping, updatedDate: Date(), imageURL: self.shoppingImageURL)
                
                do {
                    try self.localRealm.write{
                        self.localRealm.add(task)
                        
                        self.tableView.reloadData()
                        self.shoppingTextField.text = ""
                        
                    }
                } catch let error {
                    print("Realm Failed" ,error)
                }
                guard let shoppingImageURL = self.shoppingImageURL else { return }
                
                let data = try? Data(contentsOf: URL(string: shoppingImageURL)!)
                if let image = UIImage(data: data!) {
                    self.saveImageToDocument(fileName: "\(task.objectId)", image: image)
                }
            }
            
        }

        view.endEditing(true)
        
    }
    
    
    func designTextField(item : UITextField) {
        item.attributedPlaceholder = NSAttributedString(string: "무엇을 구매하실 건가요?", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        item.backgroundColor = .systemGray5
        item.borderStyle = .none
    }
    
    func sortActionSet() -> UIMenu {
        
        
        let dic = UIAction(title: "가나다순으로 정렬",
                           image: UIImage(systemName: "a.book.closed.fill.ko"),
                           handler: { action in
            self.sortRealm(action: action)
        })
        
        let todo = UIAction(title: "구매예정순으로 정렬",
                            image: UIImage(systemName: "checkmark.square"),
                            handler: { action in
            self.sortRealm(action: action)
        })
        
        let wish = UIAction(title: "즐겨찾기순으로 정렬",
                            image: UIImage(systemName: "heart.fill"),
                            handler: { action in
            self.sortRealm(action: action)
        })
        
        let cancel = UIAction(title: "취소", attributes: .destructive, handler: { _ in print("취소됨")})
        
        
        let menu = UIMenu(title: "", children: [dic, todo, wish, cancel])
        
        return menu
    }
    
    func sortRealm(action: UIAction){
        
        switch action.title {
        case "가나다순으로 정렬":
            tasks = localRealm.objects(UserShopping.self).sorted(byKeyPath: "shoppingList", ascending: true)
        case "구매예정순으로 정렬":
            tasks = localRealm.objects(UserShopping.self).sorted(byKeyPath: "checkMark", ascending: true)
        case "즐겨찾기순으로 정렬":
            tasks = localRealm.objects(UserShopping.self).sorted(byKeyPath: "bookMark", ascending: false)
        default:
            print("Error")
        }
        
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
        cell.bookmarkButton.tintColor = .systemPink
        cell.checkboxButton.tintColor = .tintColor
        
        cell.checkboxButton.tag = indexPath.row
        cell.bookmarkButton.tag = indexPath.row
        
        cell.checkboxButton.addTarget(self, action: #selector(checkboxButtonTapped(_:)), for: .touchUpInside)
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped(_:)), for: .touchUpInside)
        
        
        let checkmark = tasks[indexPath.row].checkMark ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        cell.checkboxButton.setImage(checkmark, for: .normal)
        let bookmark = tasks[indexPath.row].bookMark ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        cell.bookmarkButton.setImage(bookmark, for: .normal)
        
        if let imageURL = tasks[indexPath.row].imageURL {
            cell.shoppingImageView.kf.setImage(with: URL(string: imageURL))
        } else {
            cell.shoppingImageView.image = UIImage(systemName: "xmark")
        }
        
        cell.shoppingListLabel.text = tasks[indexPath.row].shoppingList
        
        return cell
    }
    
    
    @objc
    func checkboxButtonTapped(_ sender: UIButton){
        
        try! localRealm.write{
            tasks[sender.tag].checkMark = !tasks[sender.tag].checkMark
        }
        tableView.reloadData()
    }
    
    @objc
    func bookmarkButtonTapped(_ sender: UIButton){
        // 초기 false
        try! localRealm.write{
            tasks[sender.tag].bookMark = !tasks[sender.tag].bookMark
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            
            do {
                try localRealm.write{
                    localRealm.delete(tasks[indexPath.row])
                    removeImageForDocument(fileName: "\(tasks[indexPath.row])")
                    DispatchQueue.main.async{
                        tableView.reloadData()
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ItemViewController") as? ItemViewController else { return }
        vc.objectId = tasks[indexPath.row].objectId
        
        self.navigationController?.pushViewController(vc, animated: true)
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
