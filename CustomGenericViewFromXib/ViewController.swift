//
//  ViewController.swift
//  CustomGenericViewFromXib
//
//  Created by Yume on 2015/9/4.
//  Copyright © 2015年 Yume. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let aa = AAAView<AAAProtocol>(frame: CGRectMake(0, 0, 100, 100))
        aa.data = AAA1()
        view.addSubview(aa)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

