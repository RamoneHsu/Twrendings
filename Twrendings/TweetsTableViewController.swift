//
//  TweetsTableViewController.swift
//  Twrendings
//
//  Created by 徐承維 on 2020/2/21.
//  Copyright © 2020 徐承維. All rights reserved.
//

import UIKit

class TweetsTableViewController: UITableViewController {
    var trendingTopic : String?
    var tweets : Tweets?
    var statuses : [Status]?
    var usedCell : [Int]? = []
    
    @IBOutlet weak var seg: UISegmentedControl!
    
    init?(coder : NSCoder, trendingTopic: String) {
        self.trendingTopic = trendingTopic
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = trendingTopic
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        getTweets(type: resultType.mostPopular.rawValue)
//        testGetTweet(type: resultType.newest.rawValue)
        
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let tweet = tweets {
            self.statuses = tweet.statuses
            return tweet.statuses.count
        } else {
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "a h:mm · yyyy年MM月dd日"
        cell.indicator.center = cell.center
        cell.imageView?.image = nil
        
        // Configure the cell...
        if let tweets = tweets {
            cell.update(status: tweets.statuses[indexPath.row])
        }
        
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func getTweets (type : String){
        if let trendingTopic = trendingTopic?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            print(trendingTopic)
            var request = URLRequest(url: URL(string: "https://api.twitter.com/1.1/search/tweets.json?q=" + trendingTopic + "&result_type=" + type + "&count=100")!,timeoutInterval: Double.infinity)
            request.addValue(Value.Bearer.rawValue, forHTTPHeaderField: Value.Authorization.rawValue)
            request.httpMethod = "GET"
            print(request.description)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "E MMM d HH:mm:ss Z yyyy"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                if let data = data, let tweet = try? decoder.decode(Tweets.self, from: data) {
                    DispatchQueue.main.async {
                        self.tweets = tweet
                        print(tweet)
                        self.tableView.reloadData()
                    }
                } else {
                    print(error.debugDescription)
                }
            }.resume()
        } else {
            print("parse trending topic failed")
            
        }
        
    }
    
    
    func testGetTweet(type : String){
        if let trendingTopic = trendingTopic?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            print(trendingTopic)
            var request = URLRequest(url: URL(string: "https://api.twitter.com/1.1/search/tweets.json?q=" + trendingTopic + "&result_type=\(type)&count=100")!,timeoutInterval: Double.infinity)
            request.addValue(Value.Bearer.rawValue, forHTTPHeaderField: Value.Authorization.rawValue)
            request.httpMethod = "GET"
            print(request.description)
            URLSession.shared.dataTask(with: request) { (data, response , error) in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "E MMM d HH:mm:ss Z yyyy"
                        decoder.dateDecodingStrategy = .formatted(dateFormatter)
                        
                        let result = try decoder.decode(Tweets.self, from: data)
                        print(result)
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        usedCell?.removeAll()
        switch sender.selectedSegmentIndex {
        case 0:
            getTweets(type: resultType.mostPopular.rawValue)
            break
        case 1 :
            getTweets(type: resultType.newest.rawValue)
            break
        case 2 :
            getTweets(type: resultType.mixed.rawValue)
            break
        default:
            break
            
        }
    }
    
    enum resultType : String {
        case mostPopular = "popular", newest = "recent", mixed = "mixed"
    }
    
    
    func getImage (url : URL){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
        }
    }
    
    
}

