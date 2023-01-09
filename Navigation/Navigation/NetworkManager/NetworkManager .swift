//
//  NetworkManager .swift
//  Navigation
//
//  Created by Sokolov on 28.12.2022.
//

import UIKit

struct NetworkManager {
    
    static func request(for configuration: AppConfiguration) {
        
        let session = URLSession(configuration: .default)
        
        let url = URL(string: configuration.rawValue)
        
        let task = session.dataTask(with: url!) { data, responce, error in
            
            if let error{
                print(error.localizedDescription)
                return
            }
            
            let statusCode = (responce as! HTTPURLResponse).statusCode
            if statusCode != 200 {
                print("status code = \(statusCode)")
                return
            }
            
            if (responce as! HTTPURLResponse).allHeaderFields is [String: Any] {
                print("allHeaderFields work")
            }
            
            guard let data else {
                print("No data")
                return
            }
            
            do {
                if let answer = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let name = answer["name"],
                   let url = answer["url"] {
                    print("Name of object: ", name)
                    print("Url: ",url)
                }
            } catch {
                print("Error to take Data: ", error.localizedDescription)
            }
            
        }
        
        task.resume()
        
    }
    
    
}
