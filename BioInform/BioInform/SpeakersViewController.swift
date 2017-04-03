//
//  SpeakersViewController.swift
//  BioInform
//
//  Created by Thor on 3/29/17.
//  Copyright © 2017 Thor. All rights reserved.
//

import UIKit

class SpeakersViewController: UIViewController {
    var stringForSpeakerName: String?
    var stringForSpeakerInstitution: String?
    var stringForSpeakerBio: String?
    var stringForSpeakerPosition: String?
    
    @IBOutlet weak var speakerNameLabel: UILabel!
    
    
    @IBOutlet weak var speakerInstituteLabel: UILabel!
    
    @IBOutlet weak var speakerPositionLabel: UILabel!
    
    @IBOutlet weak var speakerBioLabel: UITextView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if stringForSpeakerName != nil {
            speakerNameLabel.text = stringForSpeakerName
        }
        
        if stringForSpeakerInstitution != nil {
            speakerInstituteLabel.text = stringForSpeakerInstitution
        }
        
        if stringForSpeakerPosition != nil {
            speakerPositionLabel.text = stringForSpeakerPosition
        }
        
        if stringForSpeakerBio != nil {
            speakerBioLabel.text = stringForSpeakerBio
        }
        
    }
    
    
}
