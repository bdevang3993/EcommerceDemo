//
//  Constant.swift
//  FugitCustomer
//
//  Created by addis on 09/02/20.
//  Copyright © 2020 addis. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import JGProgressHUD

let hud = JGProgressHUD(style: .dark)
//MARK:- Screen Resolution
let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
let kAppName = "EcommerceDemo"
let MainStoryBoard = "Main"
let ksuccess = "success"
var historySelectedDate = Date()
var deviceID:String = UIDevice.current.identifierForVendor!.uuidString
//MARK:- TypeDefine Declaration
typealias TAAPISuccess = (String) -> Void
typealias TAAPIFailed = (String) -> Void

//MARK:- Constant API URL
let baseURL = "https://stark-spire-93433.herokuapp.com/json"


//MARK:- Set ProgressHUD
func setProgressHub(view:UIView) {
    hud.show(in:view)
}
func removeProgressHub() {
    hud.dismiss()
}


//MARK:- Constant Struct
struct AppMessage {
    var internetIssue:String = "Please check the internet connection"
}
struct CustomFontName {
    var labelFontName:String = "helvetica-neue-regular"
}
struct CustomFontSize {
    var buttonFontSize:CGFloat = 15.0 * (screenWidth/320.0)
}
struct CustomColor {
    //HeaderColor
    var mainBackground = "#8BD1C9"//"#377F7F"//"#4FB2B4"//"#70CDCD"
}
struct AppAlertMessage {
    var oldPassword = "Please provide old password"
}
struct Alert {
    func showAlert(message:String,viewController:UIViewController) {
        let alert = UIAlertController(title:kAppName, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

enum UIUserInterfaceIdiom : Int {
    case unspecified

    case phone // iPhone and iPod touch style UI
    case pad   // iPad style UI (also includes macOS Catalyst)
}

