//
//  T4DownloadOperationDelegate.swift
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 25/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

import Foundation

@objc public protocol T4DownloadOperationDelegate:NSObjectProtocol
{
  @objc func downloadOperationWillComplete(operation:NSOperation,type:T4WebAPIType);
  @objc func downloadOperationCompleted(operation:NSOperation,type:T4WebAPIType);
  @objc func downloadOperationCancelled(operation:NSOperation,type:T4WebAPIType);
}