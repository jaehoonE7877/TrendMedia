//
//  TrendTableViewController.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/07/21.
//

import UIKit

class TrendTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
   
    @IBAction func movieButtonTapped(_ sender: UIButton) {
        
        //화면전환: 스토리보드 파일 찾고, 스토리보드 내에 뷰컨트롤러 찾고, 그 다음에 화면 전환
        //영화버튼을 클릭하면 BucketListTableView Present로 (Modal)
        
        //1. 여러 스토리보드중에 사용하고 싶은 뷰컨이 있는 스토리보드를 설정(String 은 스토리보드 이름)
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        
        //2. 그 스토리보드에서 여러 뷰컨 중 사용하고싶은 뷰컨 설정
        let vc = sb.instantiateViewController(withIdentifier: BucketlistTableViewController.identifier) as! BucketlistTableViewController
        
        //(2) 값 전달
        vc.textfieldPlaceholder = "영화"
        
        //3. 화면전환 여기서 self 는 class이름
        self.present(vc, animated: true)
    }
    
    @IBAction func dramaButtonTapped(_ sender: UIButton) {
        
        //1. 여러 스토리보드중에 사용하고 싶은 뷰컨이 있는 스토리보드를 설정(String 은 스토리보드 이름)
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        
        //2. 그 스토리보드에서 여러 뷰컨 중 사용하고싶은 뷰컨 설정
        let vc = sb.instantiateViewController(withIdentifier: BucketlistTableViewController.identifier) as! BucketlistTableViewController
        
        //(2) 값 전달
        vc.textfieldPlaceholder = "드라마"
        //2.5. 뷰컨트롤러를 띄우는 방식을 어떻게 할지 present할때 옵션
        vc.modalPresentationStyle = .fullScreen
        
        //3. 화면전환 여기서 self 는 class이름
        self.present(vc, animated: true)
    }
    
    
    @IBAction func bookButtonTapped(_ sender: UIButton) {
        
        //1. 여러 스토리보드중에 사용하고 싶은 뷰컨이 있는 스토리보드를 설정(String 은 스토리보드 이름)
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        
        //2. 그 스토리보드에서 여러 뷰컨 중 사용하고싶은 뷰컨 설정
        let vc = sb.instantiateViewController(withIdentifier: BucketlistTableViewController.identifier) as! BucketlistTableViewController
        
        //(2) 값 전달
        vc.textfieldPlaceholder = "책"
        
        //2.5 네비게이션 컨트롤러 임베드 (네비vc의 루트뷰 설정 )
        let nav = UINavigationController(rootViewController: vc)
        
        //2.5. 뷰컨트롤러를 띄우는 방식을 어떻게 할지 present할때 옵션
        nav.modalPresentationStyle = .fullScreen
        
        //3. 화면전환 여기서 self 는 class이름
        self.present(nav, animated: true)
        
        
        
    }
    
    
    
}
