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
  @objc public var mainManagedObjectContext : NSManagedObjectContext?
  @objc override public init()
  {
    
    
    self.mainManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
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
}

