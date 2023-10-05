//
//  Item.swift
//  ObjectClassifier
//
//  Created by Andrew Althage on 10/5/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}