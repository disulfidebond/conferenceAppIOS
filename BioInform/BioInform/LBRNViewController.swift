//
//  LBRNViewController.swift
//  BioInform
//
//  Created by Thor on 3/29/17.
//  Copyright © 2017 Thor. All rights reserved.
//

import UIKit

class LBRNViewController: UIViewController {
    
    @IBAction func openLBRNSite(_ sender: Any) {
        let LBRNurl = "https://lbrn.lsu.edu/"
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: LBRNurl)!, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.open(URL(string: LBRNurl)!, options: [:], completionHandler: nil)
        }
    }
    
    @IBOutlet weak var lbrnText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lbrnText.setContentOffset(CGPoint.zero, animated: false)
    }
}
