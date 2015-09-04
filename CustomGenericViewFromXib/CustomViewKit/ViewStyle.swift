//
//  ViewStyle.swift
//  CustomViewTest
//
//  Created by Yume on 2015/3/15.
//  Copyright (c) 2015年 yume. All rights reserved.
//

import UIKit

public var ViewStyleInstance: ViewStyles { get { return ViewStyles.sharedInstance } }

public class ViewStyle{
    public var borderColor:UIColor?
    public var borderWidth:CGFloat?
    public var cornerRadius:CGFloat?
    public var shadowColor:UIColor?
    public var shadowRadius:CGFloat?
    public var shadowOpacity:Float?
    public var shadowOffsetY:CGFloat?
    
    public init(){}
    
    public func set(borderColor borderColor:UIColor) -> ViewStyle{
        self.borderColor = borderColor
        return self
    }
    
    public func set(borderWidth borderWidth:CGFloat) -> ViewStyle{
        self.borderWidth = borderWidth
        return self
    }
    
    public func set(cornorRadius cornorRadius:CGFloat) -> ViewStyle{
        self.cornerRadius = cornorRadius
        return self
    }
    
    public func set(shadowColor shadowColor:UIColor) -> ViewStyle{
        self.shadowColor = shadowColor
        return self
    }
    
    public func set(shadowRadius shadowRadius:CGFloat) -> ViewStyle{
        self.shadowRadius = shadowRadius
        return self
    }
    
    public func set(shadowOpacity shadowOpacity:Float) -> ViewStyle{
        self.shadowOpacity = shadowOpacity
        return self
    }
    
    public func set(shadowOffsetY shadowOffsetY:CGFloat) -> ViewStyle{
        self.shadowOffsetY = shadowOffsetY
        return self
    }
    
}

public class ViewStyles: NSObject {
    
    public class var sharedInstance: ViewStyles {
        dispatch_once(&Inner.token) {
            Inner.instance = ViewStyles()
        }
        return Inner.instance!
    }
    
    struct Inner {
        static var instance: ViewStyles?
        static var token: dispatch_once_t = 0
    }
    
    public func none() -> ViewStyle{
        return ViewStyle().set(borderColor: UIColor.clearColor())
                          .set(borderWidth:0)
                          .set(cornorRadius:0)
                          .set(shadowColor:UIColor.clearColor())
                          .set(shadowRadius:0)
                          .set(shadowOpacity:0)
                          .set(shadowOffsetY:0)
    }
    
    public func fb() -> ViewStyle{
        return ViewStyle().set(borderWidth:10).set(borderColor:UIColor.blueColor()).set(cornorRadius:20)
    }
    
    public func yume() -> ViewStyle{
        return ViewStyle().set(borderWidth:3).set(borderColor:UIColor.purpleColor()).set(cornorRadius:30)
    }
    
    override public func valueForUndefinedKey(key: String) -> AnyObject? {
        return none()
    }
    
}