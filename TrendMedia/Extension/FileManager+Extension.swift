//
//  FileManager+Extension.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/08/25.
//

import UIKit

extension UIViewController {
    
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDirectory
    }
    
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        //Document 경로를 알려줌
        guard let path = documentDirectoryPath() else { return }
                
        //Document 이후 세부 경로(이미지를 저장할 위치)
        let fileURL = path.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 0.4) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("file save error", error)
        }
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        
        guard let path = documentDirectoryPath() else { return nil }
       
        //Document 이후 세부 경로(이미지를 저장할 위치)
        let fileURL = path.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "star.fill")     // 준비중 이미지 띄우기
        }
        
    }
    
    func removeImageForDocument(fileName: String) {
        guard let path = documentDirectoryPath() else { return }
        
        let fileURL = path.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
        
    }
    
    func fetchDocumentZipFile(completion: @escaping ([String]) -> () ) {
        
        do {
            guard let path = documentDirectoryPath() else { return }
            
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            print("docs: \(docs)")
            
            let zip = docs.filter { $0.pathExtension == "zip" }
            print("zip: \(zip)")
            
            let result = zip.map { $0.lastPathComponent }
            print("result = \(result)")
            
            completion(result)
        } catch {
            print("ERROR")
        }

    }
    
}
