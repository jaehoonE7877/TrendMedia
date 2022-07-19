//
//  SettingModeTableViewController.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/07/18.
//

import UIKit

enum SettingMenuHeader : Int, CaseIterable {
    case all, personal, etc
    
    var sectionTitle: String {
        switch self {
        case .all:
            return "전체 설정"
        case .personal:
            return "개인 설정"
        case .etc:
            return "기타"
        }
    }
    var rowTitle: [String] {
        switch self {
        case .all:
            return ["공지사항", "실험실", "버전 정보"]
        case .personal:
            return ["개인/보안", "알림", "채팅", "멀티프로필"]
        case .etc:
            return ["고객센터/도움말"]
        }
    }
    
}

class SettingModeTableViewController: UITableViewController {

    // 3section, 3,4,1 cells
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingMenuHeader.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        //전체설정, 개인설정, 기타
        return SettingMenuHeader.allCases[section].sectionTitle

    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .boldSystemFont(ofSize: 16)
        header.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
    }
    
    // 1단계. cell 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SettingMenuHeader.allCases[section].rowTitle.count
        
    }
    
    
    //2단계. cell 디자인 및 데이터 넣기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainSettingCell")!
        
        cell.textLabel?.text = SettingMenuHeader.allCases[indexPath.section].rowTitle[indexPath.row]
        cell.textLabel?.textColor = .black
        cell.textLabel?.font = .systemFont(ofSize: 14)
        
        return cell
        
    }
    

}
