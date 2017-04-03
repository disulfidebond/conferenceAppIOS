//
//  AbstractTextViewController.swift
//  BioInform
//
//  Created by Thor on 3/29/17.
//  Copyright © 2017 Thor. All rights reserved.
//

import UIKit


class AbstractTextViewController: UIViewController {
    
    var textForview: String?
    var textForTitle: String?
    @IBOutlet weak var textInTextForView: UITextView!
    @IBOutlet weak var abstractTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if textForview != nil {
            textInTextForView.text = textForview
        }
        if textForTitle != nil {
            abstractTitleLabel.text = textForTitle
        }
        
    }
    /*
     @IBOutlet weak var abstractTitleLabel: UILabel!
     
     @IBOutlet weak var abstractAuthorLabel: UILabel!
     @IBOutlet weak var abtractAuthorInst: UILabel!
     
     @IBOutlet weak var abstractCoAuthorLabel: UILabel!
     
     
     @IBOutlet weak var coAuthorInstLabel: UILabel!
     
     @IBOutlet weak var abstractText: UITextView!
     
     var stringForAbstractTitle: String?
     var stringForAbstractAuthor: String?
     var stringForAbstractAuthorInst: String?
     var stringForAbstractCoAuthor: String?
     var stringForAbstractCoAuthorInst: String?
     var stringForForAbstractText: String?
     
     
     override func viewDidLoad() {
     super.viewDidLoad()
     
     if stringForAbstractTitle != nil {
     abstractTitleLabel.text = stringForAbstractTitle
     } else {
     abstractTitleLabel.text = "Error Nil"
     }
     
     if stringForAbstractAuthor != nil {
     abstractAuthorLabel.text = stringForAbstractAuthor
     } else {
     abstractAuthorLabel.text = "Error Nil"
     }
     
     if stringForAbstractAuthorInst != nil {
     abtractAuthorInst.text = stringForAbstractAuthorInst
     } else {
     abtractAuthorInst.text = "Error Nil"
     }
     
     if stringForAbstractCoAuthor != nil {
     abstractCoAuthorLabel.text = stringForAbstractCoAuthor
     } else {
     abstractCoAuthorLabel.text = "Error Nil"
     }
     
     if stringForAbstractCoAuthorInst != nil {
     coAuthorInstLabel.text = stringForAbstractCoAuthorInst
     } else {
     coAuthorInstLabel.text = "Error Nil"
     }
     
     if stringForForAbstractText != nil {
     abstractText.text = stringForForAbstractText
     } else {
     abstractText.text = "Error Nil"
     }
     
     
     }
     
     

     */
}
