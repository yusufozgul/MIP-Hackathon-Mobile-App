//
//  UIScrollView.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView
{
    func scrollToPage(index: Int)
    {
        UIView.animate(withDuration: 0.3) {
            self.contentOffset.x = self.frame.width * CGFloat(index)
        }
    }
}
