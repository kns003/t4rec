//
//  T4DataImportStatusDelegate.swift
//  T4Rec
//
//  Created by Radhakrishnan Selvaraj on 25/07/15.
//  Copyright (c) 2015 Dev Krishnan. All rights reserved.
//

import Foundation


@objc public protocol T4DataImportStatusDelegate:NSObjectProtocol
{
  @objc func importOperationCompleted(operation:T4DataImportOperation,importOperationType:T4WebAPIType);
  @objc func importOperationCancelled(operation:T4DataImportOperation,importOperationType:T4WebAPIType);
  @objc func importOperationFailed(operation:T4DataImportOperation,importOperationType:T4WebAPIType,withError:NSError);
}
