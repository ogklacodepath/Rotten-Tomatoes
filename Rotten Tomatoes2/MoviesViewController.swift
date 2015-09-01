//
//  ViewController.swift
//  Rotten Tomatoes
//
//  Created by Golak Sarangi on 8/30/15.
//  Copyright (c) 2015 Golak Sarangi. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var movieTableView: UITableView!
    var movieList : [NSDictionary]?
    var urls = [
        "boxoffice": "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json",
        "dvd": "https://gist.githubusercontent.com/timothy1ee/e41513a57049e21bc6cf/raw/b490e79be2d21818f28614ec933d5d8f467f0a66/gistfile1.json"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.rowHeight = 150
        fetchMovieList()
    }
    
    
    func fetchMovieList() {
        fetchMovieListByType("boxoffice")
    }
    
    func fetchMovieListByType(type : String) {
        var url : NSURL = NSURL(string: urls[type]!)!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue:  NSOperationQueue.mainQueue(), completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary
            if let json = json {
                self.movieList = json["movies"] as? [NSDictionary]
            }
            self.movieTableView.reloadData();
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (movieList != nil) {
            return movieList!.count
        } else {
            return 0;
        }
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(2);
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as! MovieCell
        
        cell.contentView.layer.backgroundColor = UIColor.grayColor().CGColor
        
        var movie = self.movieList![indexPath.section] as NSDictionary
        var imageUrl = movie.valueForKeyPath("posters.thumbnail") as! String
        var url = NSURL(string: imageUrl)!
        cell.movieImageView.setImageWithURL(url)
        cell.movieTitle.text = movie["title"] as? String
        cell.movieDescription.text = movie["synopsis"] as? String
        return cell;
    }
    
    override func  prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! MoviesDetailsViewController
        var indexPath = movieTableView.indexPathForCell(sender as! UITableViewCell)
        let movieObj = movieList![indexPath!.section] as NSDictionary
        vc.assignSelectedMovie(movieObj)
    }
    
}

