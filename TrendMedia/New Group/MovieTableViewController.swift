//
//  MovieTableViewController.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/07/20.
//

import UIKit

class MovieTableViewController: UITableViewController {

    let movieList = MovieInfo()
    
    //MARK: 뷰컨트롤러의 생명주기
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "처음으로", style: .plain, target: self, action: #selector(resetButtonTapped))
                
    }
    
    //MARK: 일반 액션
    
    ///시작 화면으로 돌아가는 메서드
    @objc
    func resetButtonTapped() {
        
        // ios 13+ 에서 루트뷰를 다룰때 Scene Delegate 쓸 때 동작하는 코드
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "RecommendCollectionViewController") as! RecommendCollectionViewController
        
        
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    
    //MARK: 테이블뷰 메서드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.movie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        let data = movieList.movie[indexPath.row]
        cell.configureCell(data: data)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle = .delete {
//
//
//        }
//    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("didSelectRowAt") //동작하지 않는다면? 1.tableView가 noSelection 2. 셀 위에 전체 버튼을 놓았을 때
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: RecommendCollectionViewController.identifier) as! RecommendCollectionViewController
        
        
        
        //    (2) 값 전달 -VC가 가지고 있는 프로퍼티에 데이터 추가
        vc.movieData = movieList.movie[indexPath.row]
        
        
        
        // * 이 코드는 MovieTVC가 naviController를 갖고 있으면 push 스타일로 화면전환을 해준다.
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
        
    }
    
    
}
