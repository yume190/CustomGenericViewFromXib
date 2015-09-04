import UIKit

@available(iOS 9.0, *)
public struct AnchorAttribute {
    var anchor:NSLayoutAnchor
    var constant:CGFloat
    
    init(anchor:NSLayoutAnchor, constant:CGFloat = 0){
        self.anchor = anchor
        self.constant = constant
    }
    
}

@available(iOS 9.0, *)
public struct DimensionAnchorAttribute {
    var anchor:NSLayoutDimension
    var multiplier:CGFloat
    var constant:CGFloat
    
    init(anchor:NSLayoutDimension, constant:CGFloat = 0, multiplier:CGFloat = 1.0){
        self.anchor = anchor
        self.multiplier = multiplier
        self.constant = constant
    }
    
}

@available(iOS 9.0, *)
public struct ViewAnchor {
    
    var view:UIView
    
    init(view:UIView) {
        self.view = view
    }
    
    public var leading : AnchorAttribute { get { return AnchorAttribute(anchor: view.leadingAnchor) }}
    public var trailing : AnchorAttribute { get { return AnchorAttribute(anchor: view.trailingAnchor) }}
    public var left : AnchorAttribute { get { return AnchorAttribute(anchor: view.leftAnchor) }}
    public var right : AnchorAttribute { get { return AnchorAttribute(anchor: view.rightAnchor) }}
    public var top : AnchorAttribute { get { return AnchorAttribute(anchor: view.topAnchor) }}
    public var bottom : AnchorAttribute { get { return AnchorAttribute(anchor: view.bottomAnchor) }}
    public var width : DimensionAnchorAttribute { get { return DimensionAnchorAttribute(anchor: view.widthAnchor) }}
    public var height : DimensionAnchorAttribute { get { return DimensionAnchorAttribute(anchor: view.heightAnchor) }}
    public var centerX : AnchorAttribute { get { return AnchorAttribute(anchor: view.centerXAnchor) }}
    public var centerY : AnchorAttribute { get { return AnchorAttribute(anchor: view.centerYAnchor) }}
}

@available(iOS 9.0, *)
extension UIView {
    public var anchor:ViewAnchor { get { return ViewAnchor(view:self) }}
}

@available(iOS 9.0, *)
public struct LayoutGuideAnchor {
    
    var guide:UILayoutGuide
    
    init(guide:UILayoutGuide) {
        self.guide = guide
    }
    
    public var leading : AnchorAttribute { get { return AnchorAttribute(anchor: guide.leadingAnchor) }}
    public var trailing : AnchorAttribute { get { return AnchorAttribute(anchor: guide.trailingAnchor) }}
    public var left : AnchorAttribute { get { return AnchorAttribute(anchor: guide.leftAnchor) }}
    public var right : AnchorAttribute { get { return AnchorAttribute(anchor: guide.rightAnchor) }}
    public var top : AnchorAttribute { get { return AnchorAttribute(anchor: guide.topAnchor) }}
    public var bottom : AnchorAttribute { get { return AnchorAttribute(anchor: guide.bottomAnchor) }}
    public var width : DimensionAnchorAttribute { get { return DimensionAnchorAttribute(anchor: guide.widthAnchor) }}
    public var height : DimensionAnchorAttribute { get { return DimensionAnchorAttribute(anchor: guide.heightAnchor) }}
    public var centerX : AnchorAttribute { get { return AnchorAttribute(anchor: guide.centerXAnchor) }}
    public var centerY : AnchorAttribute { get { return AnchorAttribute(anchor: guide.centerYAnchor) }}

}

@available(iOS 9.0, *)
extension UILayoutGuide {
    public var anchor:LayoutGuideAnchor { get { return LayoutGuideAnchor(guide:self) }}
}

@available(iOS 9.0, *)
extension UIViewController {
//    public var a : AnchorAttribute { get { return AnchorAttribute(anchor: topLayoutGuide.topAnchor) }}
    public var topLayoutGuideBottomAnchor : AnchorAttribute { get { return AnchorAttribute(anchor: topLayoutGuide.bottomAnchor) }}
//    public var heaight : DimensionAnchorAttribute { get { return DimensionAnchorAttribute(anchor: topLayoutGuide.heightAnchor) }}
    
    public var bottomLayoutGuideTopAnchor : AnchorAttribute { get { return AnchorAttribute(anchor: bottomLayoutGuide.topAnchor) }}
//    public var leadfing : AnchorAttribute { get { return AnchorAttribute(anchor: bottomLayoutGuide.bottomAnchor) }}
//    public var heighgt : DimensionAnchorAttribute { get { return DimensionAnchorAttribute(anchor: bottomLayoutGuide.heightAnchor) }}
}

@available(iOS 9.0, *)
public func == (left: AnchorAttribute, right: AnchorAttribute) -> NSLayoutConstraint! {
    return left.anchor.constraintEqualToAnchor(right.anchor, constant: right.constant)
}

@available(iOS 9.0, *)
public func >= (left: AnchorAttribute, right: AnchorAttribute) -> NSLayoutConstraint! {
    return left.anchor.constraintGreaterThanOrEqualToAnchor(right.anchor, constant: right.constant)
}

@available(iOS 9.0, *)
public func <= (left: AnchorAttribute, right: AnchorAttribute) -> NSLayoutConstraint! {
    return left.anchor.constraintLessThanOrEqualToAnchor(right.anchor, constant: right.constant)
}

@available(iOS 9.0, *)
public func +(left: AnchorAttribute, right: CGFloat) -> AnchorAttribute {
    return AnchorAttribute(anchor: left.anchor, constant: right)
}

@available(iOS 9.0, *)
public func -(left: AnchorAttribute, right: CGFloat) -> AnchorAttribute {
    return AnchorAttribute(anchor: left.anchor, constant: -right)
}

// ---------------------------------------------------

@available(iOS 9.0, *)
public func == (left: DimensionAnchorAttribute, right: DimensionAnchorAttribute) -> NSLayoutConstraint! {
    return left.anchor.constraintEqualToAnchor(right.anchor, multiplier: right.multiplier, constant: right.constant)
}

@available(iOS 9.0, *)
public func >= (left: DimensionAnchorAttribute, right: DimensionAnchorAttribute) -> NSLayoutConstraint! {
    return left.anchor.constraintGreaterThanOrEqualToAnchor(right.anchor, multiplier: right.multiplier, constant: right.constant)
}

@available(iOS 9.0, *)
public func <= (left: DimensionAnchorAttribute, right: DimensionAnchorAttribute) -> NSLayoutConstraint! {
    return left.anchor.constraintLessThanOrEqualToAnchor(right.anchor, multiplier: right.multiplier, constant: right.constant)
}

@available(iOS 9.0, *)
public func == (left: DimensionAnchorAttribute, right: CGFloat) -> NSLayoutConstraint! {
    return left.anchor.constraintEqualToConstant(right)
}

@available(iOS 9.0, *)
public func >= (left: DimensionAnchorAttribute, right: CGFloat) -> NSLayoutConstraint! {
    return left.anchor.constraintGreaterThanOrEqualToConstant(right)
}

@available(iOS 9.0, *)
public func <= (left: DimensionAnchorAttribute, right: CGFloat) -> NSLayoutConstraint! {
    return left.anchor.constraintLessThanOrEqualToConstant(right)
}

@available(iOS 9.0, *)
public func *(left: DimensionAnchorAttribute, multiplier: CGFloat) -> DimensionAnchorAttribute {
    return DimensionAnchorAttribute(anchor: left.anchor, constant: 0, multiplier: multiplier)
}

@available(iOS 9.0, *)
public func +(left: DimensionAnchorAttribute, constant: CGFloat) -> DimensionAnchorAttribute {
    return DimensionAnchorAttribute(anchor: left.anchor, constant: constant, multiplier: left.multiplier)
}

@available(iOS 9.0, *)
public func -(left: DimensionAnchorAttribute, constant: CGFloat) -> DimensionAnchorAttribute {
    return DimensionAnchorAttribute(anchor: left.anchor, constant: constant, multiplier: left.multiplier)
}