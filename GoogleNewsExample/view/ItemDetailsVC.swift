//
//  ItemDetailsVC.swift
//  GoogleNewsExample
//
//  Created by MAC on 5/22/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit
import Nuke
class ItemDetailsVC: UIViewController {

    var itemViewModel : ItemDtailsViewModel!
    
    var NewItem : NewModel?
    @IBOutlet weak var DescriptionOfNew: UITextView!
    @IBOutlet weak var TitleOfNew: UILabel!
    @IBOutlet weak var ImageOfNew: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        itemViewModel = ItemDtailsViewModel(newModel: NewItem!)
        
        LoadPage(itemViewModel: itemViewModel)
    }
    
    func LoadPage(itemViewModel : ItemDtailsViewModel) {
        TitleOfNew.text = itemViewModel.title
        DescriptionOfNew.text = itemViewModel.descriptiontext
        var urlImage : String = itemViewModel.urlToImage ?? ""
//        loadImage(url : itemViewModel?.urlToImage ?? "")
        
        let url = URL(string: urlImage)
        
        let options = ImageLoadingOptions(
            placeholder: UIImage(named: "dark-moon"),
            transition: .fadeIn(duration: 0.5)
        )
        
        Nuke.loadImage(
            with: url!  ,
            into: ImageOfNew
        )
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func BackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
