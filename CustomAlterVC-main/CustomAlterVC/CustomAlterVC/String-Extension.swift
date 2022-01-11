//
//  String-Extension.swift
//  wristBand
//
//  Created by suhengxian on 2021/11/10.
//

import Foundation
import UIKit

public extension String {
    // 根据字符串的实际内容，在固定的宽度和字体的大小下，动态的计算出实际的高度
    func textHeightFromTextString(text: String, textWidth:CGFloat, fontSize: CGFloat, isBold: Bool) -> CGFloat {
        
            var dict: NSDictionary = NSDictionary()
            if (isBold) {
                dict = NSDictionary(object: UIFont.boldSystemFont(ofSize: fontSize),forKey: NSAttributedString.Key.font as NSCopying)
            } else {
                dict = NSDictionary(object: UIFont.systemFont(ofSize: fontSize),forKey: NSAttributedString.Key.font as NSCopying)
            }
        
            let rect: CGRect = (text as NSString).boundingRect(with: CGSize(width: textWidth,height: CGFloat(MAXFLOAT)), options: [NSStringDrawingOptions.truncatesLastVisibleLine, NSStringDrawingOptions.usesFontLeading,NSStringDrawingOptions.usesLineFragmentOrigin],attributes: dict as? [NSAttributedString.Key : Any] ,context: nil)
        
            return rect.size.height 
    }
    
    func textWidthFromTextString(text:String,textHeight:CGFloat,fontSize:CGFloat,isBold:Bool) ->CGFloat{
        
        var dict: NSDictionary = NSDictionary()
        if (isBold) {
            dict = NSDictionary(object: UIFont.boldSystemFont(ofSize: fontSize),forKey: NSAttributedString.Key.font as NSCopying)
        } else {
            dict = NSDictionary(object: UIFont.systemFont(ofSize: fontSize),forKey: NSAttributedString.Key.font as NSCopying)
        }
        
        let rect: CGRect = (text as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT),height:textHeight), options: [NSStringDrawingOptions.truncatesLastVisibleLine, NSStringDrawingOptions.usesFontLeading,NSStringDrawingOptions.usesLineFragmentOrigin],attributes: dict as? [NSAttributedString.Key : Any] ,context: nil)
        
        return rect.size.width
    }
}
