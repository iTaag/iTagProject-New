//
//  DealsDashboardViewController.swift
//  LMS
//
//  Created by admin on 11/2/17.
//  Copyright © 2017 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit

//import CDRTranslucentSideBar.h

class DealsDashboardViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tabBgView: UIView!
    //@IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var contentView: BmoViewPager!
    @IBOutlet weak var swipeMenu: SegmentedView!
    @IBOutlet weak var pagerNavView: BmoViewPagerNavigationBar!
    
    var swipeMenuArray: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //self.navigationBarButton()
        
        self.navigationController?.navigationBar.isHidden=true
        
        self.setMenu()
    }
    
//    func navigationBarButton() {
//        menuButton.titleLabel?.font=UIFont(name: "fontawesome", size: 25)
//        menuButton.setTitle(" \u{f104}", for: UIControl.State.normal)
//        menuButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
//        menuButton.addTarget(self, action: #selector(self.backButtonClicked(sender:)), for: UIControl.Event.touchUpInside)
//    }
    
    @objc func backButtonClicked(sender:UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func setMenu() {
        swipeMenuArray = ["Tagged", "Others"]
        contentView.dataSource = self
        contentView.delegate   = self
        pagerNavView.viewPager=contentView
        contentView.infinitScroll = true
        pagerNavView.autoFocus    = false
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true);
    }
    
    
    
}
extension DealsDashboardViewController: BmoViewPagerDataSource, BmoViewPagerDelegate {
    // Optional
    func bmoViewPagerDataSourceNaviagtionBarItemNormalAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedString.Key : Any]? {
        return [
            NSAttributedString.Key.strokeWidth     : 1.0,
            NSAttributedString.Key.strokeColor     : UIColor.white,
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
    }
    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedString.Key : Any]? {
        return [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17.0),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
    }
    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedBackgroundView(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> UIView? {
        
        let view      = UnderLineView()
        view.marginX  = 2.0
        view.lineWidth = 2.0
        view.strokeColor = UIColor.white
        return view
    }
    func bmoViewPagerDataSourceNaviagtionBarItemSize(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> CGSize {
        
        let page: CGFloat=CGFloat(swipeMenuArray.count)
        return CGSize(width: navigationBar.bounds.width / page, height: navigationBar.bounds.height)
    }
    func bmoViewPagerDataSourceNaviagtionBarItemTitle(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> String? {
        return "\(swipeMenuArray[page])"
    }
    // Required
    func bmoViewPagerDataSourceNumberOfPage(in viewPager: BmoViewPager) -> Int {
        
        return swipeMenuArray.count
    }
    
    func bmoViewPagerDataSource(_ viewPager: BmoViewPager, viewControllerForPageAt page: Int) -> UIViewController {
        
        if page == 0 {
            let viewController: DealsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DealsViewController") as! DealsViewController
            return viewController
        }
        if page == 1 {
            let viewController: OtherViewController = self.storyboard?.instantiateViewController(withIdentifier: "OtherViewController") as! OtherViewController
            return viewController
        }
        else {
            let viewController: DealsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DealsViewController") as! DealsViewController
            return viewController
        }
    }
    func bmoViewPagerDelegate(_ viewPager: BmoViewPager, pageChanged page: Int) {
        
    }
    func bmoViewPagerDelegate(_ viewPager: BmoViewPager, shouldSelect page: Int) -> Bool {
        
        return true
    }
    func bmoViewPagerDelegate(_ viewPager: BmoViewPager, scrollProgress fraction: CGFloat, index: Int) {
        
    }
    
    func bmoViewPagerDelegate(_ viewPager: BmoViewPager, didAppear viewController: UIViewController, page: Int) {
        
        self.view.endEditing(true)
    }
}
