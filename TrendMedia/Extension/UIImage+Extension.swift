//
//  UIImage+Extension.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/08/25.
//

import UIKit

extension UIImage {
    
    func getImageFromURL(_ url: String) -> UIImage {
        
        let data = try? Data(contentsOf: URL(string: url)!)
        
        if let image = UIImage(data: data!) {
            return image
        } else {
            return UIImage(systemName: "xmark")!
        }
        
    }
    
}
