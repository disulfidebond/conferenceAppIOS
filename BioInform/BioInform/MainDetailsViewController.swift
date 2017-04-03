//
//  MainDetailsViewController.swift
//  BioInform
//
//  Created by Thor on 3/22/17.
//  Copyright © 2017 Thor. All rights reserved.
//

import UIKit


struct AgendaDetailsModel {
    var session: Int = 0
    var name: String = ""
    var time: String = ""
    var title: String = ""
    var date: String = ""
    var guestOrVIPSpeaker: Bool = false
    var sponsor: Bool = false
    var speakerBio: String = ""
    var position: String = ""
    var institution: String = ""
    var abstractTalk: Bool = false
    var posterTalk: Bool = false
    var submissionCoAuthors: String = ""
    var submissionCoAuthorsInst: String = ""
    var abstract: String = ""
    var skip: Bool = false
}

class PresentersObject {
    var arrayOfPresenters = [AgendaDetailsModel]()
    var guestSpeakers = [AgendaDetailsModel]()
    var presenterAbstractObject = [AgendaDetailsModel]()
    
    func addObj(presenter: AgendaDetailsModel) {
        arrayOfPresenters.append(presenter)
    }
    func addGuestSpeakers() {
        for i in 0..<arrayOfPresenters.count {
            if arrayOfPresenters[i].guestOrVIPSpeaker {
                guestSpeakers.append(arrayOfPresenters[i])
            }
        }
    }
}

var p : PresentersObject = PresentersObject()
var guestSpeakerList : PresentersObject = PresentersObject()


extension URLSessionTask {
    func start() {
        self.resume()
    }
}

class MainDetailsViewController: UITableViewController, URLSessionDelegate {
    
    var agendasFromJSON = [AgendaDetailsModel]()
    
    override func viewDidAppear(_ animated: Bool) {

        tableView.reloadData()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if agendasFromJSON.count == 0 {
            retrieveJSONfromFile()
        }
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
        */
        
    }
    
    func jsonDataFromURL(data: NSData) {
        var agenda = AgendaDetailsModel()
        agendasFromJSON.removeAll()
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
                                agendasFromJSON.append(agenda)
                            }
                        }
                        print(sessions.count)
                        print(agendasFromJSON.count)
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
                    for i in 0..<33 {
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
                                agendasFromJSON.append(jsonObj)
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
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "aCell")
        if (cell != nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "aCell")
            cell?.backgroundColor = UIColor.clear
        }
        
        
        let name = agendasFromJSON[indexPath.row].time
        let title = agendasFromJSON[indexPath.row].title
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell?.detailTextLabel?.numberOfLines = 0
        cell?.detailTextLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell?.textLabel?.text = name
        cell?.detailTextLabel?.text = title
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? AgendaDetailsViewController {
            let selectedIndexPath = tableView.indexPathForSelectedRow as IndexPath?
            if selectedIndexPath != nil {
                
                dest.stringForSpeakerName = agendasFromJSON[(selectedIndexPath?.row)!].name
                dest.stringForAbstractTitle = agendasFromJSON[(selectedIndexPath?.row)!].title
                dest.stringForEventTime = agendasFromJSON[(selectedIndexPath?.row)!].time
                dest.sessionNameIdentifier = agendasFromJSON[(selectedIndexPath?.row)!].session
            }
        }
        super.prepare(for: segue, sender: sender)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailSegue", sender: tableView)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(agendasFromJSON.count)
        print(p.arrayOfPresenters.count)
        return agendasFromJSON.count
    }

    
    
    
}

