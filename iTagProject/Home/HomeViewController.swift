//
//  HomeViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 19/03/20.
//  Copyright © 2020 iTag. All rights reserved.
//

//import UIKit
//
//class HomeViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//  MainViewController.swift
//  LMS
//
//  Created by admin on 11/2/17.
//  Copyright © 2017 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
//import CDRTranslucentSideBar.h

class HomeViewController: UIViewController, SidePanelDelagate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    let Appdel = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tabBgView: UIView!
    //@IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var contentView: BmoViewPager!
    @IBOutlet weak var swipeMenu: SegmentedView!
    @IBOutlet weak var pagerNavView: BmoViewPagerNavigationBar!
    
    //let dataBase=DataBase()
    
    var menuArray:NSMutableArray=[]
    var menuIconsArray:NSMutableArray=[]
    
    var swipeMenuArray: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.navigationBarButton()
        
        self.navigationController?.navigationBar.isHidden=true
//
        
        
        
        
        
        
        
        
//        let userId: String=UserDefaults.standard.value(forKey: "USERID") as! String
//
//        let addressId: String=UserDefaults.standard.value(forKey: "ADDRESSID") as! String
//        print("the userid home is: \(userId)")
//        print("the addressidhome  is: \(addressId)")
        //UserDefaults.standard.set("NoLogout", forKey:"Signout")
        self.setMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden=true
    }
   
    @objc func menuButtonClicked(sender:UIButton)
    {
        self.setMenuView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setMenuView() {
        let viewController = SidePanelViewController()
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.delegate=self
        viewController.sidePanelBgColor=UIColor.white
        viewController.isIocnLabel=true
        viewController.sidePanelArray=["Profile", "New Joiners", "Logout"]
        viewController.sidePanelImagesArray=[" \u{f007}", " \u{f007}", " \u{f08b}"]
        viewController.setContentViewFrame(width: 260, sender: self)
        viewController.profileImage="mihin_bg.png"
        viewController.userName="MiHIN"
        
        let transition=CATransition()
        transition.duration=1
        transition.type=CATransitionType.push
        transition.subtype=CATransitionSubtype.fromRight
        transition.timingFunction=CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        viewController.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.present(viewController, animated: false, completion: nil)
    }
    func setMenu() {
        swipeMenuArray = ["Chat", "Alerts", "News"]
        
        contentView.dataSource = self
        contentView.delegate   = self
        pagerNavView.viewPager = contentView
        contentView.infinitScroll = true
        pagerNavView.autoFocus = false
    }
    @IBAction func leavesButtonClicked(_ sender: UIButton) {
        print("hello there")
        for view in tabBgView.subviews {
            if (view.isKind(of: UIView.self)) {
                for view1 in view.subviews{
                    if (view1.isKind(of: UILabel.self))
                    {
                        let label: UILabel = view1 as! UILabel
                        label.textColor=UIColor.white
                    }
                    
                    if (view1.isKind(of: UIImageView.self)) {
                        let label: UIImageView = view1 as! UIImageView
                        
                            label.isHighlighted=false
                    }
                }
            }
        }
        
        let senderView: UIView=sender.superview!
        
        for view in senderView.subviews {
            if (view.isKind(of: UILabel.self)) {
                let label: UILabel = view as! UILabel
                
                label.textColor=UIColor.white
            }
            
            if (view.isKind(of: UIImageView.self)) {
                let label: UIImageView = view as! UIImageView
                
                UIView.transition(with: label, duration: 1.0, options: .transitionFlipFromRight, animations: {
                    label.isHighlighted=true
                }, completion: nil)
            }
        }
        
        if sender.tag==1
        {
//            let viewController:ChatViewController=self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
//
//            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        else if sender.tag==2
        {
            let viewController:EventsDashboardViewController=self.storyboard?.instantiateViewController(withIdentifier: "EventsDashboardViewController") as! EventsDashboardViewController
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        else if sender.tag==3
        {
            let viewController:RewardsViewController=self.storyboard?.instantiateViewController(withIdentifier: "RewardsViewController") as! RewardsViewController
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        else if sender.tag==4
        {
            let viewController:DealsDashboardViewController=self.storyboard?.instantiateViewController(withIdentifier: "DealsDashboardViewController") as! DealsDashboardViewController
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        else if sender.tag==5
        {
            let viewController:ProfileViewController=self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func sidePanelSelectedIndex(selectedIndex: Int) {
        if selectedIndex == 1 {
        }
        if selectedIndex == 2 {
            let viewController: DealsViewController=self.storyboard?.instantiateViewController(withIdentifier: "DealsViewController") as! DealsViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        if selectedIndex == 3 {
            let alertView = UIAlertController(title: "Logout", message: "Are you sure want to Logout", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
                let sc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
                
                let appDelegate = UIApplication.shared.delegate
                
                let window:UIWindow=((appDelegate?.window)!)!
                
                window.rootViewController=UINavigationController(rootViewController: sc!)
            }))
            alertView.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            
            self.present(alertView, animated: true, completion: nil)
        }
        print("index: \(selectedIndex)")
    }
    @IBAction func mapButtonClicked(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            let viewController: ChatViewController=self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
            break;
            
        case 2:
            self.addButtonClicked()
            
            break;
            
        default:
            let viewController: DealsViewController=self.storyboard?.instantiateViewController(withIdentifier: "DealsViewController") as! DealsViewController
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
            break;
        }
    }
    
    func addButtonClicked() {
        let alertController: UIAlertController = UIAlertController(title: "Select", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default, handler: { (alert) in
            self.setGallery()
        }))
        
        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert) in
            self.setTakeImage()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (alert) in
            
        }))
        
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func upperPanelContactButtonClicked(_ sender: Any) {
        
        let viewController:ContactsDashboardViewController=self.storyboard?.instantiateViewController(withIdentifier: "ContactsDashboardViewController") as! ContactsDashboardViewController
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setGallery()
    {
        let imagePicker=UIImagePickerController()
        imagePicker.allowsEditing=true
        imagePicker.sourceType=UIImagePickerController.SourceType.savedPhotosAlbum
        imagePicker.delegate = self
        self.navigationController?.present(imagePicker, animated: true, completion: nil)
    }
    func setTakeImage() {
        let imagePicker=UIImagePickerController()
        imagePicker.allowsEditing=true
        imagePicker.sourceType=UIImagePickerController.SourceType.camera
        imagePicker.delegate = self
        self.navigationController?.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        _=info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)]
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension UIView {
    func fadeIn(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    func fadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}
extension HomeViewController: BmoViewPagerDataSource, BmoViewPagerDelegate {
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
        view.marginX = 2.0
        view.lineWidth = 3.0
        view.strokeColor = UIColor.cyan
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
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ChatDashBoardViewController") as! ChatDashBoardViewController
            return viewController
        }
        if page == 1 {
            let viewController: AlertViewController=self.storyboard?.instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
            
            return viewController
        }
        
        if page==2
        {
            let viewController: OTPVerficationViewController=self.storyboard?.instantiateViewController(withIdentifier: "OTPVerficationViewController") as! OTPVerficationViewController
            
            return viewController
        }
            
        else
        {
            let viewController: DealsViewController=self.storyboard?.instantiateViewController(withIdentifier: "DealsViewController") as! DealsViewController
            
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

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
