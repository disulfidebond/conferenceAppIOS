//
//  AbstractDetailsViewController.swift
//  BioInform
//
//  Created by Thor on 3/28/17.
//  Copyright © 2017 Thor. All rights reserved.
//

import UIKit

class AbstractDetailViewController: UITableViewController {
    
    var detailsForTable = [String]()
    var stringForAbstractTitle: String?
    var stringForAbstractAuthor: String?
    var stringForAbstractAuthorInst: String?
    var stringForAbstractCoAuthor: String?
    var stringForAbstractCoAuthorInst: String?
    var stringForAbstractText: String?
    var nullStringForAbstractText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if stringForAbstractTitle != nil {
            detailsForTable.append(stringForAbstractTitle!)
        } else {
            stringForAbstractTitle = ""
        }
        
        if stringForAbstractAuthor != nil {
            detailsForTable.append(stringForAbstractAuthor!)
        }
        
        if stringForAbstractAuthorInst != nil {
            detailsForTable.append(stringForAbstractAuthorInst!)
        
        if stringForAbstractCoAuthor != nil {
            detailsForTable.append(stringForAbstractCoAuthor!)
        }
        
        if stringForAbstractCoAuthorInst != nil {
            detailsForTable.append(stringForAbstractCoAuthorInst!)
        }
        if stringForAbstractText == nil {
            stringForAbstractText = nullStringForAbstractText
        }

        
        }

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "tCell")
        if (cell != nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "tCell")
            cell?.backgroundColor = UIColor.clear
        }
        var textLabelName: String?
        var textSubtitleLabel: String?
        switch indexPath.row {
        case 0:
            textLabelName = detailsForTable[indexPath.row]
            textSubtitleLabel = ""
        case 1:
            textLabelName = "Author"
            textSubtitleLabel = detailsForTable[indexPath.row]
        case 2:
            textLabelName = "Author Institution"
            textSubtitleLabel = detailsForTable[indexPath.row]
        case 3:
            textLabelName = "CoAuthor"
            textSubtitleLabel = detailsForTable[indexPath.row]
        case 4:
            textLabelName = "CoAuthor Institution"
            textSubtitleLabel = detailsForTable[indexPath.row]
        default:
            textLabelName = ""
        }
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell?.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        cell?.textLabel?.text = textLabelName
        cell?.detailTextLabel?.numberOfLines = 0
        cell?.detailTextLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell?.detailTextLabel?.text = textSubtitleLabel
        
        return cell!
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? AbstractTextViewController {
            let selectedIndexPath = tableView.indexPathForSelectedRow as IndexPath?
            if selectedIndexPath != nil {
                
                dest.textForview = stringForAbstractText
                dest.textForTitle = stringForAbstractTitle
                
            }
        }
        super.prepare(for: segue, sender: sender)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            performSegue(withIdentifier: "showAbstractText", sender: tableView)

        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsForTable.count
        
    }

    
    
}
