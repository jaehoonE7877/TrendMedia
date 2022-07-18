//
//  SettingTableViewController.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/07/18.
//

import UIKit

class SettingTableViewController: UITableViewController {

    var birthDayFriends = ["뽀삐", "올라프", "고래밥", "칙촉", "홍길동", "140번째친구"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 20))
        let headerLabel = UILabel(frame: headerView.bounds)
    }
    
    //섹션의 갯수(옵션) -> 섹션이 하나만 있어도 되면 필요 없는 메서드
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "생일인 친구"
        } else if section == 1 {
            return "즐겨찾기"
        } else if section == 2 {
            return "친구 140명"
        } else {        // 100퍼센트 예외처리
            return "섹션"
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "섹션의 푸터"
    }
    
    
    
    
    //1. 셀의 갯수(필수) -> numberOdRowsInSection으로 찾기
    //ex. 카톡의 친구 수 100명 > 셀 100개, 3000명 > 셀 3000개
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return birthDayFriends.count    //생일인 친구의 수 만큼 cell 만들기
        } else if section == 1 {
            return 2
        } else if section == 2 {
            return 10
        } else {
            return 0
        }
        
    }
    
    
    //2. 셀의 디자인과 데이터를 넣는 작업(필수) -> cellForRowAt로 찾기
    //ex. 카톡이름, 프로필 사진, 상태 메시지 등
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //cell * 100
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        if indexPath.section == 0 {
            cell.textLabel?.text = birthDayFriends[indexPath.row]
            cell.textLabel?.textColor = .systemMint
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        } else if indexPath.section == 1{
            cell.textLabel?.text = "1번 인덱스 텍스트"
            cell.textLabel?.textColor = .systemPink
            cell.textLabel?.font = .italicSystemFont(ofSize: 25)
        } else if indexPath.section == 2 {
            cell.textLabel?.text = "2번 인덱스 섹션의 텍스트"
            cell.textLabel?.textColor = .brown
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        }
        
        return cell
    }
    
    
    
}
