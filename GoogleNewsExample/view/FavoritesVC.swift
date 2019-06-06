//
//  FavoritesVC.swift
//  GoogleNewsExample
//
//  Created by MAC on 6/3/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit
import Alamofire
import Nuke
import CoreData
class FavoritesVC: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    var mainPageModel : MainPageViewModel!
    
    var ListOFTable = [FavoritesNews]()
    
    var mainpageViewModel : MainPageViewModel!
    
    var ArticlesArray = Array<NewModel>()
    
    var refreshControl = UIRefreshControl()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArticlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : NewCell = tableList.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewCell
        cell.titleLable.text = ArticlesArray[indexPath.row].title
        cell.loadImage(url : ArticlesArray[indexPath.row].urlToImage!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetails", sender: ArticlesArray[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dis = segue.destination as? ItemDetailsVC {
            if let NewItem = sender as? NewModel{
                dis.NewItem = NewItem
            }
        }
    }

    
    @IBOutlet weak var tableList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadAllFav()
        
        // Refresh control add in tableview.
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableList.addSubview(refreshControl)
        
        
    }
    
    @objc func refresh(_ sender: Any) {
        // Call webservice here after reload tableview.
        LoadAllFav()
    }

    
    func LoadAllFav()  {
        ArticlesArray.removeAll()
        ListOFTable.removeAll()
        let fetchRequest : NSFetchRequest<FavoritesNews> =
            FavoritesNews.fetchRequest()
        do{
            self.ListOFTable = try! context.fetch(fetchRequest)
            
            if ListOFTable.count > 0 {
                for index in 0...ListOFTable.count-1 {
                    
                    let item = ListOFTable[index]
                    let addFavItem = NewModel(author : item.author as NSObject? as? String ?? ""
                        , title : item.title as NSObject? as? String ?? ""
                        , descriptiontext : item.descriptiontext as NSObject? as? String ?? ""
                        , url : item.url as NSObject? as? String ?? ""
                        , urlToImage : item.urlToImage as NSObject? as? String ?? ""
                        , publishedAt : item.publishedAt as NSObject? as? String ?? ""
                        , content : item.content as NSObject? as? String ?? ""
                    )
                    
                    ArticlesArray.append(addFavItem)
            }
            }else{
                // empty list 
            }
        }catch{
            print("error")
        }
        self.tableList.reloadData()
        refreshControl.endRefreshing()
        
    }
}


