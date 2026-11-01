//
//  DestinationListingView.swift
//  practice.swift
//
//  Created by Mac mini on 31/10/2026.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
    @Environment(\.modelContext) private var context
    @Query(sort:[SortDescriptor(\Destination.priority,order: .reverse),SortDescriptor(\Destination.name)]) var destinations : [Destination]
    var body: some View {
        List {
           
            ForEach(destinations) {destination in
                NavigationLink(value: destination) {
                    
                    VStack {
                        Text(destination.name)
                        
                        Text (destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }.onDelete(perform: deleteDes )
        }
    }
    
    init(sort: SortDescriptor<Destination>,searchString:String) {
        _destinations = Query(filter: #Predicate{
            if searchString.isEmpty {
                return true
            }else {
                return $0.name.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    func deleteDes(indesSet: IndexSet) {
        
        for index in indesSet {
            let destination = destinations[index]
            context.delete(destination)
            
        }
        
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name),searchString: "")
}
