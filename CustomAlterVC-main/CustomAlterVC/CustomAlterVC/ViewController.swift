//
//  ViewController.swift
//  CustomAlterVC
//
//  Created by suhengxian on 2022/1/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        for index in 0...2 {
            let btn = UIButton.init(type: .custom)
            btn.frame = CGRect.init(x: 40, y: 40 + 60 * index, width: 60, height: 40)
            btn.setTitle("\(index)", for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.tag = 10 + index
            btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
            btn.backgroundColor = UIColor.red
            self.view.addSubview(btn)
            
        }
    }
    
    @objc func btnClick(_ sender:UIButton){
        let tag = sender.tag
        
        switch tag{
        case 10:
            
            let alterVC = CustomAlterVC.init(alterTitel: "提示", content: "hello world", okTitel: "确定", cancelTitel: "取消")
            alterVC?.show(viewController: self, sureClosure: {
                
            }, cancelClosure: {
                
            })
            
        case 11:
            let alterVC = CustomAlterVC.init(alterTitel: "提示", content: "hello world", okTitel: "确定", cancelTitel: "")
            alterVC?.show(viewController: self, sureClosure: {
                
            }, cancelClosure: {
                
            })
            
        default:
            print("hello ")
            
        }
    }
}

