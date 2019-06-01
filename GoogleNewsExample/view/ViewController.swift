//
//  ViewController.swift
//  GoogleNewsExample
//
//  Created by MAC on 5/22/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit
import Alamofire
import Nuke
class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    var mainPageModel : MainPageViewModel!
    
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    var mainpageViewModel : MainPageViewModel!
    
    var ArticlesArray = Array<NewModel>()
    
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
        
        // start UIActivityIndicatorView
        self.progressIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        progressIndicator.startAnimating()
        
        
        // This will be link to get google news
        let Urll = "https://newsapi.org/v2/top-headlines?sources=google-news&apiKey=9f1058e56fde48a782fa3638b40d43ae"
        
        Alamofire.request(Urll, method: .get,  encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                if let result = response.result.value {
                    let responseDict = result as! [String : Any]
                     let articles = responseDict["articles"] as! [[String : Any]]
                    print(articles)
                    DispatchQueue.global().sync {
                        // change view
                        for article in articles{
                            self.ArticlesArray.append(NewModel(
                                author: article["author"] as? String ?? "aa",
                                title: article["title"] as? String ?? "aa",
                                descriptiontext: article["description"] as? String ?? "aa",
                                url: article["url"] as? String ?? "aa", urlToImage: article["urlToImage"] as? String ?? "aa", publishedAt: article["publishedAt"] as? String ?? "aa", content: article["content"] as? String ?? "aa" ))
                        }
                        
                        
                        // reload data
                        self.tableList.reloadData()
                        
                        // stop UIActivityIndicatorView
                        self.progressIndicator.stopAnimating()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

