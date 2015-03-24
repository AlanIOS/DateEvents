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
        intermediateDateComponents.day = currentDateComponents.day - subtractingDay
        
        // get final components
        var finalDate : NSDate! = NSCalendar().dateByAddingComponents(intermediateDateComponents, toDate: currentDate, options: nil)
        let finalDateComponents : NSDateComponents = calendar.components(flags, fromDate: finalDate)
        
        // build a date from calculated years
        //var dateToSubtract : NSDate = (calendar?.dateFromComponents(finalDateComponents))!

        // subtract calculated date from today
        //let newDate : NSDate = (calendar?.dateByAddingComponents(components, toDate: currentDate, options: nil))!
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = .NoStyle
        
        //return formatter.string
        return "\(finalYear) \(finalDateComponents.month) \(finalDateComponents.day)"
    }
    
    // use nsdateformatter to format date for searching array
    
};
