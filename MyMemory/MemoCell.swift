//
//  MemoCell.swift
//  MyMemory
//
//  Created by changdong young on 2017. 12. 1..
//  Copyright © 2017년 SwiftBook. All rights reserved.
//

import UIKit

class MemoCell: UITableViewCell {
    @IBOutlet var subject: UILabel! // 메모 제목
    @IBOutlet var contents: UILabel! // 메모 내용
    @IBOutlet var regdate: UILabel! //등록 일자
    @IBOutlet var img: UIImageView! // 이미지

}
