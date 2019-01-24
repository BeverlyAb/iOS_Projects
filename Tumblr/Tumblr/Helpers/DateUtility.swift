//
//  DateUtility.swift
//  Tumblr
//
//  Created by Beverly Abadines on 1/24/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import Foundation

struct DateUtil {
    
    // Formats a timestamp from the API and converts it to MMM d, h:mm a
    static func formatPostTime(to format: String, from timeStamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    
}
