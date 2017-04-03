//
//  AgendaDetailsViewController.swift
//  BioInform
//
//  Created by Thor on 3/22/17.
//  Copyright © 2017 Thor. All rights reserved.
//

import UIKit

class AgendaDetailsViewController : UIViewController {
    
    enum sessionNameType: String {
        case session1 = "Session I: Drug Repurposing, Informatics, and Forensics"
        case session2 = "Session II: Health Informatics, Big Data, and Computing"
        case session3 = "Session III: Virology"
        case session4 = "Session IV: Microbiome and Epidemiology"
        case session5 = "Session V:  Genomics, Data Visualization, and Infectious Diseases"
        case session6 = "Session VI: Metabolomics and Proteomics"
    }
    
    @IBOutlet weak var sessionNameLabel: UILabel!

    @IBOutlet weak var timeForSelectedEvent: UILabel!
    
    @IBOutlet weak var titleLabelForSelectedEvent: UILabel!

    var stringForSpeakerName: String?
    var stringForAbstractTitle: String?
    var stringForEventTime: String?
    var sessionNameIdentifier: Int?
    
    @IBOutlet weak var presenterNameForSelectedEvent: UILabel!
    
    
    
    
    
    @IBAction func surveyButtonPressed(_ sender: Any) {
    
        let surveyURL = "https://redcap.lbrn.lsu.edu/surveys/?s=J73KDPNTXD"
        
        let alert = UIAlertController(title: "Participant Survey", message: "This will open a brief survey for you to complete in Safari.  You only need to complete it once.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction((UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{(paramAction:UIAlertAction) -> Void in
            UIApplication.shared.open(URL(string: surveyURL)!, options: [:], completionHandler: nil)})))
        alert.addAction((UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)))
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if stringForSpeakerName != nil {
            presenterNameForSelectedEvent.text = stringForSpeakerName
        } else {
            presenterNameForSelectedEvent.text = "ERROR NIL"
        }
        
        
        if stringForAbstractTitle != nil {
            titleLabelForSelectedEvent.text = stringForAbstractTitle
        } else {
            titleLabelForSelectedEvent.text = "ERROR NIL"
        }
        
        if stringForEventTime != nil {
            timeForSelectedEvent.text = stringForEventTime
        } else {
            timeForSelectedEvent.text = "ERROR NIL"
        }

        if sessionNameIdentifier != nil {
            if sessionNameIdentifier == 1 {
                sessionNameLabel.text = sessionNameType.session1.rawValue
            } else if sessionNameIdentifier == 2 {
                sessionNameLabel.text = sessionNameType.session2.rawValue
            } else if sessionNameIdentifier == 3 {
                sessionNameLabel.text = sessionNameType.session3.rawValue
            } else if sessionNameIdentifier == 4 {
                sessionNameLabel.text = sessionNameType.session4.rawValue
            } else if sessionNameIdentifier == 5 {
                sessionNameLabel.text = sessionNameType.session5.rawValue
            } else if sessionNameIdentifier == 6 {
                sessionNameLabel.text = sessionNameType.session6.rawValue
            } else {
                print("Unknown session")
            }
        } else {
            
        }
        
        
        
    }
    
}
