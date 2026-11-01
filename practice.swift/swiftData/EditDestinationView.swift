//
//  EditDestinationView.swift
//  practice.swift
//
//  Created by Mac mini on 31/10/2026.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
    @Bindable var destination: Destination
    
    @State private var SightString = ""
    var body: some View {
        Form {
            TextField("Destination", text: $destination.name)
            TextField("Details", text: $destination.details)
            DatePicker("Date", selection: $destination.date)
            Picker("Priority", selection: $destination.priority) {
                Text("Meh").tag(1)
                Text("Maybe").tag(2)
                Text("Must").tag(3)
            }
            Section {
                ForEach(destination.sights) { sight in
                    Text(sight.name)
                }
                HStack{
                    TextField("Enter Sight", text: $SightString)
                    Button("Add Sight", action: addSight)
        }
            }
            
        }
        .navigationTitle("EditDestination View")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addSight() {
        guard !SightString.isEmpty else { return }
        
        withAnimation {
            let sight = Sights(name: SightString)
            destination.sights.append(sight)
            SightString  = ""
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "Gilgit", details: "Beautiful mountain city")

        return NavigationStack {
            EditDestinationView(destination: example)
        }
        .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}

