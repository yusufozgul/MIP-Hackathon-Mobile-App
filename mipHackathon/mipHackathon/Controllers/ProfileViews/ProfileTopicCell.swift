//
//  ProfileTopicCell.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit

class ProfileAboutDetailTopicsCell: UITableViewCell
{

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setView(keywordsArray: [String])
    {
        for view in contentView.subviews
        {
            view.removeFromSuperview()
        }
        
        var xValue: CGFloat = 24
        for text in keywordsArray
        {
            let label = UILabel()
            label.text = text
            label.sizeToFit()
            label.textColor = #colorLiteral(red: 0.3411764706, green: 0.3411764706, blue: 0.3411764706, alpha: 1)

            let textView = UIView()
            textView.frame = CGRect(x: xValue,
                                    y: 0,
                                    width: label.frame.width * 1.4,
                                    height: 32)
            textView.center.y = self.contentView.center.y
            if #available(iOS 13.0, *) {
                textView.backgroundColor = .systemBackground
            } else {
                textView.backgroundColor = .white
            }
            textView.addSubview(label)
            textView.layer.cornerRadius = textView.frame.height / 2
            
            textView.layer.masksToBounds = true
            textView.layer.borderColor = UIColor.lightGray.cgColor
            textView.layer.borderWidth = 2.0
            textView.isUserInteractionEnabled = false
            
            label.center = CGPoint(x: textView.frame.width / 2, y: textView.frame.height / 2)
            
            self.contentView.addSubview(textView)
            
            xValue += textView.frame.width + 8
        }
    }
}
