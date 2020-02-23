//
//  TrendingTopicsTableViewController.swift
//  Twrendings
//
//  Created by 徐承維 on 2020/2/21.
//  Copyright © 2020 徐承維. All rights reserved.
//

import UIKit
import Foundation

class TrendingTopicsTableViewController: UITableViewController {
    var woeid : Int!
    var trending : [Trending]?
    var trends : [Trend]?
    var countryName : String!
    
    init?(coder : NSCoder, woeid : Int, countryName : String) {
        self.woeid = woeid
        self.countryName = countryName
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        getTrendingTopics()
        getTrendingTopics()
        self.title = "Trending topics in " + countryName
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if trending == nil {
            return 0
        } else {
            return trending![0].trends.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trendingTopicCell", for: indexPath) as! TrendingTopicTableViewCell

        // Configure the cell...
        cell.rankLabel?.text = (indexPath.row + 1).description
        cell.topicLabel?.text = trends?[indexPath.row].name
        if let volume = trends?[indexPath.row].tweet_volume?.description {
            cell.volumeLabel.text = volume + " 則推文"
        } else {
            cell.volumeLabel.text = "n 則推文"
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

    func getTrendingTopics() {
        var request = URLRequest(url: URL(string: "https://api.twitter.com/1.1/trends/place.json?id=\(woeid!)")!,timeoutInterval: Double.infinity)
        request.addValue(Value.Bearer.rawValue, forHTTPHeaderField: Value.Authorization.rawValue)

        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let data = data, let result = try? decoder.decode([Trending].self, from: data) {
//                print(data)
                DispatchQueue.main.async {
                    self.trending = result
//                    print(self.trending!)
                    self.trends = self.trending![0].trends
                    
                    if var trends = self.trends {
                        for int : Int in 0...trends.count - 1 {
                            if trends[int].tweet_volume == nil {
                                trends[int].tweet_volume = 0
                            }
                        }
                        trends.sort { (trend1, trend2) -> Bool in
                            trend1.tweet_volume! > trend2.tweet_volume!
                        }
                        self.trends = trends
                    }
                    
                    self.tableView.reloadData()
                }
            } else if let response = response {
                print (response)
            } else if let error = error {
                print (error)
            }
        }.resume()
        
    }
    
    @IBSegueAction func showTweets(_ coder: NSCoder) -> UITableViewController? {
        if let indexPath = tableView.indexPathForSelectedRow,
            let trendingTopic = trends?[indexPath.row].name {
            return TweetsTableViewController(coder: coder, trendingTopic: trendingTopic)
        } else {
            return nil
        }
        
    }
}
