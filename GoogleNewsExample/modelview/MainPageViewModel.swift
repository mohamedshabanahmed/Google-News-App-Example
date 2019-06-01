//
//  MainPageViewModel.swift
//  GoogleNewsExample
//
//  Created by MAC on 5/31/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit

class MainPageViewModel: NSObject {

    var arr = Array<NewModel>()
    
    init(arr : Array<NewModel>) {
        self.arr = arr
    }
    
}
