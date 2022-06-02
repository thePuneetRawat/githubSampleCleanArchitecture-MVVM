//
//  Date.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 07/05/22.
//

import Foundation

class DateUtil {
    
    static let shared = DateUtil()
    func convertDateString(from inputFormat: String, to outputFormat: String, dateStr: String) -> String? {
        return getStringFromDate(withFormat: outputFormat, date:getDateFromString(withFormat: inputFormat, strDate: dateStr) )
    }
    
    func getDateFromString(withFormat strFormat: String, strDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strFormat
        dateFormatter.timeZone = TimeZone.ReferenceType.system
        return dateFormatter.date(from: strDate)
    }
    
    func getStringFromDate(withFormat strFormat: String, date: Date?) -> String? {
        guard let date = date else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strFormat
        dateFormatter.timeZone = TimeZone.ReferenceType.system
        return dateFormatter.string(from: date)
    }
}
