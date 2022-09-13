//
//  ContentView.swift
//  Firestore-demo
//
//  Created by kittawat phuangsombat on 2022/9/11.
//

import SwiftUI
import FirebaseCore

struct ContentView: View {
    
    @ObservedObject var model = ViewModel()
    
    @State var name = ""
    @State var notes = ""
    
    var body: some View {
        VStack {
            List (model.list) { item in
                HStack {
                    Text(item.name)
                    Spacer()
                    
                    //update button
                    Button(action: {
                        
                        //update todp
                        model.updateData(todoToUpdate: item)
                    }, label: {
                        Image(systemName: "pencil")
                    })
                    .buttonStyle(BorderedButtonStyle())
                    
                    //delete button
                    Button(action: {
                        
                        //Delete todo
                        model.deleteData(todoToDelete: item)
                    }, label: {
                        Image(systemName: "minus.circle")
                    })
                    .buttonStyle(BorderedButtonStyle())
                }
            }
            Divider()
            
            VStack(spacing: 5){
                TextField("name", text: $name)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Notes", text: $notes)
                    .textFieldStyle(.roundedBorder)
                Button(action: {
                    
                    //call add data
                    model.addData(name: name, notes: notes)
                    //clear the text fields
                    name = ""
                    notes = ""
                    
                    
                }, label: {
                    Text("Add Todo Item")
                })
            }
            .padding()
        }
    }
    
    init() {
        model.getData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
