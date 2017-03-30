//
//  SayingsListViewController.swift
//  Sayings
//
//  Created by Hyunsoo Park on 3/29/17.
//  Copyright © 2017 Hyunsoo Park. All rights reserved.
//

import UIKit
import Alamofire

class TodaysSayingViewController: UIViewController {

    @IBOutlet weak var mainImageView: DownloadImageView!
    @IBOutlet weak var sayingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        DataService.instance.fetchTodaysSaying(date: "20170329") { (saying) in
            if let imageUrl = saying.image_url {
                DataService.instance.fetchImage(imageUrl: imageUrl, completion: { (image) in
                    DispatchQueue.main.async(execute: {
                        self.mainImageView.image = image
                    })
                })
            }
            
            if let body = saying.body, let author = saying.author {
                self.setBasicUI(body: body, author: author)
            }
        }
    }
    
    func getDateInfo() -> String {
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        return "\(year)\(month)\(day)"
    }
    
    func setBasicUI(body: String, author: String) {
        let attributedText = NSMutableAttributedString(string: body, attributes: [
            NSFontAttributeName: UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium),
            NSForegroundColorAttributeName: UIColor.white
            ])
        
        attributedText.append(NSAttributedString(string: "\n\n- \(author) -", attributes: [
            NSFontAttributeName: UIFont.systemFont(ofSize: 12),
            NSForegroundColorAttributeName: UIColor.white
            ]))
        
        // center alignment
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.string.characters.count))
        
        sayingLabel.attributedText = attributedText
    }
}
