//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

import AFNetworking

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var businesses: [Business]!
    //var searchBar : UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    var filter = [Business]()
    var shouldShowSearchResults = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        createSearchBar()
        
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
            }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    func createSearchBar(){
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.showsCancelButton = false;
        searchBar.placeholder = "Find your restaurant"
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter = businesses.filter(
            { (businesses: Business) -> Bool in
                return businesses.name?.lowercased().range(of: searchText.lowercased()) != nil
        })
        if searchText != "" {
            self.shouldShowSearchResults = true
            self.tableView.reloadData()
        }else{
            self.shouldShowSearchResults = false
            self.tableView.reloadData()
        }
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        shouldShowSearchResults = true
        searchBar.endEditing(true)
        self.tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if shouldShowSearchResults{
            return filter.count
        }else{
            if businesses != nil {
                return businesses.count
            }else{
                return 0
            }
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        if shouldShowSearchResults {
            cell.business = filter[indexPath.row]
        }else{
            cell.business = businesses[indexPath.row]
        }
        
        
        return cell
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}



