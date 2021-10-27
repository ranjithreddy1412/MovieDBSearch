//
//  Date+Extensions.swift
//  MovieBrowser
//
//  Created by Ranjith on 10/18/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

extension Date {
    func toString(format: String = "dd/mm/YYYY") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
