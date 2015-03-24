//
//  DateProcessor.swift
//  DateEvents
//
//  Created by Matthew Banman on 2015-03-23.
//  Copyright (c) 2015 LawlLawLawl. All rights reserved.
//

import Foundation
import UIKit
import Darwin

class DateProcessor
{
    // returns a formatted date by passing in a percentage
    func getDateFromPercentage( percentage : Double ) -> String
    {
        let calendar : NSCalendar! = NSCalendar(identifier: NSGregorianCalendar)
        let currentDate = NSDate()
        let flags: NSCalendarUnit = .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit
        let currentDateComponents : NSDateComponents = calendar.components(flags, fromDate: currentDate)
        
        // find years, days to subtract from given percentage
        var yearsToSubtract : Double = exp( (20.3444 * pow( 1 - percentage, 3 )) + 3 ) - exp(3)
        var subtractingYear = Int(yearsToSubtract)
        var subtractingDay = Int( 365 * ( yearsToSubtract - Double(subtractingYear) ) )
        
        // subtract years and days!
        let intermediateDateComponents = NSDateComponents()
        var finalYear = currentDateComponents.year - subtractingYear
        intermediateDateComponents.year = finalYear
        intermediateDateComponents.day = subtractingDay
        
        // get final components
        var finalDate : NSDate! = calendar.dateByAddingComponents(intermediateDateComponents, toDate: currentDate, options: nil)
        let finalDateComponents : NSDateComponents = calendar.components(flags, fromDate: finalDate)
        let finalMonth = getMonthString(finalDateComponents.month)
        
        // return properly formatted string for searching through events
        return "\(finalYear) \(finalMonth) \(finalDateComponents.day)"
    }
    
    // returns a month's name as a string from its number representation
    func getMonthString(month : Int) -> String
    {
        switch month
        {
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
        default:
            return "ERROR PARSING MONTH"
        }
    }
};
