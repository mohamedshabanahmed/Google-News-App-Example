//
//  Connectivity.swift
//  GoogleNewsExample
//
//  Created by MAC on 6/5/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import Foundation
import Alamofire
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
