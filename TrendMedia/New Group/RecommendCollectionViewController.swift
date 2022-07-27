//
//  RecommendCollectionViewController.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/07/20.
//

import UIKit
import Toast
import Kingfisher
/*
tableView -> CollectionView
 Row > Item
 heightForRowAt > Flowlayout (heightForItemAt이 없는 이유 -> 가로 세로를 다 정해야해서)
*/


class RecommendCollectionViewController: UICollectionViewController {
    
    
    
    //.   (1).  값 전달 - 데이터를 받을 공간 (프로퍼티)생성
    var movieData : Movie?
    
    var image = "https://img.hankyung.com/photo/202205/01.29908345.1-1200x.jpg"
    static let identifier = "RecommendCollectionViewController"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // (3). 값 전달
        //title = movieTitle == nil ? "데이터 없음" : movieTitle!
        title = movieData?.title
        
        
        //estimate size는 항상 none으로 설정!
        //컬렉션뷰의 셀 크기, 셀 사이의 간격 등 설정(layout -> 대게 비율로 크기를 잡기 때문)
        //인스턴스 생성
        let layout = UICollectionViewFlowLayout()
        //셀 간의 간격, 너비를 보통 상수로 정해놓음(타입 어노테이션을 해놓으면 더 편함!)
        let spacing: CGFloat = 8
        // 셀의 너비
        let width = UIScreen.main.bounds.width - (spacing * 4)
        //셀이 가지고 있는 크기(CGSize)를 초기화
        layout.itemSize = CGSize(width: width / 3 , height: (width / 3) * 1.2 )
        //스크롤 방향
        layout.scrollDirection = .vertical
        // 섹션 간격
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        //셀 간격 , 보통 같게 둔다 -> 셀 사이즈가 각각 다른 테이블뷰에서 최소한의 간격을 설정해야하기 때문에 minimum키워드가 붙는듯!
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        //레이아웃 사용할 거라고 말해줌
        collectionView.collectionViewLayout = layout
        
        //Compositial Layout iOS 14 이상에서 콜렉션뷰를 사용하는 코드
        
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // else 구문 빈 인스턴스 생성해서 반환하는 식으로
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCollectionViewCell", for: indexPath) as? RecommendCollectionViewCell else { return UICollectionViewCell() }
        
        cell.posterimageView.backgroundColor = .orange
        // kingfisher 사용
        let url = URL(string: image)
        cell.posterimageView.kf.setImage(with: url)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 기본
//        view.makeToast("토스트 \(indexPath.item)개 먹고싶다.")
        //키보드 올라왔을때 위치 선정
        view.makeToast("토스트 \(indexPath.item)개 먹고싶다." , duration: 2 , position: .center)
        
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
}
