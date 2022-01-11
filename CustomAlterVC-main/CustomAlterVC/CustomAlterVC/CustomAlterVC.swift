//
//  CustomAlterVC.swift
//  wristBand
//
//  Created by suhengxian on 2021/11/9.
//

import Foundation
import UIKit

typealias SureClosuer = ()->Void
typealias CancelClosure = ()-> Void

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

public class CustomAlterVC:UIViewController{
    
    var alterTitel:String?
    var content:String?
    var cancelTitel:String?
    var okTitel:String?
    
    private let contentView:UIView = UIView()
    private let titelLab:UILabel = UILabel()
    private let contentLab:UILabel = UILabel()
    private let hLine:UIView = UIView()
    private let vLine:UIView = UIView()
    private let okBtn:UIButton = UIButton(type: .custom)
    private let cancelBtn:UIButton = UIButton(type: .custom)
    
    var sureClosure:SureClosuer?
    var cancelClosure:CancelClosure?
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    public convenience init?(alterTitel:String?,content:String?,okTitel:String?,cancelTitel:String?){
        
        self.init()
        
        self.alterTitel = alterTitel
        self.content = content
        self.okTitel = okTitel
        self.cancelTitel = cancelTitel
        
        self.initUI()
        
    }
    
    private func initUI(){
        self.view.addSubview(self.contentView)
        
        self.titelLab.textColor = UIColor.white
        self.titelLab.textAlignment = .center
        self.titelLab.text = self.alterTitel
        self.titelLab.font = UIFont.systemFont(ofSize: 24.0)
        self.contentView.addSubview(self.titelLab)
        
        self.contentLab.textColor = UIColor.white
        self.contentLab.textAlignment = .center
        self.contentLab.numberOfLines = 0
        self.contentLab.sizeToFit()
        self.contentLab.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.contentLab.text = self.content
        self.contentLab.font = UIFont.systemFont(ofSize: 20.0)
        self.contentView.addSubview(self.contentLab)
        
        self.hLine.backgroundColor = UIColor.init(white: 0.5, alpha: 1.0)
        self.contentView.addSubview(self.hLine)
        
        self.cancelBtn.setTitle(self.cancelTitel, for: .normal)
        self.cancelBtn.setTitle(self.cancelTitel, for: .selected)
        self.cancelBtn.setTitleColor(UIColor.white, for: .normal)
        self.cancelBtn.setTitleColor(UIColor.white, for: .selected)
        self.cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        self.cancelBtn.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)
        self.contentView.addSubview(self.cancelBtn)
        
        self.okBtn.setTitle(self.okTitel, for: .normal)
        self.okBtn.setTitle(self.okTitel, for: .selected)
        self.okBtn.setTitleColor(UIColor.white, for: .normal)
        self.okBtn.setTitleColor(UIColor.white, for: .selected)
        self.okBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        self.okBtn.addTarget(self, action: #selector(sure(_:)), for: .touchUpInside)
        self.contentView.addSubview(self.okBtn)
        
        let leftViewSpace = 40.0
        let rightViewSpace = 40.0
        let leftSpace = 30.0
        let rightSpace = 30.0
        let topSpace = 10.0
        let btnHeight = 60.0
        
        let contentViewWidth = kScreenWidth - leftViewSpace - rightViewSpace
        let contenWidth = contentViewWidth - leftSpace - rightSpace
        
        if self.alterTitel == nil || self.alterTitel?.count ?? 0 <= 0{
            self.titelLab.frame = CGRect.init(x: leftSpace, y:topSpace, width:contenWidth,height:0)
        }else{
            self.titelLab.frame = CGRect.init(x:leftSpace, y: topSpace + 10, width:contenWidth, height: 30)
        }
        
        var contentHeight:CGFloat = (self.content?.textHeightFromTextString(text: self.content! , textWidth:contenWidth, fontSize:20.0, isBold: false))!
        
        let kNavigationBarHeight = UIApplication.shared.statusBarFrame.height + 44.0
        
        if contentHeight > kScreenHeight - (kNavigationBarHeight + btnHeight * 2  + topSpace * 5) {
            
            contentHeight = kScreenHeight - kNavigationBarHeight - btnHeight * 2  - topSpace * 2
        }
        
        self.contentLab.frame = CGRect.init(x: leftSpace, y:self.titelLab.frame.maxY + 10.0, width: contenWidth, height: contentHeight + 10)
        
        self.hLine.frame = CGRect.init(x: 0, y: self.contentLab.frame.maxY + 20.0, width: contentViewWidth, height: 1)
        
        self.okBtn.frame = CGRect.init(x:0, y: self.hLine.frame.maxY, width:
                                        contentViewWidth, height:btnHeight)
        
        if self.cancelTitel == nil || self.cancelTitel?.count ?? 0 <= 0{
            self.contentView.frame = CGRect.init(x: leftViewSpace, y: 0, width:contentViewWidth, height: self.okBtn.frame.maxY)
            self.contentView.center = self.view.center
            
        }else{
            let btnWidth = (contentViewWidth - 1)/2.0
            self.vLine.frame = CGRect.init(x: btnWidth, y: self.hLine.frame.maxY, width:1, height:btnHeight)
            self.vLine.backgroundColor = UIColor.init(white: 0.5, alpha: 1.0)
            self.contentView.addSubview(self.vLine)
            
            self.okBtn.frame = CGRect.init(x:btnWidth + 1, y: self.hLine.frame.maxY, width:btnWidth, height:btnHeight)
            self.cancelBtn.frame = CGRect.init(x: 0, y: self.hLine.frame.maxY, width: btnWidth, height:btnHeight)
            
            self.contentView.frame = CGRect.init(x: leftViewSpace, y: 0, width:contentViewWidth, height: self.cancelBtn.frame.maxY)
            self.contentView.center = self.view.center

        }
        
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.clipsToBounds = true
        self.contentView.backgroundColor = UIColor.blue
        
    }
    
    @objc func cancel(_ sender:UIButton){
        if self.cancelClosure != nil{
            self.cancelClosure!()
        }
        self.hide()
    }
    
    @objc func sure(_ sender:UIButton){
        if self.sureClosure != nil{
            self.sureClosure!()
        }
        self.hide()
    }
    
    //隐藏
    func hide(){
        self.dismiss(animated: true) {
            
        }
    }
    
    //显示
    func show(viewController:UIViewController,sureClosure:@escaping SureClosuer, cancelClosure:@escaping CancelClosure){
        
        self.modalPresentationStyle = .custom
        self.modalTransitionStyle = .crossDissolve
        
        self.view.backgroundColor = UIColor.clear
        
        viewController.present(self, animated: true) {
            self.sureClosure = sureClosure
            self.cancelClosure = cancelClosure
        }
        
    }
    
}
