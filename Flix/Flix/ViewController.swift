//
//  ViewController.swift
//  Flix
//
//  Created by Beverly Abadines on 1/20/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //arr of dict
    var myMovies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovies()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = myMovies[indexPath.row]
        
        let detailsViewController = segue.destination as! MovieDetailsViewController
        
        detailsViewController.movie = movie
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getMovies(){
        let net = Network(urlName: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
        net.getNowPlaying(){ (myMovies) in
        self.myMovies = myMovies!
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return movie total
        return myMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "completeMovieCell") as! completeMovieCell
        let movie = myMovies[indexPath.row]
        
        let title = movie["title"] as! String
        cell.titleLabel.text = title
        
        let sum = movie["overview"] as! String
        cell.sumLabel.text = sum
       
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String

        //posterPath + baseUrl = special type of URL (has valid form of "https")
        let posterUrl = URL(string: baseUrl + posterPath)
        
        //gets img from url
        //modify image = aspect fill and clip to bounds
        cell.posterView.af_setImage(withURL: posterUrl!)
        return cell
        }
}


