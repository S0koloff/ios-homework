//
//  DateConfig.swift
//  Navigation
//
//  Created by Sokolov on 30.12.2022.
//

import UIKit

struct DateConfig {
    
    static func dateConfig(completion: @escaping(_ title: String) -> Void)  {
         
        let session = URLSession(configuration: .default)
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/27")
        
        let task = session.dataTask(with: url!) { data, responce, error in
            
            if let error {
                print(error.localizedDescription)
                return
            }
            
            let statusCode = (responce as! HTTPURLResponse).statusCode
                if statusCode != 200 {
                    print("Error of statusCode: ", statusCode)
                    return
                }
            
            guard let data else {
                print("Error of data")
                return
            }
            
            do {
                if let answer = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                    let title = answer["title"] {
                    completion(title as! String)
                }
            } catch {
                print("Error to take Data: ", error.localizedDescription)
            }
        }
        
        task.resume()

    }
}
