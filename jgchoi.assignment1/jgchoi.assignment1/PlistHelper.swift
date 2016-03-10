//
//  PlistHelper.swift
//  jgchoi.assignment1
//
//  Created by Jung Geon Choi on 2016. 3. 10..
//  Copyright © 2016년 Jung Geon Choi. All rights reserved.
//

import Foundation

class PListHelper {
    static var path:String = ""
    
    
    //Load OR Write plist
    static func loadPlist( ) -> NSArray {
        var data = NSArray( )
        
        // attempt to open "authors.plist" from the application's Documents/ directory
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        path = documentsDirectory.stringByAppendingPathComponent("authors.plist")
        
        let fileManager = NSFileManager.defaultManager( )
        // if the file is not available (first access), then open it from the app's
        // mainBundle Resources/ folder:
        
        if(!fileManager.fileExistsAtPath(path)) {
            let plistPath = NSBundle.mainBundle( ).pathForResource("authors", ofType: "plist")
            
            data = NSArray(contentsOfFile: plistPath!)!
            
            do {
                try fileManager.copyItemAtPath(plistPath!, toPath: path)
            } catch let error as NSError {
                // failure
                print("Error copying plist file: \(error.localizedDescription)")
            }
            print("First launch... Default plist file copied...")
            data.writeToFile(path, atomically: true)
        }
        else {
            data = NSArray(contentsOfFile: path)!
        }
        return data
    }
    
    static func loadMutablePlist() -> NSMutableArray{
        return NSMutableArray(array:self.loadPlist())
    }
    
    
    static func writeToFile(authors:NSMutableArray){
        authors.writeToFile(self.path, atomically: true)
    }

    
}