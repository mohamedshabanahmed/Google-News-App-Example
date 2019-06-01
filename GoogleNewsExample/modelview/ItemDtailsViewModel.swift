//
//  ItemDtailsViewModel.swift
//  GoogleNewsExample
//
//  Created by MAC on 5/31/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit

class ItemDtailsViewModel: NSObject {
    
    var author : String?
    var title : String?
    var descriptiontext : String?
    var url : String?
    var urlToImage : String?
    var  publishedAt : String?
    var content : String?
    
    init(newModel : NewModel) {
        
        self.author = newModel.author
        self.title = newModel.title
        self.descriptiontext = newModel.descriptiontext
        self.url = newModel.url
        self.urlToImage = newModel.urlToImage
        self.publishedAt = newModel.publishedAt
        self.content = newModel.content
        
    }

}
