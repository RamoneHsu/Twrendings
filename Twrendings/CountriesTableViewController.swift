//
//  CountriesTableViewController.swift
//  Twrendings
//
//  Created by 徐承維 on 2020/2/21.
//  Copyright © 2020 徐承維. All rights reserved.
//

import UIKit

class CountriesTableViewController: UITableViewController {
    var countries : [String: Int]?
    var locations : [Location] = []
    var sortedLocations : [Location] = []
    var woeid : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select a country"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        getCountriesData()
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.woeid = locations[indexPath.row].woeid
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sortedLocations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryTableViewCell

        // Configure the cell...
        cell.textLabel?.text = sortedLocations[indexPath.row].name
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
    
    func getCountriesData (){
        guard let data = NSDataAsset(name: "locations")?.data else {
            print ("data does not exist")
            return
        }
        do {
            let decoder = JSONDecoder()
            let locations = try decoder.decode([Location].self, from: data)

//            print(locations)
            self.locations = locations
            
            for location : Location in locations {
                if location.placeType?.name == "Country" {
                    sortedLocations.append(location)
                }
            }
            let worldwide = locations.filter { (location) -> Bool in
                location.name == "Worldwide"
            }[0]
            
            sortedLocations.insert(worldwide, at: 0)
            
            tableView.reloadData()
//            print(countries)
            
        } catch {
            print (error)
        }
    }

    @IBSegueAction func sendWoeId(_ coder: NSCoder) -> TrendingTopicsTableViewController? {
        if let row = tableView.indexPathForSelectedRow?.row{
            let countryName = sortedLocations[row].name!
            let controller = TrendingTopicsTableViewController(coder: coder, woeid: sortedLocations[row].woeid, countryName: countryName)
            return controller
        } else{
            return nil
        }
    }
}
