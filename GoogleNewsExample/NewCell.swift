//
//  NewCell.swift
//  GoogleNewsExample
//
//  Created by MAC on 5/22/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit
import Alamofire

class NewCell: UITableViewCell {

    @IBOutlet weak var ImageOfNew: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadImage(url : String) {

        DispatchQueue.global().async {
            do{
                let Appurl = URL(string: url)!
                let data = try Data(contentsOf: Appurl)

                DispatchQueue.global().sync {
                    // change view
                    self.ImageOfNew.image = UIImage(data: data)
                }
            }
            catch{
                print("error")
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
