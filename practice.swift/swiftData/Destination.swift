//
//  Destination.swift
//  practice.swift
//
//  Created by Mac mini on 27/10/2026.
//

import Foundation
import SwiftData

/*
 This macro (@model) taht tells swift data we want to be able to load and save destination
 object inside its permenant storage and that adds a whole bunch of functionality behind the scenes so
 swift data can detect or we add destinations modefy thenm and so for see whats happening here and making sure they automatically get saved behind the senes.but also done very clever things like loading and saving data lazily behind the secenes
 */
@Model
class Destination {
    var name: String
    var details: String
    var date : Date
    var priority: Int
    
    init(name: String = "", details: String = "", date: Date = .now, priority: Int = 2) {
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
    }
}
