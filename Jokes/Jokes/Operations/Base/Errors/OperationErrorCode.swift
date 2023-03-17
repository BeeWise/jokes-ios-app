//
//  OperationErrorCode.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 16.03.2023.
//

import Foundation

public enum OperationErrorCode: Int {
    case inexistentJoke = 600
    case invalidOrderBy = 601
    case emptyText = 602
    case invalidText = 603
    case emptySource = 604
    case invalidSource = 605
    case invalidStatus = 606
    case invalidStartedAt = 607
    case invalidEndedAt = 608
    case wrongOwner = 609
    case emptyStatus = 610
}
