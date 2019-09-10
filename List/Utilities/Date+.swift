//
//  Date+.swift
//  List
//
//  Created by Xiaoheng Pan on 9/10/19.
//  Copyright © 2019 Xiaoheng Pan. All rights reserved.
//

import Foundation

extension Date {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return dateFormatter.string(from: self)
    }

    func convertToStringWithDetail() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"

        let date = dateFormatter.string(from: self)
        let time = timeFormatter.string(from: self)
        return "\(date) at \(time)"
    }
}
