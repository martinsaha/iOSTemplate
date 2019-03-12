//
//  ViewController.swift
//  Template
//
//  Created by Martin Prabhu on 11/03/19.
//  Copyright © 2019 TAG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if AppMethods.shared.isInternetAvailable(){
            //print("Internet Availble")
            DispatchQueue.main.async {
                self.displayAlert(title: "", message: StringConstant.internetError, options: "OK","Cancel", completion: { (option) in
                    switch(option) {
                    case 0:
                        print("OK")
                        break
                    case 1:
                        print("Cancel")
                        break
                    default:
                        break
                    }
                })
            }
        }else {
            print("Internet not Availble")
            DispatchQueue.main.async {
                self.displayAlert(title: "", message: StringConstant.internetSuccess, options: "OK", completion: { (option) in
                    switch(option) {
                    case 0:
                        print("option one")
                        break
                    default:
                        break
                    }
                })
            }

        }




//        let response = Validation.shared.validate(values: (ValidationType.email, "hello@gmail.com"), (ValidationType.phoneNo, "56545654654665"), (ValidationType.stringWithFirstLetterCaps, "tyh56gf"))
//        switch response {
//        case .success:
//            break
//        case .failure(_, let message):
//            print(message.localized())
//        }

    }

    @IBAction func buttonAction(_ sender: Any) {
         self.view.hideToastActivity()

        let resp = Validation.shared.validate(values: (ValidationType.email, "hello"))
        switch resp {
        case .success:
            break
        case .failure(_, let message):
            print(message.localized())
            break
        default:
            break
        }

//        displayAlert(title: "", message: "Hi This is global Alert message", options: "OK", "Cancel") { (option) in
//
//            switch(option) {
//            case 0:
//                print("option one")
//                break
//            case 1:
//                print("option two")
//            default:
//                break
//            }
//        }

        //self.view.makeToast("Internet Availble")

        // toast with a specific duration and position
        //           self.view.makeToast("Internet Availble", duration: 3.0, position: .top)
        //           self.view.makeToast("Internet Availble", duration: 3.0, position: .center)
        //           self.view.makeToast("Internet Availble", duration: 3.0, position: .bottom)

        // display any view as toast
        //  self.view.showToast(myView)

        // immediately hides all toast views in self.view
        // self.view.hideAllToasts()

    }

    @IBAction func startAction(_ sender: Any) {
        self.view.makeToastActivity(.bottom)

    self.view.isUserInteractionEnabled = false

        self.view.makeToast("Internet Availblet", duration: 2.0, point: CGPoint(x: 110.0, y: 110.0), title: "Toast Title", image: UIImage(named: "toast.png")) { didTap in
            if didTap {
                print("completion from tap")
                    self.view.isUserInteractionEnabled = true

            } else {
                print("completion without tap")
                    self.view.isUserInteractionEnabled = true
            }
        }

    }
}

