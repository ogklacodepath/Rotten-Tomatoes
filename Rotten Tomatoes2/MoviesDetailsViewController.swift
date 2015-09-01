//
//  MoviesDetailsViewController.swift
//  Rotten Tomatoes2
//
//  Created by Golak Sarangi on 8/31/15.
//  Copyright (c) 2015 Golak Sarangi. All rights reserved.
//

import UIKit

class MoviesDetailsViewController: UIViewController {

    var selectedMovie : NSDictionary?
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moviePosterImage: UIImageView!
    func assignSelectedMovie(movie: NSDictionary) {
        self.selectedMovie = movie
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        descriptionLabel.text = self.selectedMovie!["synopsis"] as? String
        titleLabel.text = self.selectedMovie!["title"] as? String
        var imageUrl = self.selectedMovie?.valueForKeyPath("posters.detailed") as! String
        var url = NSURL(string: imageUrl)!
        descriptionLabel.textColor = UIColor.whiteColor()
        moviePosterImage.setImageWithURL(url)
    }

}
