//
//  SayingsListViewController.swift
//  Sayings
//
//  Created by Hyunsoo Park on 3/29/17.
//  Copyright © 2017 Hyunsoo Park. All rights reserved.
//

import UIKit

class SayingsListViewController: UITableViewController {

    let cellId = "cellId"
    var sayings = [Saying]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DataService.instance.fetchSayingList { (sayings) in
            self.sayings = sayings
            DispatchQueue.main.async(execute: { 
                self.tableView.reloadData()
            })
        }
        
        tableView.separatorColor = .clear
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sayings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SayingsViewCell {
            cell.saying = sayings[indexPath.row]
            return cell
        }
        return SayingsViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
}
