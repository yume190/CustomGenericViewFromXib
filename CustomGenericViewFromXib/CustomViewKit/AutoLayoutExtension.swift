//
//  AutoLayoutExtension.swift
//  CustomViewTest
//
//  Created by Yume on 2015/3/14.
//  Copyright (c) 2015年 yume. All rights reserved.
//

import UIKit

public protocol LayoutAttributeProtocol {
    var view:AnyObject {get}
    var attribute:NSLayoutAttribute {get}
    var multiplier:CGFloat {get}
    var constant:CGFloat {get}
}

public struct LayoutAttribute {
    var view:AnyObject
    var attribute:NSLayoutAttribute
    var multiplier:CGFloat
    var constant:CGFloat
    
    init(view:AnyObject, attribute: NSLayoutAttribute, constant:CGFloat = 0, multiplier:CGFloat = 1.0){
        self.view = view
        self.attribute = attribute
        self.multiplier = multiplier
        self.constant = constant
    }
    
}

public extension UIViewController {
    
    public var topLayoutGuideBottom : LayoutAttribute {
        get { return LayoutAttribute(view: topLayoutGuide, attribute: .Bottom) }
    }
    
    public var bottomLayoutGuideTop : LayoutAttribute {
        get { return LayoutAttribute(view: bottomLayoutGuide, attribute: .Top) }
    }
    
}

public extension UIView {
    
    func addConstraints (constraints: NSLayoutConstraint...){
        for constraint in constraints {
            self.addConstraint(constraint)
        }
    }
    
    public var width : LayoutAttribute {
        get { return LayoutAttribute(view: self, attribute : .Width); }
    }
    
    public var height : LayoutAttribute {
        get { return LayoutAttribute(view: self, attribute : .Height); }
    }
    
    public var leading : LayoutAttribute {
        get { return LayoutAttribute(view: self, attribute : .Leading); }
    }
    
    public var trailing : LayoutAttribute {
        get { return LayoutAttribute(view: self, attribute : .Trailing); }
    }
    
    public var top : LayoutAttribute {
        get { return LayoutAttribute(view: self, attribute : .Top); }
    }
    
    public var bottom : LayoutAttribute {
        get { return LayoutAttribute(view: self, attribute : .Bottom); }
    }
    
    public var centerX : LayoutAttribute {
        get { return LayoutAttribute(view: self, attribute : .CenterX); }
    }
    
    public var centerY : LayoutAttribute {
        get { return LayoutAttribute(view: self, attribute : .CenterY); }
    }
    
}

// MARK: AutoLayout Operator

public func == (left: LayoutAttribute, right: LayoutAttribute) -> NSLayoutConstraint {
    let layoutConstraint = NSLayoutConstraint(item:left.view,
        attribute: left.attribute, relatedBy: NSLayoutRelation.Equal, toItem: right.view,
        attribute: right.attribute, multiplier: right.multiplier, constant: right.constant)
    
    return layoutConstraint
}

public func >= (left: LayoutAttribute, right: LayoutAttribute) -> NSLayoutConstraint {
    let layoutConstraint = NSLayoutConstraint(item: left.view,
        attribute: left.attribute, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: right.view, attribute: right.attribute,
        multiplier: right.multiplier, constant: right.constant);
    return layoutConstraint
}

public func <= (left: LayoutAttribute, right: LayoutAttribute) -> NSLayoutConstraint {
    let layoutConstraint = NSLayoutConstraint(item: left.view,
        attribute: left.attribute, relatedBy: NSLayoutRelation.LessThanOrEqual, toItem: right.view, attribute: right.attribute,
        multiplier: right.multiplier, constant: right.constant);
    return layoutConstraint
}

public func == (left: LayoutAttribute, right: CGFloat) -> NSLayoutConstraint {
    let layoutConstraint = NSLayoutConstraint(item:left.view,
        attribute: left.attribute, relatedBy: NSLayoutRelation.Equal, toItem: nil,
        attribute: .NotAnAttribute, multiplier: 1.0, constant: right)
    
    return layoutConstraint
}

public func <= (left: LayoutAttribute, right: CGFloat) -> NSLayoutConstraint {
    let layoutConstraint = NSLayoutConstraint(item:left.view,
        attribute: left.attribute, relatedBy: NSLayoutRelation.LessThanOrEqual, toItem: nil,
        attribute: .NotAnAttribute, multiplier: 1.0, constant: right)
    
    return layoutConstraint
}

public func >= (left: LayoutAttribute, right: CGFloat) -> NSLayoutConstraint {
    let layoutConstraint = NSLayoutConstraint(item:left.view,
        attribute: left.attribute, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: nil,
        attribute: .NotAnAttribute, multiplier: 1.0, constant: right)
    
    return layoutConstraint
}

// ------------------------------------------

infix operator *+ {
    associativity left
    precedence 150
}

public func *+(left: LayoutAttribute, right: (multiplier:CGFloat, contant:CGFloat)) -> LayoutAttribute {
    let layoutAttribute = LayoutAttribute(view:left.view, attribute: left.attribute, constant: right.contant, multiplier:right.multiplier)
    return layoutAttribute
}

public func *(left: LayoutAttribute, right: CGFloat) -> LayoutAttribute {
    let layoutAttribute = LayoutAttribute(view:left.view, attribute: left.attribute, constant: 0, multiplier:right)
    return layoutAttribute
}

public func +(left: LayoutAttribute, right: CGFloat) -> LayoutAttribute {
    let layoutAttribute = LayoutAttribute(view:left.view, attribute: left.attribute, constant: right, multiplier:left.multiplier)
    return layoutAttribute
}

public func -(left: LayoutAttribute, right: CGFloat) -> LayoutAttribute {
    let layoutAttribute = LayoutAttribute(view:left.view, attribute: left.attribute, constant: -right, multiplier:left.multiplier)
    return layoutAttribute
}

infix operator <~ {
    associativity left
    precedence 125
}

public func <~ (left: NSLayoutConstraint, right: UILayoutPriority) -> NSLayoutConstraint {
    left.priority = right
    return left
}

infix operator <- {
    associativity right
    precedence 90
}

public func <- (left: UIView, right: NSLayoutConstraint) -> UIView {
    left.addConstraint(right)
    return left
}

// MARK: Autolayout Util

public class AutoLayoutUtil {
    
    public typealias AutoLayoutOffset = (top:CGFloat,trailing:CGFloat,bottom:CGFloat,leading:CGFloat)
    
    public class func match(parent parent:UIView,child:UIView,offset:AutoLayoutOffset = AutoLayoutOffset(top:0,trailing:0,bottom:0,leading:0)) {
        parent <- parent.top == child.top - offset.top
        parent <- parent.bottom == child.bottom + offset.bottom
        parent <- parent.trailing == child.trailing + offset.trailing
        parent <- parent.leading == child.leading - offset.leading
    }
    
    // MARK: 靠齊左右
    
    private class func matchTB(viewcontroller viewcontroller:UIViewController,view:UIView) {
        viewcontroller.view <- viewcontroller.topLayoutGuideBottom == view.top
        viewcontroller.view <- viewcontroller.bottomLayoutGuideTop == view.bottom
    }
    
    public class func alignLeft(viewcontroller viewcontroller:UIViewController,view:UIView,width:CGFloat,offset:CGFloat = 0) {
        matchTB(viewcontroller:viewcontroller, view: view)
        viewcontroller.view <- viewcontroller.view.leading == view.leading - offset
        view <- view.width == width
    }
    
    public class func alignRight(viewcontroller viewcontroller:UIViewController,view:UIView,width:CGFloat,offset:CGFloat = 0) {
        matchTB(viewcontroller:viewcontroller, view: view)
        viewcontroller.view <- viewcontroller.view.trailing == view.trailing + offset
        view <- view.width == width
    }
    
    // MARK: 靠齊上下
    
    private class func matchLT(viewcontroller viewcontroller:UIViewController,view:UIView) {
        viewcontroller.view <- viewcontroller.view.leading == view.leading
        viewcontroller.view <- viewcontroller.view.trailing == view.trailing
    }
    
    public class func alignTop(viewcontroller viewcontroller:UIViewController,view:UIView,height:CGFloat,offset:CGFloat = 0) {
        matchLT(viewcontroller:viewcontroller, view: view)
        viewcontroller.view <- viewcontroller.topLayoutGuideBottom == view.top - offset
        view <- view.height == height
    }
    
    public class func alignBottom(viewcontroller viewcontroller:UIViewController,view:UIView,height:CGFloat,offset:CGFloat = 0) {
        matchLT(viewcontroller:viewcontroller, view: view)
        viewcontroller.view <- viewcontroller.bottomLayoutGuideTop == view.bottom + offset
        view <- view.height == height
    }
    
}


