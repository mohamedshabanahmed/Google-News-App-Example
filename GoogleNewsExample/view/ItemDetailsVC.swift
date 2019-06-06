//
//  ItemDetailsVC.swift
//  GoogleNewsExample
//
//  Created by MAC on 5/22/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit
import Nuke
import CoreData
class ItemDetailsVC: UIViewController {
    var itemViewModel : ItemDtailsViewModel!
    var NewItem : NewModel?
    @IBOutlet weak var DescriptionOfNew: UITextView!
    @IBOutlet weak var TitleOfNew: UILabel!
    @IBOutlet weak var ImageOfNew: UIImageView!
    @IBOutlet weak var faveImage: UIImageView!
     var ListOFTable = [FavoritesNews]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        itemViewModel = ItemDtailsViewModel(newModel: NewItem!)
        
        LoadPage(itemViewModel: itemViewModel)
        
        CheckIfExistsAtFirst(new_model : NewItem!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ItemDetailsVC.tappedMe))
        faveImage.addGestureRecognizer(tap)
        faveImage.isUserInteractionEnabled = true
    }
    
    @objc func tappedMe()
    {
        if faveImage.image == UIImage(named: "unlike") {
            var newImage: UIImage = UIImage(named: "like")!
            faveImage.image = newImage
            addToFav(new_model : NewItem!)
        }else{
            var newImage: UIImage = UIImage(named: "unlike")!
            faveImage.image = newImage
             removeFromFav(new_model : NewItem!)
        }
    }
    
    func LoadPage(itemViewModel : ItemDtailsViewModel) {
        TitleOfNew.text = itemViewModel.title
        DescriptionOfNew.text = itemViewModel.descriptiontext
        var urlImage : String = itemViewModel.urlToImage ?? ""
//        loadImage(url : itemViewModel?.urlToImage ?? "")
        
        let url = URL(string: urlImage)
        
        let options = ImageLoadingOptions(
            placeholder: UIImage(named: "splash"),
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
    
    func addToFav( new_model : NewModel)  {
        let FavNew = FavoritesNews(context : context )
        FavNew.author = new_model.author as NSObject? as? String
        FavNew.content = new_model.content as NSObject? as? String
        FavNew.descriptiontext = new_model.descriptiontext as NSObject? as? String
        FavNew.publishedAt = new_model.publishedAt as NSObject? as? String
        FavNew.title = new_model.title as NSObject? as? String
        FavNew.url = new_model.url as NSObject? as? String
        FavNew.urlToImage = new_model.urlToImage as NSObject? as? String
        do{
            ad.saveContext()
            print("saved")
        }catch{
            print("error")
        }
    }
    
    func removeFromFav(new_model : NewModel) {
        let fetchRequest : NSFetchRequest<FavoritesNews> = FavoritesNews.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title = %@",(new_model.title as NSObject? as? String)! )
        do {
            var results = try context.fetch(fetchRequest)
            if results.count == NSNotFound {
                // error
                
            }
            else if results.count == 0  {
                // not exists
                
            } else {
                // exists
                for data in results as! [NSManagedObject]
                {
                    context.delete(data)
                }
                try context.save()
            }
        }
        catch let error {
            print(error.localizedDescription)
        }
    }

    @IBAction func CountFav(_ sender: Any) {
         let FavNew = FavoritesNews(context : context )
        let fetchRequest : NSFetchRequest<FavoritesNews> =
            FavoritesNews.fetchRequest()
        do{
            self.ListOFTable = try! context.fetch(fetchRequest)
            print(ListOFTable.count)
        }catch{
            
        }
    }
    
    
    func CheckIfExistsAtFirst(new_model : NewModel)  {
        let fetchRequest : NSFetchRequest<FavoritesNews> = FavoritesNews.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title = %@",(new_model.title as NSObject? as? String)! )
        do {
            var results = try context.fetch(fetchRequest)
            if results.count == NSNotFound {
                // error
            }
            else if results.count == 0  {
                // not exists
                var newImage: UIImage = UIImage(named: "unlike")!
                faveImage.image = newImage
                
            } else {
                // exists
                var newImage: UIImage = UIImage(named: "like")!
                faveImage.image = newImage
            }
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
}
