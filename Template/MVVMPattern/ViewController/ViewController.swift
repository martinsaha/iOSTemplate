//
//  ViewController.swift
//  Template
//
//  Created by Martin Prabhu on 11/03/19.
//  Copyright © 2019 TAG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
     var viewModel = ListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func closureSetup() {
        viewModel.reloadlist =  { [weak self] () in
            DispatchQueue.main.async {
                self?.listTableView.reloadData()
                self?.view.isUserInteractionEnabled = false
                self?.stopActivity()
            }
        }
        viewModel.errorMessage = { [weak self] (message) in
            DispatchQueue.main.async {
                self?.displayAlert(title: "", message: message, options: StringConstant.okString, completion: { (option) in
                    switch(option) {
                    case 0:
                        break
                    default:
                        break
                    }
                })
            }
        }
    }

    @IBAction func startAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.displayAlert(title: "", message: "Do you want to load from API", options: StringConstant.okString, StringConstant.cancelString, completion: { (option) in
                switch(option) {
                case 0:
                    self.loadListAPI()
                    break
                case 1:
                    break
                default:
                    break
                }
            })
        }
    }

    @IBAction func buttonAction(_ sender: Any) {
        self.view.hideToastActivity()
         if viewModel.arrayOfList.count != 0 {
            DispatchQueue.main.async {
                self.displayAlert(title: "", message: "This action will remove all the objects in list view", options: StringConstant.okString, StringConstant.cancelString , completion: { (option) in
                    switch(option) {
                    case 0:
                        self.removeAllfromlist()
                        break
                    case 1:
                        break
                    default:
                        break
                    }
                })
            }
         }else {
            self.view.makeToast(AlertConstants.noData, duration: 3.0, position: .center)
        }
    }
    fileprivate func loadListAPI() {
        if viewModel.arrayOfList.count == 0{
            if AppMethods.shared.isInternetAvailable(){
                startActivity()
                closureSetup()
                viewModel.getAPI(methodName: "posts/")
            }else {
                stopActivity()
                self.view.makeToast(ErrorConstants.internetError)
            }
        } else {
            self.view.makeToast("Data already displayed")
        }
    }

    func removeAllfromlist(){
            viewModel.arrayOfList.removeAll()
            listTableView.reloadData()
            self.view.makeToast("Removed all the data")
            self.view.makeToast(AlertConstants.noData, duration: 3.0, position: .center)
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.arrayOfList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        let listObj = viewModel.arrayOfList[indexPath.row]
        cell.lblResp1.text = listObj.title
        cell.lblResp4.text = listObj.body
        if ((indexPath.row % 2) != 0){
            cell.contentView.backgroundColor = UIColor.lightGray
        }else{
            cell.contentView.backgroundColor = UIColor.clear
        }
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
//        self.view.makeToastActivity(.bottom)


//        self.view.makeToast("Internet Availblet", duration: 2.0, point: CGPoint(x: 110.0, y: 110.0), title: "Toast Title", image: UIImage(named: "toast.png")) { didTap in
//            if didTap {
//                print("completion from tap")
//                    self.view.isUserInteractionEnabled = true
//
//            } else {
//                print("completion without tap")
//                    self.view.isUserInteractionEnabled = true
//            }
//        }


//let resp = Validation.shared.validate(values: (ValidationType.email, "hello"))
//switch resp {
//case .success:
//    break
//case .failure(_, let message):
//    print(message.localized())
//    break
//default:
//    break
//}


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


//        let response = Validation.shared.validate(values: (ValidationType.email, "hello@gmail.com"), (ValidationType.phoneNo, "56545654654665"), (ValidationType.stringWithFirstLetterCaps, "tyh56gf"))
//        switch response {
//        case .success:
//            break
//        case .failure(_, let message):
//            print(message.localized())
//        }



//print("Internet Availble")
//            DispatchQueue.main.async {
//                self.displayAlert(title: "", message: StringConstant.internetError, options: "OK","Cancel", completion: { (option) in
//                    switch(option) {
//                    case 0:
//                        print("OK")
//                        break
//                    case 1:
//                        print("Cancel")
//                        break
//                    default:
//                        break
//                    }
//                })
//            }
