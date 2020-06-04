//
//  ContactsDashboardViewController.swift
//  LMS
//
//  Created by admin on 11/2/17.
//  Copyright © 2017 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit

//import CDRTranslucentSideBar.h

class ContactsDashboardViewController: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tabBgView: UIView!
    //@IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var contentView: BmoViewPager!
    @IBOutlet weak var swipeMenu: SegmentedView!
    @IBOutlet weak var pagerNavView: BmoViewPagerNavigationBar!
    
    var personalUserId: String?
    
    var swipeMenuArray: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBarButton()
        self.navigationController?.navigationBar.isHidden=true
        
        self.setMenu()
        gettaggedUser()
        //filtertaggedUser()
        
        //callPostApi()
    }
    
    func navigationBarButton() {
        menuButton.titleLabel?.font=UIFont(name: "fontawesome", size: 25)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setMenu()
    {
        swipeMenuArray=["Personal", "Business", "Group"]
        
        contentView.dataSource = self
        contentView.delegate = self as? BmoViewPagerDelegate
//        swipeMenu.autoFocus = false
//        swipeMenu.viewPager = contentView
        pagerNavView.viewPager=contentView
        contentView.infinitScroll=true
        pagerNavView.autoFocus=false
        
//        contentView.layer.borderWidth = 1.0
//        contentView.layer.cornerRadius = 5.0
//        contentView.layer.masksToBounds = true
//        contentView.layer.borderColor = UIColor.white.cgColor
    }
    
    
//    func filtertaggedUser(){
//
//        print("register tapped")
//        let parameters: [String: Any] = ["contactsList": ["8908908900", "6179987671", "5082508888"]]
//        //let parameters = ["8908908900", "6179987671", "5082508888"] as? [String]
//        let headers = ["deviceid": "584D97F-761A-4C24-8C4B-C145A8B8BD75", "userType": "personal", "key": "9609cc826b0d472faf9967370c095c21"]
//
//        let url = URL(string: "http://itaag-env-1.ap-south-1.elasticbeanstalk.com/filter/taggedusers/")
//        var req =  URLRequest(url: url!)
//        req.httpMethod = "POST"
//
//        req.allHTTPHeaderFields = headers as? [String : String]
//
//        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed) else {return}
//        req.httpBody = httpBody
//        let session = URLSession.shared
//        session.dataTask(with: req, completionHandler: {(data, response, error) in
//            if response != nil {
//                 print(response)
//            }
//            if let data = data {
//                do{
//                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
//                    print("filter json \(json)")
//
//
//                }catch{
//                    print("error")
//                }
//            }
//        }).resume()
//    }
    
    
//    func filtertaggedUser() {
//        print("filter taggedusers outtt")
//
//        let headers = ["deviceid": "584D97F-761A-4C24-8C4B-C145A8B8BD75", "userType": "personal", "key": "9609cc826b0d472faf9967370c095c21"]
//        let urlStr  = "http://itaag-env-1.ap-south-1.elasticbeanstalk.com/filter/taggedusers/?contactsList=" + "8908908900"
//        let request = NSMutableURLRequest(url: NSURL(string:urlStr)! as URL,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
//        request.httpMethod          = "POST"
//        request.allHTTPHeaderFields = headers
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//                let httpResponse = response as? HTTPURLResponse
//                if httpResponse!.statusCode == 200 {
//                    print("filter taggedusers outtt22222")
//
//                    do {
//                        print("filter taggedusers outtt22222ddddd")
//
//                        let jsonObject  = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! [String :AnyObject]
//                        print("filter taggedusers \(jsonObject)")
//
//                    } catch { print(error.localizedDescription) }
//                } else { Constants.showAlertView(alertViewTitle: "", Message: "Something went wrong, Please try again", on: self) }
//
//        })
//        dataTask.resume()
//    }
    
    
//    func getPostString(params:[String:Any]) -> String
//    {
//        var data = [String]()
//        for(key, value) in params
//        {
//            data.append(key + "=\(value)")
//        }
//        print(data.map { String($0) }.joined(separator: "&"))
//        return data.map { String($0) }.joined(separator: "&")
//    }

//    func callPostApi(){
//
//        let url = URL(string: "http://itaag-env-1.ap-south-1.elasticbeanstalk.com/filter/taggedusers/")
//        guard let requestUrl = url else { fatalError() }
//        var request = URLRequest(url: requestUrl)
//        request.httpMethod = "POST"
//
//        request.setValue("EC3746E9-4DB4-42C7-9D8C-1542B18C2AC", forHTTPHeaderField: "deviceid")
//        request.setValue("5fe42fb3b54543a0bab5667cf96526f8", forHTTPHeaderField: "key")
//        request.setValue("personal", forHTTPHeaderField: "userType")
//
//        let contactNumbers = UserDefaults.standard.string(forKey: "ContactNumber")
//
//        print("contacts in dashBoard \(contactNumbers)")
//
//        let parameters = getPostString(params:   ["contactsList":["8908908900", "9876543210"]])
//        request.httpBody = parameters.data(using: .utf8)
//        // Perform HTTP Request
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse!.statusCode)
//                // Check for Error
//                if let error = error {
//                    print("Error took place \(error)")
//                    return
//                }
//                // Convert HTTP Response Data to a String
//                if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                    print("Response data string:\n \(dataString)")
//
//                   do {
//                       let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
//                        print("fetching json \(json)")
//                       let fetchStatus = json["userName"] as? String
//                       print("fetching json userName \(String(describing: fetchStatus))")
//
//                    let user = json["9876543210"] as? [String: Any]
//                    let name = user?["userName"] as? String
//
//                    print("firstusername \(name)")
//
//                   }
//                   catch{
//
//                    }
//
//                }
//        }
//        task.resume()
//    }
    
    
    func gettaggedUser(){
            print("in contacts service")
        
    
    //    http://itaag-env-1.ap-south-1.elasticbeanstalk.com/get/taggedusers/
            let URL_HEROES = Constants.GLOBAL_URL + "/get/taggedusers/"
            let url = NSURL(string: URL_HEROES)
            let deviceId: String = (UIDevice.current.identifierForVendor?.uuidString)!
        
            personalUserId = UserDefaults.standard.string(forKey: "USERID")
        print("contacts tagged user personalid \(personalUserId)")
            let headers = ["deviceid": deviceId, "userType": "personal", "key": personalUserId]
            let request = NSMutableURLRequest(url:url! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers as? [String : String]
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in
                if error == nil {
                    let httpResponse = response as? HTTPURLResponse
                    if httpResponse!.statusCode == 200 {
                        do {
                            let jsonObject  = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String :AnyObject]]
                            print("the json of gettaggeduser\(jsonObject)")
                            
                        }
                        catch  {
                            print(error.localizedDescription)
                        }
                    }
                    else {
                        self.showAlert(title: "", message: "Please enter vaild details")
                    }
                }
            })
            dataTask.resume()
        }
    
}

extension ContactsDashboardViewController: BmoViewPagerDataSource, BmoViewPagerDelegate {
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
        if page==0
        {
            let viewController: ContactsViewController=self.storyboard?.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
            
            return viewController
        }
        
        if page==1
        {
            let viewController: ContactsViewController=self.storyboard?.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
            
            return viewController
        }
        
        if page==2
            
            
        {
            let viewController: CreateGroupViewController=self.storyboard?.instantiateViewController(withIdentifier: "CreateGroupViewController") as! CreateGroupViewController
            
            return viewController
        }
        
        else
        {
//            let viewController: SavedAddressViewController=self.storyboard?.instantiateViewController(withIdentifier: "SavedAddressViewController") as! SavedAddressViewController
//
//            return viewController
            
            
            let viewController: ContactsViewController=self.storyboard?.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
            
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
