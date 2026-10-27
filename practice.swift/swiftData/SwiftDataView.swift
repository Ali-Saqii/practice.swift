//
//  SwiftDataView.swift
//  practice.swift
//
//  Created by Mac mini on 27/10/2026.
//

import SwiftUI
import SwiftData



struct SwiftDataView: View {
    @Query var destinations : [Destination]
    @Environment(\.modelContext) private var context

    // here this ( @Query ) loads all destinations when this view shows on the screen it also watches data base for changes
    var body: some View {
        NavigationStack {
            List {
                ForEach(destinations) {destination in
                    VStack {
                        Text(destination.name)
                        
                        Text (destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }.toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button ("add samples" , action: addSamples)
                }
            }
        }.navigationTitle("iTour")
    }
    
    func addSamples() {
        let rome = Destination(name: "Rome")
        let gilgit = Destination(name: "Gilgit")
        let skardu = Destination(name: "skardu")
        let berlin = Destination(name: "berlin")
        context.insert(rome)
        context.insert(gilgit)
        context.insert(skardu)
        context.insert(berlin)


    }
}


// MARK: - ModelContext Notes


// ModelContext = scratchpad; save() par hi disk par jata hai.
// insert() zaroori hai, warna object persist nahi hota.
// Thread-safe nahi: background par @ModelActor, objects ki jagah PersistentIdentifier pass karo.
// Important writes par explicit try context.save(), try? nahi.
// Production mein context sirf Repository layer ko pata hona chahiye.

//
// WHAT
// - ModelContext = working area (scratchpad) between code and database.
// - Har @Model object kisi ek context ke andar live karta hai.
// - Git analogy: Container = repo, Context = staging area, save() = commit.
//
// WHY
// - Changes pehle memory mein track hoti hain, phir ek saath disk par save hoti hain.
// - Batching, change tracking, identity management (same row = same instance).
//
// CORE OPERATIONS
// - context.insert(obj)        -> tracking start (bina insert ke object persist nahi hota)
// - obj.property = value       -> change auto-tracked
// - context.delete(obj)        -> delete mark
// - context.fetch(descriptor)  -> one-shot fetch (live updates ke liye @Query)
// - context.save()             -> disk par write
// - context.rollback()         -> unsaved changes discard
// - context.hasChanges         -> unsaved changes check
//
// CONTAINER vs CONTEXT
// - ModelContainer = schema + storage (app mein ek).
// - ModelContext   = independent scratchpad (kai ho sakte hain).
// - .modelContainer(for:) main context ko environment mein inject karta hai.
// - @Environment(\.modelContext) aur @Query dono same main context use karte hain.
//
// RULES (common mistakes)
// 1. ModelContext thread-safe nahi hai -> background work ke liye @ModelActor.
// 2. @Model objects contexts ke beech pass nahi karna -> PersistentIdentifier pass karo.
// 3. Autosave par depend nahi karna -> important data ke liye explicit try context.save().
// 4. try? se save mat karo -> errors silently swallow ho jate hain. do/catch use karo.
// 5. Views mein context calls scatter nahi karna -> bare apps mein Repository ke peeche rakho.
//
// PATTERNS
// - Edit form with Cancel: alag ModelContext(container) banao, autosaveEnabled = false,
//   Save par scratch.save(), Cancel par discard.
// - Production: View -> ViewModel -> Repository (protocol) -> ModelContext.
// - Tests: ModelConfiguration(isStoredInMemoryOnly: true).
#Preview {
    SwiftDataView()
}
