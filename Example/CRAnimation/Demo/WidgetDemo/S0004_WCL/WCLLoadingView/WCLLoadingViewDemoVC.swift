//
//  WCLLoadingViewDemoVC.swift
//  CRAnimation
//
// **************************************************
// *                                  _____         *
// *         __  _  __     ___        \   /         *
// *         \ \/ \/ /    / __\       /  /          *
// *          \  _  /    | (__       /  /           *
// *           \/ \/      \___/     /  /__          *
// *                               /_____/          *
// *                                                *
// **************************************************
//  Github  :https://github.com/631106979
//  HomePage:https://imwcl.com
//  CSDN    :http://blog.csdn.net/wang631106979
//
//  Created by 王崇磊 on 16/9/14.
//  Copyright © 2016年 王崇磊. All rights reserved.
//
// @class WCLLoadingViewDemoVC
// @abstract WCLLoadingView的DemoVC
// @discussion WCLLoadingView的DemoVC
//

import UIKit

class WCLLoadingViewDemoVC: CRBaseViewController {

    @IBOutlet weak var loadingView: WCLLoadingView!
    //MARK: Public Methods
    
    
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadingView.startAnimation()
        view.backgroundColor = UIColor.init(rgba: "#F6F4F2")
        addTopBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Target Methods
    @IBAction func tapLoadingView(_ sender: UITapGestureRecognizer) {
        switch loadingView.status {
        case .animating:
            loadingView.pauseAnimation()
        case .pause:
            loadingView.resumeAnimation()
        case .normal:
            loadingView.startAnimation()
        }
    }
    
    @IBAction func sizeSliderValueChange(_ sender: UISlider) {
        loadingView.transform = CGAffineTransform.identity.scaledBy(x: CGFloat(sender.value) , y: CGFloat(sender.value))
    }
    
    @IBAction func durationSliderValueChange(_ sender: UISlider) {
        loadingView.duration = Double(sender.value)
    }
}
