//
//  ViewControllerExtension.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    func loadNib(name: String) -> UIView
    {
        return Bundle.main.loadNibNamed(name, owner: self, options: nil)?.first as! UIView
    }
}
