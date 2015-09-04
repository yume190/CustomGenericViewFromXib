//
//  AAAView.swift
//  customvTT
//
//  Created by Yume on 2015/9/4.
//  Copyright © 2015年 Yume. All rights reserved.
//

import UIKit

@objc protocol AAAProtocol {
    var a:String {get}
    var b:String {get}
}

class AAAView<T:AAAProtocol>:CustomDataView<T> {
    
    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var l2: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func className() -> String {
        return "AAAView"
    }

    override func binding(data: T) {
        l1.text = data.a
        l2.text = data.b
    }
}
class AAA1:AAAProtocol {
    @objc var a = "a"
    @objc var b = "b"
}
class AAA2:AAAProtocol {
    @objc var a = "1"
    @objc var b = "2"
}