//
//  ViewController.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/07/18.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var datePicker: UIDatePicker!
    //언제 아웃렛컬렉션을 사용하는 것이 좋을까?
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var date2label: UILabel!
    
    @IBOutlet var dateLabelCollection: [UILabel]!
    
    @IBOutlet weak var yellowViewleadingConstraint: NSLayoutConstraint!
    // 변수의 스코프 -> 항상 사용하는 상수일 것이기에 여기 스코프에 선언할 수 있지만, 사용하는 빈도에 따라 선언 위치는 바뀌게된다.
    let format = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        format.dateFormat = "yyyy/MM/dd"
    }

    func configureLabelDesign() {
        //1. 아웃렛컬렉션(디자인적인 부분 => UIView 등은 처리가능)
        for i in dateLabelCollection {
            i.font = UIFont.boldSystemFont(ofSize: 20)
            i.textColor = .brown
            yellowViewleadingConstraint.constant = 120
        }
        
        dateLabelCollection[0].text = "첫번째 텍스트"
        dateLabelCollection[1].text = "두번째 텍스트"
        //2. UILabel
        let labelArray = [dateLabel, date2label]
        for i in labelArray {
            i?.font = UIFont.boldSystemFont(ofSize: 20)
            i?.textColor = .brown
        }
        
        dateLabel.text = "첫번째 텍스트"
        date2label.text = "두번째 텍스트"
        
        //결론 : 인덱스를 활용하여 접근하는 것보다 객체 하나하나 연결하는 것이 텍스트를 작성하는 부분에선 더 쉬울 수 있다.
    }
    
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        
        
        dateLabel.text = format.string(from: sender.date)
    }
    
    
    
    
    
}

