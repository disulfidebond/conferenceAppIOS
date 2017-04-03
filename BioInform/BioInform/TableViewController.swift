//
//  TableViewController.swift
//  BioInform
//
//  Created by Thor on 3/23/17.
//  Copyright © 2017 Thor. All rights reserved.
//

import UIKit

class TableViewController : UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "aCell")
        if (cell != nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "aCell")
            cell?.backgroundColor = UIColor.clear
        }
        
        cell?.textLabel?.text = "Cell"
        
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailSegue", sender: tableView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
}
