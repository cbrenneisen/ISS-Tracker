//
//  ISSRequest.swift
//  Coding Challenge
//
//  Created by Carlos Brenneisen on 3/16/18.
//  Copyright © 2018 Carl Brenneisen. All rights reserved.
//

import Foundation

struct ISSRequest: Codable{
    var longitude:Double
    var latitude:Double
    var altitude:Double
    var passes:Int
    var datetime:Int
}

