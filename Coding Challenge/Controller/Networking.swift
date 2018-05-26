//
//  Networking.swift
//  Coding Challenge
//
//  Created by Carl Brenneisen on 3/15/18.
//  Copyright © 2018 Carl Brenneisen. All rights reserved.
//

import Foundation

class Networking{
    static let shared:Networking = Networking()
    
    func GetISSPassTimes(LAT:Double, LON:Double, completion:@escaping(ISSPassTime?)->()){
        let url = URL(string: "http://api.open-notify.org/iss-pass.json?lat=\(LAT)&lon=\(LON)")
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            let timeObj = try? JSONDecoder().decode(ISSPassTime.self, from: data)
            completion(timeObj)
            //self.issPassTime = timeObj
            //print(self.issPassTime?.message ?? "Failed to Decode")
        }).resume()
    }
}
