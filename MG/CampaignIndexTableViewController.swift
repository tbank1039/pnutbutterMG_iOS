//
//  CampaignIndexTableViewController.swift
//  MG
//
//  Created by Parker Murphy on 7/5/17.
//  Copyright © 2017 Tyler Bank. All rights reserved.
//

import UIKit

class CampaignIndexTableViewController: UITableViewController {
    var campaigns = [Campaign]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let sampleCampaign = Campaign(campaignId: 1, name: "Mouse Guards Gone Wild", gameMaster: "Jokin Jocab")
        campaigns = [sampleCampaign]
        
        self.refreshControl?.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.campaigns.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell_identifier = "CampaignIndexTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cell_identifier, for: indexPath) as? CampaignIndexTableViewCell else {
            fatalError("WE GOT ISSUES!!!")
        }

        // Configure the cell...
        let campaign = campaigns[indexPath.row]
        cell.campaignName.text = campaign.name
        cell.gameMasterName.text = campaign.gameMaster
        return cell
    }
    
    func handleRefresh(_ refreshControl : UIRefreshControl) {
        let newCampaign = Campaign(campaignId: 1, name: "Mouse Guard OG", gameMaster: "Parker Murphy")
        campaigns.append(newCampaign)
        
        campaigns.sort() { $0.name < $1.name }
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
