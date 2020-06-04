//
//  EditProfileViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 02/06/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var userModel : ProfileModel?

    @IBOutlet weak var picBtn: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    var picker = UIImagePickerController()

    @IBOutlet weak var lastnameTextfield: UITextField!
    @IBOutlet weak var profileImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
               picker.allowsEditing = true
        nameTextField.text = userModel?.firstName
        
        lastnameTextfield.text = userModel?.lastName
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func profileButton(_ sender: Any) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        //actionSheetController.popoverPresentationController?.sourceView = self.contentView
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelAction)
        let takePictureAction: UIAlertAction = UIAlertAction(title: "TakePhoto", style: .default) { action -> Void in
            self.openCameraPicker()
        }
        actionSheetController.addAction(takePictureAction)
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "ChooseFromLibrary", style: .default) { action -> Void in
            self.openPhotoGallery()
        }
        actionSheetController.addAction(choosePictureAction)
        //Present the
        self.present(actionSheetController, animated: true, completion: nil)
    }
       
           func openCameraPicker() {
             picker.sourceType = UIImagePickerController.SourceType.camera
             picker.cameraCaptureMode = .photo
             picker.allowsEditing = true
             picker.modalPresentationStyle = .fullScreen
             present(picker,animated: true,completion: nil)
         }
         func openPhotoGallery() {
             picker.sourceType = .photoLibrary
             picker.allowsEditing = true

             picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
             present(picker, animated: true, completion: nil)
         }
         // MARK: - UIImagePickerControllerDelegate Methods
         func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
             if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
                 profileImg.image = img
             }
             else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                 self.profileImg.image = image
             }
             dismiss(animated: true, completion: nil)
         }
    
    
    @IBAction func saveBtn(_ sender: Any) {

//        if self.profileImg.image == nil{
//
//            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
//            self.navigationController?.pushViewController(viewController, animated: true)
//
//
//        }
//        else{
//            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
//viewController.profileImg.image = self.profileImg.image
//            self.navigationController?.pushViewController(viewController, animated: true)
//        }
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        viewController.newImage = self.profileImg.image
        viewController.editFirstName = nameTextField.text
        viewController.editLastName = lastnameTextfield.text
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
