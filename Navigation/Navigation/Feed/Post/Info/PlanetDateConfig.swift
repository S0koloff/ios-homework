//
//  PlanetDateConfig.swift
//  Navigation
//
//  Created by Sokolov on 03.01.2023.
//

import UIKit

struct Planet: Decodable {
    var name: String
    var rotation_period: String
    var orbital_period: String
    var diameter: String
    var climate: String
    var gravity: String
    var terrain: String
    var surface_water: String
    var population: String
    var residents: [String]
}

struct PeoplesOnPlanet: Decodable {
    var name: String
}

struct Answer: Decodable {
    var resoult: [Planet]
}

var infoVC: InfoViewController?

var array = infoVC?.arrayOfPeoples

func planetDateConfig (completion: ((_ planet: Planet?, _ errorText: String?) -> Void)?) {
    
    let session = URLSession(configuration: .default)
    
    let url = URL(string: "https://swapi.dev/api/planets/1")
    
    let task = session.dataTask(with: url!) { data, response, error in
        
        if let error {
            print(error)
            return
        }
        
        let statusCode = (response as? HTTPURLResponse)?.statusCode
        if statusCode != 200 {
            print("Error of statusCode", statusCode as Any)
            completion?(nil, "Error of statusCode: \(String(describing: statusCode))")
            
            return
        }
        
        guard let data else {
            print("Error of data")
            completion?(nil, "Error of data")
            
            return
        }
        
        do {
            let planet  = try JSONDecoder().decode(Planet.self, from: data)
            completion?(planet, nil)
        } catch {
            print(error)
            completion?(nil, error.localizedDescription)
        }
    }
    
    task.resume()
    
}

//func peopleDateConfig(completion: ((_ name: String?, _ textError: String?) -> Void)?) {
//
//    let session = URLSession(configuration: .default)
//    
//    let array = infoVC?.arrayOfPeoples
//
//    let url = URL(string: (array.map)?)
//}
