//
//  BucketlistTableViewController.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/07/19.
//

import UIKit


struct Todo {
    var title: String
    var done: Bool
}

class BucketlistTableViewController: UITableViewController {

    static let identifier = "BucketlistTableViewController"
    
    
    //클래스는 Reference Type -> 인스턴스 자체를 변경하지 않는 이상 한 번만 될 거다!
    //IBOutlet ViewDidload 호출 되기 직전에 nil이 아닌 지 nil 인지 알 수 있음!
    @IBOutlet weak var userTextField: UITextField! {
        didSet {
            userTextField.textAlignment = .center
            userTextField.font = .boldSystemFont(ofSize: 22)
            userTextField.textColor = .systemRed
            print("텍스트필드 DidSet")
        }
    }
    
    //(1) 값 전달
    var textfieldPlaceholder: String?
    //옵셔널 스트링 타입으로 선언하더라도 오류가 뜨지 않는 이유는?
    //프로퍼티 자체(placeholder)가 옵셔널이라면? ㅇ
    //하지만 String Interpolation이라면? > 오류 발생
    
    //list프로퍼티가 추가, 삭제 등 변경되고 나서 테이블 뷰 항상 갱신!
    
    var list = [Todo(title: "범죄도시2", done: true), Todo(title: "마녀2", done: false) ]{
        didSet {
            tableView.reloadData() // 배열(list)이 바뀌면 테이블 뷰를 갱신해주어라
            print("list가 변경 됨! \(list), \(oldValue) ")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //(3) 값 받음
        userTextField.text = ""
        userTextField.placeholder = "\(String(describing: textfieldPlaceholder))를/을 입력해보세요"
        
        
        
        navigationItem.title = "버킷리스트"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonTapped))
        
        tableView.rowHeight = 80
        
//        list.append("마녀2")
//        list.append("마녀3")
            
        
        
        
    }
    
    @objc
    func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        
        //guard let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) else { return } // else문에 alert, toast 사용해서 빈칸, 글자수 알려줘야함
        
        
        list.append(Todo(title: sender.text!, done: false))        //tableView.reloadData()//중요!!!⭐️

      
        //tableView.reloadSections(IndexSet(, with: <#T##UITableView.RowAnimation#>)
        //tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 매개변수 추가 이유: custom cell에 넘겨주려고
        let cell = tableView.dequeueReusableCell(withIdentifier: BucketlistTableViewCell.identifier, for: indexPath) as! BucketlistTableViewCell
        
        cell.bucklistLabel.text = list[indexPath.row].title           // navi title 17
        cell.bucklistLabel.font = .boldSystemFont(ofSize: 15) // tab bar 11~ 12
        
        // 버튼 새로 생길 때마다 인덱스패스 남김
        cell.checkboxButton.tag = indexPath.row
        cell.checkboxButton.addTarget(self, action: #selector(checkBoxButtonTapped), for: .touchUpInside)
        
        let value = list[indexPath.row].done ? "checkmark.square.fill" : "checkmark.square"
        cell.checkboxButton.setImage(UIImage(systemName: value), for: .normal)
        
        return cell
        
        
    }
    
    @objc
    func checkBoxButtonTapped(sender: UIButton) {
        print("\(sender.tag)번째 버튼 눌림!")
        
        //배열 인덱스를 찾아서 done을 바꿔야 함. 이후 테이블 뷰 갱신(기능은 버튼을 클릭 했을 때, 이미지를 바꿔주는 것은 cellForRaw에서 처리
        list[sender.tag].done = !list[sender.tag].done
        
        //tableView.reloadData()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        
        
        //재사용 셀 오류 확인용 코드
        //sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        
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
            //tableView.reloadData()
        }
    }
    
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        //즐겨찾기, 핀고정
//    }
    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
    
}
