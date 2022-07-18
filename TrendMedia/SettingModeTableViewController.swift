//
//  SettingModeTableViewController.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/07/18.
//

import UIKit

enum settingMenuHeader : Int {
    case all
    case personal
    case etc
}

class SettingModeTableViewController: UITableViewController {

    // 3section, 3,4,1 cells
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    var allSetting = ["공지사항", "실험실", "버전 정보"]
    var personalSetting = ["개인/보안", "알림", "채팅", "멀티프로필"]
    var etcSetting = ["고객센터/도움말"]
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        //전체설정, 개인설정, 기타
        
        switch section {
        case settingMenuHeader.all.rawValue:
            return "전체 설정"
        case settingMenuHeader.personal.rawValue:
            return "개인 설정"
        case settingMenuHeader.etc.rawValue:
            return "기타"
        default:
            return "에러"
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .boldSystemFont(ofSize: 17)
        header.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
    }
    
    // 1단계. cell 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case settingMenuHeader.all.rawValue:
            return allSetting.count
        case settingMenuHeader.personal.rawValue:
            return personalSetting.count
        case settingMenuHeader.etc.rawValue:
            return etcSetting.count
        default:
            return 0
        }
    }
    
    
    //2단계. cell 디자인 및 데이터 넣기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainSettingCell")!
        
        switch indexPath.section {
        case settingMenuHeader.all.rawValue:
            cell.textLabel?.text = allSetting[indexPath.row]
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = .systemFont(ofSize: 14)
        case settingMenuHeader.personal.rawValue:
            cell.textLabel?.text = personalSetting[indexPath.row]
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = .systemFont(ofSize: 14)
        case settingMenuHeader.etc.rawValue:
            cell.textLabel?.text = etcSetting[indexPath.row]
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = .systemFont(ofSize: 14)
        default:
            cell.textLabel?.text = "에러 경고"
        }
        
        return cell
        
    }
    

}
