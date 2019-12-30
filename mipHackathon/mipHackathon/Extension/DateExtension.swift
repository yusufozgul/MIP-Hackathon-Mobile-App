//
//  DateExtension.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation

extension Date
{
    func addCurrentDate(value: Int, byAdding: String) -> Date
    {
        var dateComponent = DateComponents()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "dd/MMMM/yyyy"
        
        switch byAdding {
        case "month":
            dateComponent.month = value
        case "week":
            dateComponent.day = value
        case "day":
            dateComponent.day = value
        case "year":
            dateComponent.year = value
        default:
            print("Date component error")
        }
        let dateAdding = Calendar.current.date(byAdding: dateComponent, to: Date())
        
        let date = dateFormatter.string(from: dateAdding! as Date)
        return dateFormatter.date(from: date)!
    }
}
