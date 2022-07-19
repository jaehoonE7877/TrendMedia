//
//  SearchTableViewController.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/07/19.
//

import UIKit






class SearchTableViewController: UITableViewController {

    var movieList = ["도둑들", "범죄도시", "타짜", "어벤져스" ]
    let releasedDate = ["2010. 12. 01 | EN" , "2012. 12. 12 | EN", "2020. 08. 08 | EN", "2018. 10. 30 | EN"  ]
    let moviePlot = ["한 팀으로 활동 중인 한국의 도둑 뽀빠이와 예니콜, 씹던껌, 잠파노. 미술관을 터는데 멋지게 성공한 이들은 뽀빠이의 과거 파트너였던 마카오박이 제안한 홍콩에서의 새로운 계획을 듣게 된다. 여기에 마카오박이 초대하지 않은 손님, 감옥에서 막 출소한 금고털이 팹시가 합류하고 5명은 각자 인생 최고의 반전을 꿈꾸며 홍콩으로 향한다.", "가리봉동 소탕작전 후 4년 뒤, 금천서 강력반은 베트남으로 도주한 용의자를 인도받아 오라는 미션을 받는다. 괴물형사 ‘마석도’(마동석)와 ‘전일만’(최귀화) 반장은 현지 용의자에게서 수상함을 느끼고, 그의 뒤에 무자비한 악행을 벌이는 ‘강해상’(손석구)이 있음을 알게 된다. ‘마석도’와 금천서 강력반은 한국과 베트남을 오가며 역대급 범죄를 저지르는 ‘강해상’을 본격적으로", "전설적인 타짜 ‘짝귀’의 아들이자 고시생인 ‘일출’(박정민)은 공부에는 흥미가 없지만 포커판에서는 날고 기는 실력자다. 포커판에서 우연히 알게 된 ‘마돈나’(최유화)의 묘한 매력에 빠져든 일출은 그녀의 곁을 지키는 ‘이상무’(윤제문)에게 속아 포커의 쓴맛을 제대로 배운다. 돈도 잃고 자존심까지 무너진 채 벼랑 끝에 몰린 도일출, 그의 앞에 정체불명의 타짜 ‘애꾸’(류승범)가 나타난다.", "지구의 안보가 위협당하는 위기의 상황에서 슈퍼히어로들을 불러모아 세상을 구하는, 일명 [어벤져스] 작전. 에너지원 ‘큐브’를 이용한 적의 등장으로 인류가 위험에 처하자 국제평화유지기구인 쉴드 (S.H.I.E.L.D)의 국장 닉 퓨리(사무엘 L.잭슨)는 [어벤져스] 작전을 위해 전 세계에 흩어져 있던 슈퍼히어로들을 찾아나선다. 아이언맨(로버트 다우니 주니어)부터 토르(크리스 헴스워스), 헐크(마크 러팔로), 캡틴 아메리카(크리스 에반스)는 물론"]
    let movieImages = [UIImage(named: "image1"), UIImage(named: "image2"), UIImage(named: "image3"), UIImage(named: "image4") ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 143
    }
    
    func designLabel(labelName: UILabel ,_ num : CGFloat, color: UIColor){
        labelName.font = UIFont.systemFont(ofSize: num)
        labelName.textColor = color
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        cell.backgroundColor = .black
        designLabel(labelName: cell.releaseLabel, 12, color: .white)
        designLabel(labelName: cell.moviePlotLabel, 11, color: .systemGray5)
        
        cell.titleLabel.text = movieList[indexPath.row]
        cell.titleLabel.font = .boldSystemFont(ofSize: 15)
        cell.titleLabel.textColor = .white
        
        cell.releaseLabel.text = releasedDate[indexPath.row]
        cell.moviePlotLabel.text = moviePlot[indexPath.row]
        
        cell.moviePlotLabel.numberOfLines = 5
        
        
        cell.movieImage.image = movieImages[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            movieList.remove(at: indexPath.row)
            tableView.reloadData()
            
        }
    }
    
    

}
