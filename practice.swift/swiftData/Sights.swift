//
//  Sights.swift
//  practice.swift
//
//  Created by Mac mini on 01/11/2026.
//

import Foundation
import SwiftData

@Model
class Sights {
    var name : String
    
    init(name: String) {
        self.name = name
    }
}


// SwiftData Relationships
// Types: One-to-One, One-to-Many, Many-to-Many (+ unidirectional/bidirectional via inverse).
// @Relationship(deleteRule:, inverse:) macro use hota hai.
//
// deleteRule:
//   .nullify  (default) -> child bachta hai, reference nil
//   .cascade            -> parent delete = children delete
//   .deny               -> children hon to delete block
//   .noAction           -> avoid
//
// Rules:
// - inverse hamesha define karo (dono sides sync rehti hain).
// - To-one side optional rakho (var destination: Destination?).
// - To-many side default = [] rakho.
// - Many-to-many mein .cascade mat lagao, .nullify use karo.
// - Same ModelContext ke objects hi relate karo.
// - CloudKit: saari relationships optional.
// - Relationship lazy load hoti hai (faulting).


// @Relationship macro optional hai:
// - Bina macro ke bhi relationship banti hai (type se detect hoti hai).
// - Defaults: deleteRule = .nullify (parent delete -> children bachte hain, orphan ban jate hain).
// - inverse auto-guess hota hai, lekin ambiguous case (ek type ki taraf 2 relationships) mein fail.
// - Macro zaroori: .cascade/.deny, multiple relationships same type ki taraf, explicit inverse.
// - Production mein hamesha explicit likho: delete behavior business decision hai.
