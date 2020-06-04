//
//  SidePanelViewController.swift
//  LMS
//
//  Created by admin on 2/6/18.
//  Copyright © 2018 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit

class SidePanelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    public var sidePanelBgColor:UIColor?
    
    public var sidePanelArray:NSMutableArray=[]
    public var sidePanelImagesArray: NSMutableArray = []
    
    public var cellHeight: CGFloat?
    public var cellHeight1: CGFloat=44
    var isIocnLabel:Bool = false
    var isIconImageView = false
    var profileImage: String?
    var userName: String?
    
    let sidePanelTableView = UITableView()
    
    var delegate: SidePanelDelagate?
    
    var contentView: UIView?
    
    var baseView: UIViewController?
    var sidePanelWidth: CGFloat?
    
    let animationDuration = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let button = UIButton(frame: self.view.bounds)
        button.addTarget(self, action: #selector(closeButtonClicked(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        sidePanelTableView.register(UINib (nibName: "SidePanelTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        sidePanelTableView.register(UINib (nibName: "SidePanelTableViewCell1", bundle: nil), forCellReuseIdentifier: "Cell1")
    }

    override func viewDidAppear(_ animated: Bool) {
        self.animationSidePanel()
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

    func setContentViewFrame(width: CGFloat, sender: UIViewController) {
        baseView = sender
        sidePanelWidth=width
        
        contentView = UIView(frame: CGRect(x: 0, y: 0, width: width ?? 300, height: self.view.frame.size.height))
        
        contentView?.backgroundColor=sidePanelBgColor ?? UIColor.lightGray
        
        self.contentView?.frame.origin.x -= sidePanelWidth!
        
        self.view.addSubview(contentView!)
        
        let tableView = UITableView(frame: (contentView?.bounds)!, style: .plain)

        tableView.dataSource=self
        tableView.delegate=self

        tableView.separatorStyle = .none

        tableView.backgroundColor=UIColor.clear

        contentView?.addSubview(tableView)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(panGesture:)))
        contentView?.addGestureRecognizer(panGesture)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sidePanelArray.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SidePanelTableViewCell=sidePanelTableView.dequeueReusableCell(withIdentifier: "Cell") as! SidePanelTableViewCell
        
        //if sidePanelProfileArray.count > 0 {
            if indexPath.row==0{
            let cell1: SidePanelTableViewCell=sidePanelTableView.dequeueReusableCell(withIdentifier: "Cell1") as! SidePanelTableViewCell
                
                cell.iconImageView.image=UIImage(named: profileImage ?? "")
                cell.nameLabel.text=userName ?? ""
                
                return cell1
            }
        //}
        
        cell.nameLabel.text=sidePanelArray[indexPath.row-1] as? String
        
        if sidePanelImagesArray.count>1 {
            if isIocnLabel==true{
                cell.iconImageLabel.font=UIFont(name: "fontawesome", size: 20)
                cell.iconImageLabel.tintColor=UIColor.lightGray
                cell.iconImageLabel.text=sidePanelImagesArray[indexPath.row-1] as? String
            }
            
            else
            {
            cell.iconImageView.image=UIImage(named: sidePanelImagesArray[indexPath.row-1] as? String ?? "")
            }
        }
        
        else
        {
            cell.nameLabel.frame=CGRect(x: cell.iconImageView.frame.origin.x, y: cell.nameLabel.frame.origin.y, width: cell.nameLabel.frame.size.width, height: cell.nameLabel.frame.size.height)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let button: UIButton=UIButton(type: .system)
        
        self.closeButtonClicked(sender: button)
        
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false) { (timer) in
            timer.invalidate()
            
            self.delegate?.sidePanelSelectedIndex(selectedIndex: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row==0 {
                return cellHeight1
        }
        
        else
        {
            return cellHeight ?? 40
        }
    }
    
    @objc func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        // get translation
        let translation = panGesture.translation(in: contentView)
        panGesture.setTranslation(CGPoint.zero, in: contentView)
        //print(translation)
        
        let vel = panGesture.velocity(in: contentView)
        
        if (vel.x > 0)
        {
            let x: CGFloat = 0
            
            if (contentView?.frame.origin.x)! >= x{
                
            }
                
            else
            {
            // user dragged towards the right
            // create a new Label and give it the parameters of the old one
            let label = panGesture.view
            label?.center = CGPoint(x: (label?.center.x)!+translation.x, y: (contentView?.center.y)!)
                
                let label1 = baseView?.view
                label1?.center = CGPoint(x: (label1?.center.x)!+translation.x, y: (baseView?.view.center.y)!)
            }
        }
        else
        {
            // user dragged towards the left
            let label = panGesture.view
            label?.center = CGPoint(x: (label?.center.x)!+translation.x, y: (contentView?.center.y)!)
            
            let label1 = baseView?.view
            label1?.center = CGPoint(x: (label1?.center.x)!+translation.x, y: (baseView?.view.center.y)!)
        }
        
        if panGesture.state == UIGestureRecognizer.State.began {
            // add something you want to happen when the Label Panning has started
        }
        
        if panGesture.state == UIGestureRecognizer.State.ended {
            // add something you want to happen when the Label Panning has ended
            let translation = panGesture.translation(in: contentView)
            panGesture.setTranslation(CGPoint.zero, in: contentView)
            //print(translation)
            
            let vel = panGesture.velocity(in: contentView)
            
            if (vel.x > 0)
            {
                let x: CGFloat = 0
                
                if (contentView?.frame.origin.x)! >= x{
                    //side panel open
                    self.animationSidePanel()
                }
                    
                else
                {
                    //side panel close
                    let button: UIButton=UIButton(type: .system)
                    
                    self.closeButtonClicked(sender: button)
                    
//                    UIView.animate(withDuration: 0.5) {
//                        self.baseView?.view.layer.frame.origin.x = 0
//
//                        self.contentView?.frame.origin.x -= self.sidePanelWidth!
//                    }
                }
            }
            else
            {
                let contentViewSize: Int = Int((contentView?.frame.size.width)!)/2
                let x: Int = abs(Int((contentView?.frame.origin.x)!))
                
                if contentViewSize < x{
                    //side panel close
                    let button: UIButton=UIButton(type: .system)
                    
                    self.closeButtonClicked(sender: button)
                    
//                    UIView.animate(withDuration: 0.5) {
//                        self.baseView?.view.layer.frame.origin.x = 0
//
//                        self.contentView?.frame.origin.x -= self.sidePanelWidth!
//                    }
                }
                    
                else{
                    //side panel open
                    self.animationSidePanel()
                }
            }
        }
        
        if panGesture.state == UIGestureRecognizer.State.changed {
            // add something you want to happen when the Label Panning has been change ( during the moving/panning )
        } else {
            // or something when its not moving
        }
    }
    
    @objc func closeButtonClicked(sender: UIButton) {
        UIView.animate(withDuration: animationDuration) {
            self.baseView?.view.layer.frame.origin.x = 0
        }
        
        UIView.animate(withDuration: animationDuration+0.1) {
            self.contentView?.frame.origin.x = -self.sidePanelWidth!
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false) { (timer) in
            timer.invalidate()
            
            self.dismiss(animated: false, completion: nil)
        }
        
//        UIView.animate(withDuration: 2) {
//            self.contentView?.frame.origin.x -= self.sidePanelWidth!
//
//            //            self.contentView?.isHidden=true
//            //
//            //            self.contentView?.removeFromSuperview()
//
//            //self.dismiss(animated: false, completion: nil)
//        }
    }
    
    func animationSidePanel() {
        UIView.animate(withDuration: animationDuration+0.1) {
            self.baseView?.view.layer.frame.origin.x = self.sidePanelWidth!
        }
        
        UIView.animate(withDuration: animationDuration) {
            self.contentView?.frame.origin.x = 0
        }
    }
}

protocol SidePanelDelagate{
    func sidePanelSelectedIndex(selectedIndex: Int)
}
