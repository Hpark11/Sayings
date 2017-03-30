//
//  WriteSayingsViewController.swift
//  Sayings
//
//  Created by Hyunsoo Park on 3/29/17.
//  Copyright © 2017 Hyunsoo Park. All rights reserved.
//

import UIKit

class WriteSayingsViewController: UITableViewController {

    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var authorTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bodyTextView.textContainerInset = UIEdgeInsetsMake(10, 8, 0, 0)
        authorTextField.layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0);
    }

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    @IBAction func DoneButtonTapped(_ sender: UIBarButtonItem) {
        let saying = Saying()
        saying.author = authorTextField.text
        saying.body = bodyTextView.text
        saying.id = 1
        saying.image_url = "https://qqqqq.com"
        
        DataService.instance.writeSaying(saying: saying) { (result) in
            if result == true {
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
