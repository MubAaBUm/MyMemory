//
//  MemoListVC.swift
//  MyMemory
//
//  Created by changdong young on 2017. 12. 1..
//  Copyright © 2017년 SwiftBook. All rights reserved.
//

import UIKit

class MemoListVC: UITableViewController {
    // 앱 델리게이트 객체의 참조 정보를 읽어온다.
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    // 테이블 뷰의 셀 개수를 결정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.appDelegate.memolist.count
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1. memolist 배열 데이터에서 주어진 행에 맞는 데이터를 꺼낸다
        let row = self.appDelegate.memolist[indexPath.row]
        
        // 2. 이미지 속성이 비어 있을 경우 프로토타입 셋 memoCell을 가져오고 그렇지 않을 경우 memoCellWithImage을 가져옵니다.
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        
        // 3. 테이블 객체의 재사용 큐에서 프로토타입 셀의 인스턴스를 꺼내옵니다.
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemoCell
        
        // 4. memoCell 객체의 내용을 구성합니다.
        cell.subject?.text = row.title
        cell.contents?.text = row.contents
        cell.img?.image = row.image
        
        // 5. Date 타입의 날짜를 yyyy-MM-dd HH:mm:ss 포맷에 맞게 변경한다.
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate?.text = formatter.string(from: row.regdate!)
        
        // 6. 테이블 셀에 필요한 모든 코드가 처리되었으므로, 이 셀을 반환합니다.
        return cell
    }
    
    //디바이스 스크린에 뷰 컨트롤러가 나타날 때마다 호출되는 메소드
    override func viewWillAppear(_ animated: Bool) {
        //테이블 데이터를 다시 읽어들인다. 이에 따라 행을 구성하는 로직이 다시 실행될 것이다.
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1. memolist 배열에서 선택된 행에 맞는 데이터를 꺼냅니다. 테이블 행 번호와 배열 내 데이터 번호는 서리 일치하므로 행 번호를 인덱스로 사용합니다.
        let row = self.appDelegate.memolist[indexPath.row]
        
        // 2. Storyboard ID를 이용하여 상세 화면의 인스턴스 vc를 생성합니다.
        // vc는 UIViewController 타입이므로 우리에게 필요한 MemoReadVC 클래스로 캐스팅해야 합니다.
        // 만약 MemoRead에 해당하는 Storyboard ID가 없으면 메소드의 실행은 종료합니다.
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else {
            return
        }
        
        // 3. 방금 준비해 놓은 데이터를 vc 인스턴스의 param 속성에 대입합니다.
        //값이 대입되면 상세 화면으로 이동하는데, 내비게이션 컨트롤러를 이용하여 이를 처리합니다.
        vc.param = row
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
