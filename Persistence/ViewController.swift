//
//  ViewController.swift
//  Persistence
//
//  Created by LAURA LUCRECIA SANCHEZ PADILLA on 14/10/15.
//  Copyright © 2015 LAURA LUCRECIA SANCHEZ PADILLA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lineFields: [UITextField]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let filePath = self.dataFilePath()
        if (NSFileManager.defaultManager().fileExistsAtPath(filePath)){
            let array = NSArray(contentsOfFile: filePath) as! [String]
            for var i = 0; i < array.count; i++ {
                lineFields[i].text = array[i]
            }
        }
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:", name: UIApplicationWillResignActiveNotification, object: app)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataFilePath() -> String{
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = paths[0] as NSString
        print(documentsDirectory.stringByAppendingPathComponent("data.plist") as String)
        return documentsDirectory.stringByAppendingPathComponent("data.plist") as String
    }
    
    func applicationWillResignActive(notification: NSNotification){
        let filePath = self.dataFilePath()
        print(filePath)
        let array = (self.lineFields as NSArray).valueForKey("text") as! NSArray
        array.writeToFile(filePath, atomically: true)
    }
}

