//
//  T4DataStotr.swift
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 25/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

import Foundation
import CoreData
import UIKit
@objc public class  T4DataStore: NSObject,UIAlertViewDelegate {

  @objc override public init()
  {
    
    
  
    super.init()
    self.setUpSaveNotification()
    
    
    return
  }

  func setUpSaveNotification()
  {
    
    let completionBlock :(NSNotification!)->Void = {(note) in
      
      var managedObjectContext :NSManagedObjectContext = self.mainManagedObjectContext!
      var notificationMOC = note.object as? NSManagedObjectContext
      if (notificationMOC != managedObjectContext)
      {
        managedObjectContext.performBlock({
          managedObjectContext.mergeChangesFromContextDidSaveNotification(note)
        })
      }
    }
    var defaultCenter = NSNotificationCenter.defaultCenter()
    defaultCenter.addObserverForName(NSManagedObjectContextDidSaveNotification, object: nil, queue: nil, usingBlock: completionBlock)
    
  }
  public func saveContext()
  {
    var error : NSError?
    var managedObjectContext = mainManagedObjectContext
    
    if managedObjectContext != nil
    {
      if (managedObjectContext?.hasChanges == true && managedObjectContext?.save(&error) == false)
      {
        showAlert()
      }
    }
    
  }
  func showAlert()
  {
    var saveAlertView  = UIAlertView(title: "Could not save data", message: "There was a problem saving your data but it is not your fault. If you restart the app, you can try again. Please contact support (support@agile3solutions.com) to notify us of this issue.", delegate: self, cancelButtonTitle: nil);
    saveAlertView.show()
    
  }
  public func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int)
  {
    abort()
  }
  @objc public func importingManagedObjectContext()->NSManagedObjectContext
  {
    var privateMOC = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
    privateMOC.persistentStoreCoordinator = mainManagedObjectContext?.persistentStoreCoordinator
    privateMOC.undoManager = nil
    return privateMOC
  }
  
  // MARK: - Core Data stack
  
  lazy var applicationDocumentsDirectory: NSURL = {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.t3.tempTesting" in the application's documents Application Support directory.
    let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    return urls[urls.count-1] as! NSURL
    }()
  
  lazy var managedObjectModel: NSManagedObjectModel = {
    // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
    let modelURL = NSBundle.mainBundle().URLForResource("T4Recommendations", withExtension: "momd")!
    return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
  
  lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
    // Create the coordinator and store
    var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("T4Recommendations.sqlite")
    var error: NSError? = nil
    var failureReason = "There was an error creating or loading the application's saved data."
    if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
      coordinator = nil
      // Report any error we got.
      var dict = [String: AnyObject]()
      dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
      dict[NSLocalizedFailureReasonErrorKey] = failureReason
      dict[NSUnderlyingErrorKey] = error
      error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
      // Replace this with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog("Unresolved error \(error), \(error!.userInfo)")
      abort()
    }
    
    return coordinator
    }()
  
  @objc public lazy var mainManagedObjectContext: NSManagedObjectContext? = {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
    let coordinator = self.persistentStoreCoordinator
    if coordinator == nil {
      return nil
    }
    var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = coordinator
    return managedObjectContext
    }()
  
  // MARK: - Core Data Saving support
  
  
  
}

