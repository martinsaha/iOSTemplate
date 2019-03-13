//
//  AppMethods.swift
//  Template
//
//  Created by Martin Prabhu on 11/03/19.
//  Copyright © 2019 TAG. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit

class AppMethods: NSObject {

    public static let shared = AppMethods()

    func isInternetAvailable() -> Bool{
        var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)

    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
        }
            let isReachable = flags.contains(.reachable)
            let needsConnection = flags.contains(.connectionRequired)
            return (isReachable && !needsConnection)
    }
}

extension UIViewController {
    func displayAlert(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }

    func startActivity(){
        self.view.makeToastActivity(.center)
        self.view.isUserInteractionEnabled = false
    }

    func stopActivity(){
        self.view.hideToastActivity()
        self.view.isUserInteractionEnabled = true
    }
}
