//
//  BucketlistTableViewController.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/07/19.
//

import UIKit

class BucketlistTableViewController: UITableViewController {

    @IBOutlet weak var userTextField: UITextField!
    
    
    var list = ["범죄도시2", "탑건", "토르"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 80
        
        list.append("마녀2")
        list.append("마녀3")
        
    }
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        
        list.append(userTextField.text!)
       
        //중요!!!⭐️
        tableView.reloadData()
        //tableView.reloadSections(IndexSet(, with: <#T##UITableView.RowAnimation#>)
        //tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 매개변수 추가 이유: custom cell에 넘겨주려고
        let cell = tableView.dequeueReusableCell(withIdentifier: "BucketlistTableViewCell", for: indexPath) as! BucketlistTableViewCell
        
        cell.bucklistLabel.text = list[indexPath.row]           // navi title 17
        cell.bucklistLabel.font = .boldSystemFont(ofSize: 15) // tab bar 11~ 12
        
        
        return cell
        
        
    }
    
    //테이블 뷰의 데이터를 삭제할 의도가 있는지 return true
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //예전에 자주 사용한 키워드 (우측 스와이프 디폴트 기능)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
                //배열 데이터 삭제 후 데이블 뷰 데이터 갱신
            list.remove(at: indexPath.row)
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        }
    }
    
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        //즐겨찾기, 핀고정
//    }
    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
    
}
