//
//  ISSPassTime.swift
//  Coding Challenge
//
//  Created by Carlos Brenneisen on 3/16/18.
//  Copyright © 2018 Carl Brenneisen. All rights reserved.
//

import Foundation

struct ISSPassTime: Codable{
    var message:String
    var request:ISSRequest
    var response:[ISSResponse]
}
