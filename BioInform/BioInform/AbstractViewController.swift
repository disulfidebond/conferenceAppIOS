//
//  AbstractViewController.swift
//  BioInform
//
//  Created by Thor on 3/28/17.
//  Copyright © 2017 Thor. All rights reserved.
//

import UIKit

struct DataForAbstract {
    var title: String = ""
    var name: String = ""
    var institution:String = ""
    var submissionCoAuth: String = ""
    var submissionCoAuthInst: String = ""
    var textOfAbstract: String = ""
}


class AbstractViewController: UITableViewController {
    var abstractsFromJSON = [AgendaDetailsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveJSONfromFile()
    }
    
    func jsonDataToTable(_ data: Data) {
        do {
            if let jsonDict: NSDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                if let presenters : NSArray = jsonDict["Abstracts"] as? NSArray {
                    // 49 abstracts
                    for i in 0..<48 {
                        if let aPresenter : NSDictionary = presenters[i] as? NSDictionary {
                            // var a = abstractObject()
                            var jsonObj = AgendaDetailsModel()
                            jsonObj.name = aPresenter["name"] as! String
                            jsonObj.date = aPresenter["date"] as! String
                            jsonObj.time = aPresenter["time"] as! String
                            jsonObj.title = aPresenter["title"] as! String
                            jsonObj.session = aPresenter["session"] as! Int
                            jsonObj.guestOrVIPSpeaker = aPresenter["guestOrVIPSpeaker"] as! Bool
                            jsonObj.sponsor = aPresenter["sponsor"] as! Bool
                            jsonObj.speakerBio = aPresenter["speakerBio"] as! String
                            jsonObj.position = aPresenter["position"] as! String
                            jsonObj.institution = aPresenter["institution"] as! String
                            jsonObj.abstractTalk = aPresenter["abstractTalk"] as! Bool
                            jsonObj.posterTalk = aPresenter["posterTalk"] as! Bool
                            jsonObj.submissionCoAuthors = aPresenter["submissionCoAuthors"] as! String
                            jsonObj.submissionCoAuthorsInst = aPresenter["submissionCoAuthorsInst"] as! String
                            jsonObj.abstract = aPresenter["abstract"] as! String
                            jsonObj.skip = aPresenter["skip"] as! Bool
                            if !jsonObj.skip {
                                abstractsFromJSON.append(jsonObj)
                            }
                            // agendasFromJSON.append(jsonObj)
                        }
                    }
                    
                }
            }
            
        } catch {print(error)}
        
    }
    
    func retrieveJSONfromFile() {
        let jsonFilePath = Bundle.main.path(forResource: "abstractsJSON_2017", ofType: "json")
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath!), options: Data.ReadingOptions.mappedIfSafe)
            
            if jsonData.count > 0 {
                jsonDataToTable(jsonData)
            } else { print("Error with Reading JSON")}
            
        } catch { print(error) }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "abCell")
        if (cell != nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "abCell")
            cell?.backgroundColor = UIColor.clear
        }
        
        
        let name = abstractsFromJSON[indexPath.row].name
        let title = abstractsFromJSON[indexPath.row].title
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell?.detailTextLabel?.numberOfLines = 0
        cell?.detailTextLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell?.textLabel?.text = name
        cell?.detailTextLabel?.text = title
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? AbstractDetailViewController {
            let selectedIndexPath = tableView.indexPathForSelectedRow as IndexPath?
            if selectedIndexPath != nil {
                

                dest.stringForAbstractTitle = abstractsFromJSON[(selectedIndexPath?.row)!].title
                dest.stringForAbstractAuthor = abstractsFromJSON[(selectedIndexPath?.row)!].name
                dest.stringForAbstractAuthorInst = abstractsFromJSON[(selectedIndexPath?.row)!].institution
                dest.stringForAbstractCoAuthor = abstractsFromJSON[(selectedIndexPath?.row)!].submissionCoAuthors
                dest.stringForAbstractCoAuthorInst = abstractsFromJSON[(selectedIndexPath?.row)!].submissionCoAuthorsInst
                dest.stringForAbstractText = abstractsFromJSON[(selectedIndexPath?.row)!].abstract
            }
        }
        super.prepare(for: segue, sender: sender)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showAbstractDetails", sender: tableView)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return abstractsFromJSON.count

    }

    
    
}
