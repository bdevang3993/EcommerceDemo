//
//  APIRequest.swift
//  FugitCustomer
//
//  Created by addis on 09/02/20.
//  Copyright © 2020 addis. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
class APIRequest: NSObject {
    static let shared = APIRequest()
    private override init() {
        
    }
    func getAPIRequest<T:Decodable>(serviceName: String, completionBlockSuccess aBlock: @escaping ((T) -> Void), andFailureBlock failBlock:@escaping ((AnyObject) -> Void)) {
        performGetRequest(serviceName: serviceName, success: aBlock, failure: failBlock)
    }
    
    func performGetRequest<T:Decodable>(serviceName: String,success successBlock: @escaping ((T) -> Void), failure failureBlock: @escaping ((AnyObject) -> Void)) {
        
        //        let strURL = serviceName
        //        let url = URL(string: strURL)
        let allURLData = serviceName.components(separatedBy: "/")
        let strLastURl:String = allURLData.last!
        print("Last Object=\(strLastURl)")
        let checkInterNet:Bool =  Connectivity.isConnectedToInternet()
       
//        var headers:HTTPHeaders?
//        print("Service Name = \(serviceName)")
//               let credentialData = "\(usernameapi):\(passwordapi)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
//
//               let base64Credentials = credentialData.base64EncodedString()
//                   headers = [
//                           "Authorization": "Basic \(base64Credentials)",
//                           "Accept": "application/json",
//                           "Content-Type": "application/json" ]
        
        if checkInterNet == true {
            
            Alamofire.request(serviceName, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (responsed) in
                switch responsed.result { //DataResponse<Any>
                   
                case .success(_):
                     print("Json Response= \(responsed)")
                    if responsed.response?.statusCode == 200 || responsed.response?.statusCode == 201 {
                        do {
                            
                            if let json = try JSONSerialization.jsonObject(with: responsed.data!, options: .allowFragments) as? [String: Any] { //[]
                                // try to read out a string array
                                print("Data = \(json)")
//                                let value:Int = json["error"] as! Int
//                                if  value != 0 {
//                                    let message = json["message"] as! String
//                                    failureBlock(message as AnyObject)
//                                    break
//                                }
                            }
                            
                            let obj = try JSONDecoder().decode(T.self , from: responsed.data!)
                            successBlock(obj)
                        }
                        catch {
                            failureBlock("API response not coming please try again" as AnyObject)
                        }
                    }
                    else if responsed.response?.statusCode == 203 {
                          failureBlock("Calls are limited to 1 per second, 60 per minute and 5000 per day" as AnyObject)
                    }
                    else
                    {
                        failureBlock("API response not coming please try again" as AnyObject)
                    }
                    break
                case .failure(let error):
                    debugPrint("getEvents error: \(error)")
                    
                    failureBlock(error.localizedDescription as AnyObject)
                    break
                @unknown default:
                    print("")
                }
            }
        }
        else {
             failureBlock("Please check your Internet Connection " as AnyObject)
        }
    }
    func callWebservice<T:Decodable>(serviceName: String,httpMethod:String,andParams params: [String:Any], completionBlockSuccess aBlock: @escaping ((T) -> Void), andFailureBlock failBlock:@escaping ((AnyObject) -> Void)) {
        
        performPostRequest(serviceName: serviceName,httpMethod:httpMethod,andParams: params, success: aBlock, failure: failBlock)
    }
    
    func performPostRequest<T:Decodable>(serviceName: String,httpMethod:String, andParams params: [String:Any], success successBlock: @escaping ((T) -> Void), failure failureBlock: @escaping ((AnyObject) -> Void)) {
        print("All ParaMeter = \(params)")
       
       if Connectivity.isConnectedToInternet() {
        Alamofire.request(serviceName, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (responsed) in
               switch responsed.result { //DataResponse<Any>
                   
               case .success(_):
                  
                   if responsed.response?.statusCode == 200 || responsed.response?.statusCode == 201 {
                       do {
                           
                           if let json = try JSONSerialization.jsonObject(with: responsed.data!, options:.allowFragments) as? [String: Any] { //[]
                               // try to read out a string array
                               print("Data = \(json)")
                            let result:Bool = (json["result"] != nil)
                             //  let value:Int = json["result"] as! Int
                               if  result == false {
                                   let message = json["msg"] as! String
                                   failureBlock(message as AnyObject)
                                   break
                               }
                           }
                           
                           let obj = try JSONDecoder().decode(T.self , from: responsed.data!)
                           successBlock(obj)
                       }
                       catch {
                           failureBlock("API response not coming please try again" as AnyObject)
                       }
                   }
                   else
                   {
                       failureBlock("API response not coming please try again" as AnyObject)
                   }
                   break
               case .failure(let error):
                   debugPrint("getEvents error: \(error)")
                   
                   failureBlock(error.localizedDescription as AnyObject)
                   break
               @unknown default:
                   print("")
               }
           }
       }
        else {
            failureBlock("Please check your Internet Connection " as AnyObject)
        }
    }
    
  
}
