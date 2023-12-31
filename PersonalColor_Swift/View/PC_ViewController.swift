//
//  PC_ViewController.swift
//  PersonalColor_Swift
//
//  Created by 이종욱 on 2023/09/20.
//

import UIKit
import PhotosUI

class PC_ViewController: UIViewController {
 
    
    // 앨범이미지 담는곳~
    var itemProviders: [NSItemProvider] = []
    
    @IBOutlet var img_upload: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btn_Slect_photo(_ sender: UIButton) {
        presentPicker()
        
    }
    
    // 앨범띄우기
    func presentPicker() {
        
        // PHPickerConfiguration 생성 및 정의
        var config = PHPickerConfiguration()
        
        // 라이브러리에서 보여줄 Assets을 필터를 한다. (기본값: 이미지, 비디오, 라이브포토)
        config.filter = .images
        
        // 다중 선택 갯수 설정 (0 = 무제한)
        config.selectionLimit = 1
        
        // 컨트롤러 연결
        let imagePicker = PHPickerViewController(configuration: config)
        imagePicker.delegate = self
        
        // 앨범띄우기
        self.present(imagePicker, animated: true)
        
    } // func presentPicker() End-

  
    // 앨범선택사진 img에 띄우기
    func addPreviewImage(){
        
        // 사진이 한 개이므로 first로 접근하여 itemProvider를 생성
        guard let itemProvider = itemProviders.first else { return }
        
        // 만약 itemProvider에서 UIImage로 로드가 가능하다면?
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
        // 로드 핸들러를 통해 UIImage를 처리해 줍시다.
        itemProvider.loadObject(ofClass: UIImage.self) {
            [weak self] image, error in
                
            guard let self = self,
            let image = image as? UIImage else { return }
            
        // loadObject가 비동기적으로 처리되기 때문에 UI 업데이트를 위해 메인쓰레드로 변경
        DispatchQueue.main.async {
            self.img_upload.image = image
        
                }
            }
        }
    } // func addPreviewImage() End-
    
}



// 앨범
extension PC_ViewController: PHPickerViewControllerDelegate {
    // picker가 종료되면 동작 함
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        // picker가 선택이 완료되면 화면 내리기
        picker.dismiss(animated: true)
        
        // 만들어준 itemProviders에 Picker로 선택한 이미지정보를 전달
        itemProviders = results.map(\.itemProvider)
        
        // 앨범에서 이미지 선택시 imgview에 보이기
        if !itemProviders.isEmpty {
            addPreviewImage()
            
            // 이미지가 골라지면 정면사진인지 확인
            
            if let image = img_upload.image {
                if let imageData = image.jpegData(compressionQuality: 1.0) {
                    // 이미지 데이터가 준비되었습니다.
                    let serverURL = URL(string: "http://127.0.0.1:5000/rgb")! // Flask 서버 엔드포인트
                    var request = URLRequest(url: serverURL)
                    request.httpMethod = "POST" // POST 요청으로 수정

                    // POST 요청 본문에 이미지 데이터 추가
                    request.httpBody = imageData
                    request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type") // Content-Type 설정

                    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                        if let error = error {
                            print("Error: \(error)")
                            return
                        }

                        if let data = data {
                            // 서버에서 반환한 데이터를 처리합니다.
                            do {
                                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                    // JSON 데이터를 파싱하여 원하는 작업을 수행합니다.
                                    print("Received JSON: \(json)")
                                }
                            } catch {
                                print("Error parsing JSON: \(error)")
                            }
                        }
                    }

                    task.resume() // URLSession 태스크 실행
                }
            }

        }
    }
    

}


