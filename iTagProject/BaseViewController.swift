//
//  BaseViewController.swift
//  iTag
//
//  Created by Corpus_Mac on 15/10/19.
//  Copyright © 2019 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit
private var kAssociationKeyMaxLength: Int = 0
@IBDesignable extension UIView {
    
    @IBInspectable var vborderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var vcornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    @IBInspectable var vborderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    func showAlert(title:String, message:String) {
        var style = UIAlertController.Style.actionSheet
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            style = UIAlertController.Style.alert }
        let alert = UIAlertController(title:title, message:message , preferredStyle: style)
        DispatchQueue.main.async {
            self.present(alert, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
}
extension String {
    
    private func filterCharacters(unicodeScalarsFilter closure: (UnicodeScalar) -> Bool) -> String {
        return String(String.UnicodeScalarView(unicodeScalars.filter { closure($0) }))
    }
    
    private func filterCharacters(definedIn charSets: [CharacterSet], unicodeScalarsFilter: (CharacterSet, UnicodeScalar) -> Bool) -> String {
        if charSets.isEmpty { return self }
        let charSet = charSets.reduce(CharacterSet()) { return $0.union($1) }
        return filterCharacters { unicodeScalarsFilter(charSet, $0) }
    }
    
    func removeCharacters(charSets: [CharacterSet]) -> String { return filterCharacters(definedIn: charSets) { !$0.contains($1) } }
    func removeCharacters(charSet: CharacterSet) -> String { return removeCharacters(charSets: [charSet]) }
    
    func onlyCharacters(charSets: [CharacterSet]) -> String { return filterCharacters(definedIn: charSets) { $0.contains($1) } }
    func onlyCharacters(charSet: CharacterSet) -> String { return onlyCharacters(charSets: [charSet]) }
}
