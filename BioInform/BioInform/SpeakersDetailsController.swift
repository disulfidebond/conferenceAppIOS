//
//  SpeakersDetailsController.swift
//  BioInform
//
//  Created by Thor on 3/29/17.
//  Copyright © 2017 Thor. All rights reserved.
//

import UIKit

class SpeakersDetailsController: UITableViewController {
    
        var speakersFromJSON = p.guestSpeakers
        
        override func viewDidAppear(_ animated: Bool) {
            
            tableView.reloadData()
            
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // if agendasFromJSON.count == 0 {
            //     retrieveJSONfromFile()
            // }
            // uncomment to retrieve from server
            /*
             let url = NSURL(string: "https://lbrn.lsu.edu/events/bioinformatics-conference/app/agendaJSONsrv.json")
             let task = URLSession.shared.dataTask(with: url! as URL, completionHandler: {
             dataObj, response, error -> Void in
             print("Next Task Done")
             do {
             if dataObj != nil {
             self.jsonDataFromURL(data: dataObj! as NSData)
             } else {
             print("No Network Connection")}
             } catch {print(error)}
             })
             task.start()
             }
             */
    }
    
        /*
        func jsonDataFromURL(data: NSData) {
            var agenda = AgendaDetailsModel()
            speakersFromJSON.removeAll()
            do {
                if let jsonDict: NSDictionary = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? NSDictionary {
                    if let presenters : NSDictionary = jsonDict["Sessions"] as? NSDictionary {
                        if let sessions : NSArray = presenters["Sessions"] as? NSArray {
                            for i in 0..<29 {
                                if let s : NSDictionary = sessions[i] as? NSDictionary {
                                    agenda.time = s["time"] as! String
                                    agenda.title = s["title"] as! String
                                    agenda.name = s["name"] as! String
                                    agenda.session = 1
                                    speakersFromJSON.append(agenda)
                                }
                            }
                            print(sessions.count)
                            print(speakersFromJSON.count)
                        }
                    }
                }
            }
            catch{
                print(error)
                print("Error Parsing JSON, using internal copy")
                retrieveJSONfromFile()
            }
        }
        

        func jsonDataToTable(_ data: Data) {
            do {
                if let jsonDict: NSDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                    if let presenters : NSArray = jsonDict["Sessions"] as? NSArray {
                        // 34
                        // 27 posters
                        for i in 0..<32 {
                            if let aPresenter : NSDictionary = presenters[i] as? NSDictionary {
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
                                    speakersFromJSON.append(jsonObj)
                                }
                                
                                // agendasFromJSON.append(jsonObj)
                            }
                        }
                        
                    }
                }
                
            } catch {print(error)}
            
        }
        
        func retrieveJSONfromFile() {
            let jsonFilePath = Bundle.main.path(forResource: "agendaJSON_2017", ofType: "json")
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath!), options: Data.ReadingOptions.mappedIfSafe)
                
                if jsonData.count > 0 {
                    jsonDataToTable(jsonData)
                } else { print("Error with Reading JSON")}
                
            } catch { print(error) }
            
        }
        
        */
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "pCell")
            if (cell != nil) {
                cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "pCell")
                cell?.backgroundColor = UIColor.clear
            }
            
            
            let name = speakersFromJSON[indexPath.row].name
            let title = speakersFromJSON[indexPath.row].institution
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell?.detailTextLabel?.numberOfLines = 0
            cell?.detailTextLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell?.textLabel?.text = name
            cell?.detailTextLabel?.text = title
            
            return cell!
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let dest = segue.destination as? SpeakersViewController {
                let selectedIndexPath = tableView.indexPathForSelectedRow as IndexPath?
                if selectedIndexPath != nil {
                    dest.stringForSpeakerName = speakersFromJSON[(selectedIndexPath?.row)!].name
                    dest.stringForSpeakerInstitution = speakersFromJSON[(selectedIndexPath?.row)!].institution
                    dest.stringForSpeakerPosition = speakersFromJSON[(selectedIndexPath?.row)!].position
                    dest.stringForSpeakerBio = speakersFromJSON[(selectedIndexPath?.row)!].speakerBio
                }
            }
            super.prepare(for: segue, sender: sender)
        }
        
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 90
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "showPresenterDetail", sender: tableView)
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print(speakersFromJSON.count)
            return speakersFromJSON.count
        }
        
        
        
        
}


