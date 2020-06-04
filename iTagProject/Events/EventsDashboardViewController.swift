//
//  EventsDashboardViewController.swift
//  LMS
//
//  Created by admin on 11/2/17.
//  Copyright © 2017 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit
//import Segmentio
//class EventsDashboardViewController: UIViewController {
//
//    @IBOutlet weak var segmentioView: Segmentio!
//
//    //var swipeMenuArray: NSMutableArray = []
//    var content = [SegmentioItem]()
//
//    override func viewDidLoad() {
//            super.viewDidLoad()
//
//        segmentioView.setup(
//            content: [SegmentioItem],
//            style: SegmentioStyle,
//            options: SegmentioOptions?
//        )
//
//            let tornadoItem = SegmentioItem(
//                (title: "Tornado",
//                image: UIImage(named: "img1")),
//                (title: "Thjfj",
//                image: UIImage(named: "img2img3")),
//                (title: "leiijri",
//                image: UIImage(named: "tornado"))
//            )
//            content.append(tornadoItem)
//
//    }
//
//}






//import CDRTranslucentSideBar.h

class EventsDashboardViewController: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tabBgView: UIView!
    @IBOutlet weak var contentView: BmoViewPager!
    @IBOutlet weak var swipeMenu: SegmentedView!
    @IBOutlet weak var pagerNavView: BmoViewPagerNavigationBar!
    var swipeMenuArray: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationBarButton()
        self.navigationController?.navigationBar.isHidden = true
        self.setMenu()
    }
    func navigationBarButton() {
        menuButton.titleLabel?.font = UIFont(name: "fontawesome", size: 25)
        menuButton.setTitle(" \u{f104}", for: UIControl.State.normal)
        menuButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        menuButton.addTarget(self, action: #selector(self.backButtonClicked(sender:)), for: UIControl.Event.touchUpInside)
    }
    @objc func backButtonClicked(sender:UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setMenu() {
        swipeMenuArray = ["Events", "Drafts"]
        contentView.dataSource = self
        contentView.delegate   = self
        pagerNavView.viewPager    = contentView
        contentView.infinitScroll = true
        pagerNavView.autoFocus    = false
    }

    @IBAction func createEvnetAction(_ sender: Any) {

        let viewController:AddNewEventViewController=self.storyboard?.instantiateViewController(withIdentifier: "AddNewEventViewController") as! AddNewEventViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension EventsDashboardViewController: BmoViewPagerDataSource, BmoViewPagerDelegate {
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
        let view = UnderLineView()
        view.marginX   = 2.0
        view.lineWidth = 3.0
        view.strokeColor = UIColor.cyan
        return view
    }
    func bmoViewPagerDataSourceNaviagtionBarItemSize(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> CGSize {
        let page: CGFloat = CGFloat(swipeMenuArray.count)
        return CGSize(width: navigationBar.bounds.width / page, height: navigationBar.bounds.height)
    }
    func bmoViewPagerDataSourceNaviagtionBarItemTitle(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> String? {
        return "\(swipeMenuArray[page])"
    }
    // Required
    func bmoViewPagerDataSourceNumberOfPage(in viewPager: BmoViewPager) -> Int {
        print(swipeMenuArray.count)
        return swipeMenuArray.count
    }
    func bmoViewPagerDataSource(_ viewPager: BmoViewPager, viewControllerForPageAt page: Int) -> UIViewController {
        if page == 0 {
            let viewController: EventsViewController=self.storyboard?.instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
//            viewController.eventType = "Published"
            return viewController
        }
        if page == 1 {
            let viewController: EventsViewController=self.storyboard?.instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
//            viewController.eventType = "Draft"
            return viewController
        }
        else {
            let viewController: EventsViewController=self.storyboard?.instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
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
