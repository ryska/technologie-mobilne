//
//  TableViewController.swift
//  zadanie1
//
//  Created by Adrianna Ryś  on 11.11.2016.
//  Copyright © 2016 ada. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let albums: NSMutableArray = AlbumsSingleton.sharedInstance.list

    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        tableView.reloadData();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ViewController {
            if let cell = sender as? UITableViewCell {
                let selectedIndex = self.tableView.indexPath(for: cell);
                viewController.albumIndex = selectedIndex!.row
            } else {
                viewController.showNewAlbum = true
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        let recordData: NSDictionary = albums[indexPath.row] as! NSDictionary;
        
        cell.textLabel?.text = recordData.value(forKey: "artist") as? String;
        cell.detailTextLabel?.text = recordData.value(forKey: "title") as? String;
        
        return cell;
    }
  }
