//
//  DuyuruVC.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 29.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit

class DuyuruVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var yazar: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var titleText = ""
    var descText = ""
    var yazarText = ""
    var dateText = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = titleText
        desc.text = descText
        yazar.text = yazarText
        date.text = dateText
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
