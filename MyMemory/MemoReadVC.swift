//
//  MemoReadVC.swift
//  MyMemory
//
//  Created by changdong young on 2017. 12. 1..
//  Copyright © 2017년 SwiftBook. All rights reserved.
//

import UIKit

class MemoReadVC: UIViewController {
    // 콘텐츠 데이터를 저장하는 변수
    var param : MemoData?
    @IBOutlet var subject: UILabel!
    @IBOutlet var contents: UILabel!
    @IBOutlet var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. param 변수를 이용하여 화면 객체에 콘텐츠를 출력합니다.
        self.subject.text = param?.title
        self.contents.text = param?.contents
        self.img.image = param?.image
        
        // 2. 날짜 포맷을 지정하여 원하는 형식으로 변환하고 있습니다.
        // 날짜 포맷을 만들 때에는 정형화된 형태만 사용할 수 있는 것이 아니라, 문자열 출력 포맷처럼 필요한 문자열 사이에 날짜 형식을 넣어 출력할 수도 있습니다.
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString = formatter.string(from: (param?.regdate)!)
        
        // 3. 원하는 포맷으로 작성된 날짜 문자열을 내비게이션 타이틀에 넣어 제목 대신 출력합니다.
        self.navigationItem.title = dateString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
