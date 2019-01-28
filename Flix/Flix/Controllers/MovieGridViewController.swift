//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Beverly Abadines on 1/27/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController{

    var myMovies = [[String: Any]]()
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.myMovies = dataDictionary["results"] as! [[String:Any]]
                self.collectionView.reloadData()
            }
        }
        task.resume()
    
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        //Layout Settings ------------------------------------------------------
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //controls space in btwn rows
        layout.minimumLineSpacing = 40
        
        layout.minimumInteritemSpacing = 4
        //expects width and height
        let width = (view.frame.size.width / 3) - 4 // divivdes into 3 col
        layout.itemSize = CGSize(width: width, height : width * 1.5)
        
    }
}



extension MovieGridViewController : UICollectionViewDelegate,
UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        //collection views have items, not row or col
        let movie = myMovies[indexPath.item]
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        return cell
    }
    
    
}

