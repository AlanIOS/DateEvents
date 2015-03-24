//
//  ViewController.swift
//  DateEvents
//
//  Created by alan on 3/23/15.
//  Copyright (c) 2015 LawlLawLawl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var parsedArray : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GetWikiData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func GetWikiData()
    {
        let urlPath: String = "http://en.wikipedia.org/w/api.php?action=query&explaintext=&prop=extracts&format=json&titles=2014"
        var url: NSURL = NSURL(string: urlPath)!
        var request1: NSURLRequest = NSURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?
        >=nil
        var error: NSErrorPointer = nil
        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request1, returningResponse: response, error:nil)!
        var err: NSError
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        let extract = jsonResult.valueForKeyPath("query.pages.48630.extract") as String
        let startOfEventsIndex = extract.rangeOfString("== §Events ==")
        let endOfEventsIndex = extract.rangeOfString("== §Births ==")
        //var cleanExtract = extract.stringByReplacingOccurrencesOfString("<li>", withString: "")
        //cleanExtract = extract.stringByReplacingOccurrencesOfString("</li>", withString: "")
        
        let range = Range<String.Index>(start: startOfEventsIndex!.endIndex as String.Index, end: endOfEventsIndex!.startIndex as String.Index)
        let eventsSection = extract.substringWithRange(range);
        let splitExtract = split(eventsSection) {$0 == "\n"}
//        for line in splitExtract {
//            println(line)
//        }
        parsedArray = formatEventsIntoArray(splitExtract)
    }
    
    private func formatEventsIntoArray(eventsList : [String]) -> [String]
    {
        return removeMonthHeaders(eventsList)
    }
    
    private func removeMonthHeaders(eventArray : [String]) -> [String]
    {
        var cleanedArray : [String] = []
        for line in eventArray
        {
            if (line.rangeOfString("§") == nil )
            {
                let eventWithYear = "2014 " + line
                cleanedArray.append(eventWithYear);
            }
        }
        return cleanedArray
    }
    
    private func findEventByDate(date : String) -> String?
    {
        if parsedArray != nil
        {
            return nil
        }
        let endIndex = parsedArray?.count
        for line : String in parsedArray!
        {
            if let range = line.rangeOfString(date)
            {
                return line
            }
        }
        return nil
    }
}

