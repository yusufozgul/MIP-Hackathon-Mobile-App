//
//  SignUpKeywordView.swift
//  Wevent
//
//  Created by Yusuf Özgül on 18.08.2019.
//  Copyright © 2019 Ilao. All rights reserved.
//

import UIKit

class SignUpKeywordView: UIView
{
    @IBOutlet weak var textRow1: UIView!
    @IBOutlet weak var textRow2: UIView!
    @IBOutlet weak var textRow3: UIView!
    @IBOutlet weak var textRow4: UIView!
    @IBOutlet weak var textRow5: UIView!
    @IBOutlet weak var textRow6: UIView!
    @IBOutlet weak var textRow7: UIView!
    
    @IBOutlet weak var contiuneView: UIView!
    @IBOutlet weak var contiuneLabel: UILabel!
    
    var textArray = ["Computer", "Sport", "Kitchen", "Social Activity", "Arts", "Party", "Community", "Travel & Outdoor", "Health", "Bussiness", "Science", "Charity & Causes", "Food & Drinks", "E-Sport", "School", "Meetup", "Engineering", "Work & Internship"]
    
    weak var delegate: SignUpDelegate?
    var rows: [UIView] = []
    var selectedWords: [String] = []
  
    override func awakeFromNib()
    {
        contiuneLabel.text = "Devam"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadView()
        }
    }
    func loadView()
    {
        rows = [textRow1, textRow2, textRow3, textRow4, textRow5, textRow6, textRow7]
        let screenSize: CGRect = UIScreen.main.bounds
        for text in textArray
        {
            let label = UILabel()
            label.text = text
            label.sizeToFit()
            label.textColor = #colorLiteral(red: 0.3411764706, green: 0.3411764706, blue: 0.3411764706, alpha: 1)

            let textView = UIView()
            textView.frame = CGRect(x: 0,
                                    y: 0,
                                    width: label.frame.width * 1.4,
                                    height: textRow1.frame.height)
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
            
            let button = UIButton()
            button.setTitle(nil, for: .normal)
            button.addSubview(textView)
            button.addTarget(self, action: #selector(self.tapWordView(sender:)), for: .touchUpInside)
            
            for row in rows
            {
                if let lastView = row.subviews.last
                {
                    let width = screenSize.width - 40
                    let maxX = lastView.frame.maxX
                    let spaceValue = row.subviews.isEmpty ? 0 : (CGFloat(10 * row.subviews.count) + 10 )
                    if width - maxX > textView.frame.width + spaceValue
                    {
                        button.frame = CGRect(x: maxX + 15,
                                                y: 0,
                                                width: label.frame.width * 1.4,
                                                height: textRow1.frame.height)
                        row.addSubview(button)
                        break
                    }
                }
                else
                {
                    button.frame = CGRect(x: 0,
                                          y: 0,
                                          width: label.frame.width * 1.3,
                                          height: textRow1.frame.height)
                    row.addSubview(button)
                    break
                }
            }
        }
        setContiuneView()
    }
    func setContiuneView()
    {
        contiuneView.clipsToBounds = true
        contiuneView.layer.cornerRadius = 5
        contiuneViewSetDisable()
    }
    func contiuneViewSetEnable()
    {
        contiuneView.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.3960784314, blue: 0.8980392157, alpha: 1)
        contiuneLabel.textColor = .white
    }
    func contiuneViewSetDisable()
    {
        contiuneLabel.textColor = #colorLiteral(red: 0.6705882353, green: 0.7137254902, blue: 0.7803921569, alpha: 1)
        contiuneView.backgroundColor = #colorLiteral(red: 0.1569802463, green: 0.1570138037, blue: 0.1569758356, alpha: 1)
    }
    
    @objc func tapWordView(sender: UIButton)
    {
        if let wordView = sender.subviews.first, let label = wordView.subviews.first as? UILabel
        {
            if wordView.backgroundColor == #colorLiteral(red: 0.05490196078, green: 0.3960784314, blue: 0.8980392157, alpha: 0.1)
            {
                UIView.animate(withDuration: 0.3) {
                    wordView.layer.borderColor = UIColor.lightGray.cgColor
                    label.textColor = #colorLiteral(red: 0.3411764706, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
                    wordView.backgroundColor = .clear
                }
                
                selectedWords = selectedWords.filter {$0 != label.text!}
            }
            else
            {
                UIView.animate(withDuration: 0.3) {
                    wordView.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.3960784314, blue: 0.8980392157, alpha: 0.1)
                    wordView.layer.borderColor = UIColor.systemBlue.cgColor
                    label.textColor = UIColor.systemBlue
                }
                selectedWords.append(label.text!)
            }
        }
        setButtonState()
    }
    func setButtonState()
    {
        contiuneViewSetDisable()
        for view in rows
        {
            if let wordButtons = view.subviews as? [UIButton]
            {
                for wordButton in wordButtons
                {
                    if let view = wordButton.subviews.first
                    {
                        if view.backgroundColor == #colorLiteral(red: 0.05490196078, green: 0.3960784314, blue: 0.8980392157, alpha: 0.1) && selectedWords.count >= 3
                        { contiuneViewSetEnable()}
                    }
                }
            }
        }
    }
    @IBAction func tapContiune(_ sender: Any)
    {
        if contiuneView.backgroundColor == #colorLiteral(red: 0.05490196078, green: 0.3960784314, blue: 0.8980392157, alpha: 1)
        {
            delegate?.contiune()
        }
    }
}
