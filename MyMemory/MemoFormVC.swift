//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by changdong young on 2017. 12. 1..
//  Copyright © 2017년 SwiftBook. All rights reserved.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    var subject : String!
    
    @IBOutlet var contents: UITextView!
    @IBOutlet var preview: UIImageView!
    
    // 저장 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func save(_ sender: Any) {
        // 메모 내용이 입력되지 않았을 경우, 경고창을 띄워 알려준다.
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        //데이터를 저장할 MemoData 객체를 생성하고, 제목,내용,이미지,작성 시간을 MemoData 객체에 정의된 속성에 대입한다.
        let data = MemoData()
        
        data.title = self.subject // 제목
        data.contents = self.contents.text // 내용
        data.image = self.preview.image //이미지
        data.regdate = Date() // 작성 시각
        
        //앱 델리게이트 인스턴스를 읽어온 다음, memolist 배열 변수에 방금 생성한 MemoData 객체를 추가한다.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        // 메모 작성 화면을 종료하고 이전 화면으로 돌아간다.
        _ = self.navigationController?.popViewController(animated: true)
       
    }
    
    // 카메라 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func pick(_ sender: Any) {
        // 이미지 피커 인스턴스를 생성한다.
        let picker = UIImagePickerController()
        
        // 이미지 피커 컨트롤러 인스턴스의 델리게이트 속성을 현재의 뷰 컨트롤러 인스턴스로 설정한다.
        picker.delegate = self
        // 이미지 피커 컨트롤러의 이미지 편집을 허용한다. (false일 경우 편집과정을 건너뛴다.)
        picker.allowsEditing = true
        
        // 이미지 피커 컨트롤려 화면을 표시한다.
        self.present(picker, animated: false)
    }
    
    // 이미지 선택을 완료했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 선택된 이미지를 미리보기에 표시한다.
        self.preview.image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        // 이미지 피커 컨트롤러를 닫는다.
        picker.dismiss(animated: false)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // 내용의 최대 15자리까지 읽어  subject 변수에 저장한다.
        
        //텍스트 뷰의 내용을 읽어 NSString타입의 변수에 저장한다.
        let contents = textView.text as NSString
        // 읽어온 내용이 15자리보다 길 경우 15자리까지만, 그보다 짧을 경우 전체 내용을 읽어옵니다.
        let length = ( (contents.length > 15) ? 15 : contents.length)
        // 최대 15자리까지의 내용을 subject 변수에 저장합니다. 이 값이 제목이 됩니다.
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        // 이렇게 뽑아낸 제목을 내비게이션 타이틀에 표시한다.
        self.navigationItem.title = subject
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contents.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
