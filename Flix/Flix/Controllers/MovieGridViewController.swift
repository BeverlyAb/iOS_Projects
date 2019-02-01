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
    let net = Network(urlName: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getMovies()
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
    
    func getMovies(){
        net.getNowPlaying(){ (myMovies) in
            self.myMovies = myMovies!
            self.collectionView.reloadData()
        }
    }
    
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let movie = myMovies[indexPath.item]
        
        let detailsViewController = segue.destination as! GridDetatilsViewController
        
        detailsViewController.movie = movie
        
        collectionView.deselectItem(at: indexPath, animated: true)
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
        cell.posterView.af_setImage(withURL:net.getPosterUrl(name: baseUrl, movie: movie)!)
        
        return cell
    }
    
    
    
}

