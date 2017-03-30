//
//  SayingsViewCell.swift
//  Sayings
//
//  Created by Hyunsoo Park on 3/29/17.
//  Copyright © 2017 Hyunsoo Park. All rights reserved.
//

import UIKit

class SayingsViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: DownloadImageView!
    @IBOutlet weak var sayingLabel: UILabel!
    
    var saying: Saying? {
        didSet {
            if let imageUrl = saying?.image_url {
                DataService.instance.fetchImage(imageUrl: imageUrl, completion: { (image) in
                    DispatchQueue.main.async(execute: {
                        self.mainImageView.image = image
                    })
                })
            }
            
            if let body = saying?.body, let author = saying?.author {
                self.setBasicUI(body: body, author: author)
            }
        }
    }
    
    func setBasicUI(body: String, author: String) {
        
        let attributedText = NSMutableAttributedString(string: body, attributes: [
            NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium),
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
