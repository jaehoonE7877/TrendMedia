//
//  BackupTableViewController.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/08/26.
//

import UIKit

import RealmSwift
import Zip

class BackupTableViewController: UITableViewController {

    var zipFileNameList: [String]?
    var zipFileSizeList: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDocumentZipFile { self.zipFileNameList = $0 }
        configure()
    }

    func configure() {
                
        let backupButton = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButtonTapped))
        let restoreButton = UIBarButtonItem(title: "복구", style: .plain, target: self, action: #selector(restoreButtonTapped))
        navigationItem.rightBarButtonItems = [backupButton, restoreButton]

    }
    
    @objc
    func backupButtonTapped() {

        var urlPaths = [URL]()
        
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        // 도큐먼트 안에 백업 파일
        let realmFile = path.appendingPathComponent("default.realm")
        
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            showAlertMessage(title: "백업할 파일이 없습니다.")
            return
        }
        
        urlPaths.append(URL(string: realmFile.path)!)
        
        //백업 파일 압축: URL 배열
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "ShoppingList_\(Date())")
            print("Archive Location: \(zipFilePath)")
            
            //ActivityViewController 띄우기
            showActivityViewController()
            
        } catch {
            showAlertMessage(title: "압축을 실패했습니다")
        }
    
    }
    
    @objc
    func restoreButtonTapped() {
        
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        
        self.present(documentPicker, animated: true)
    }
    
    func showActivityViewController() {
        
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        let backupFileURL = path.appendingPathComponent("ShoppingList_\(Date()).zip")
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
}

extension BackupTableViewController {
    
    //zip file 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zipFileNameList?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackupTableViewCell.reuseIdentifier, for: indexPath) as? BackupTableViewCell else { return UITableViewCell() }
        
        cell.fileNameLabel.text = zipFileNameList?[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension BackupTableViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    // 압축파일을 풀어서 데이터를 가져오기
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        //FilePicker안에 선택된 파일의 주소 ~/FileApp/Folder/MyDiary.zip
        guard let selectedFileURL = urls.first else {
            showAlertMessage(title: "선택하신 파일을 찾을 수 없습니다.")
            return
        }
        // 도큐먼트 파일의 주소 ~/Documents
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        // ~Documents/MyDiary.zip + 이 주소의 파일이 있는지 없는지를 확인해주기
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            let fileURL = path.appendingPathComponent(sandboxFileURL.lastPathComponent)
            
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    
                    // progress view 띄워주기
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlertMessage(title: "복구가 완료 됐습니다.")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
            } catch {
                showAlertMessage(title: "압축 해제에 실패했습니다.")
            }
            
            
        } else {
            
            // 경로에 파일이 없는 상황 -> copy를 해줌
            do {
                // 파일 앱의 zip파일을 도큐먼트 폴더에 복사
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent(sandboxFileURL.lastPathComponent)
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlertMessage(title: "복구가 완료 됐습니다.")
                })
            } catch {
                showAlertMessage(title: "압축 해제에 실패했습니다.")
            }
            
        }
        
    }
}

extension UIViewController {
    
    func showAlertMessage(title: String, button: String = "확인") {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

/*
 zip: [file:///Users/jaehoon/Library/Developer/CoreSimulator/Devices/D708A158-D2C4-4D3F-8CF8-E8C796D41184/data/Containers/Data/Application/7ECC51D6-A728-4D9A-91FD-01D9DFC59B61/Documents/MyDiary.zip]
 result = ["MyDiary.zip"]
 */
