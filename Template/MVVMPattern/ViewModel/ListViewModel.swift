//
//  ListViewModel.swift
//  Template
//
//  Created by Martin Prabhu on 13/03/19.
//  Copyright © 2019 TAG. All rights reserved.
//

import UIKit
class ListViewModel {

    var reloadlist = {() -> () in }
    var errorMessage = {(message : String) -> () in }

    var arrayOfList : [List] = []{
        didSet{
            reloadlist()
        }
    }

    func getAPI( methodName: String) {
        guard let listURL = URL(string: APIManager.baseURL + methodName) else {
            print("Invalid list URL")
            return
        }

        URLSession.shared.dataTask(with: listURL) {
            (data,reponse,error) in
            guard let jsonData = data else { return }

            do {
                let decoder = JSONDecoder()
                self.arrayOfList = try decoder.decode([List].self, from: jsonData)
            } catch let error {
                print("Error ->\(error.localizedDescription)")
                self.errorMessage(error.localizedDescription)
            }
            }.resume()
    }
}
