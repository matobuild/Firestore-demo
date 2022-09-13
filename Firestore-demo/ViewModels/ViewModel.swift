//
//  ViewModel.swift
//  Firestore-demo
//
//  Created by kittawat phuangsombat on 2022/9/11.
//

import Foundation
import FirebaseFirestore


class ViewModel: ObservableObject {
    
    @Published var list = [Todo]()
    
    func updateData(todoToUpdate: Todo) {
        
        // get a reference to the database
        let db = Firestore.firestore()
        
        //set the data to update
        //if put in merge = true it will not get rid of the old data
        db.collection("todos").document(todoToUpdate.id).setData(["name":"Updated:\(todoToUpdate.name)"], merge: true) { error in
            
            //check for error
            if error == nil {
                //get the new date
                self.getData()
            }
        }
    }
    
    
    func deleteData(todoToDelete: Todo) {
        
        // get a reference to the database
        let db = Firestore.firestore()
        
            //specify the document to delete
        db.collection("todos").document(todoToDelete.id).delete { error in
            
            //check for error
            if error == nil {
                // no error
                
                // Update the UI from the main thread
                DispatchQueue.main.async {
                    
                    // remove the the todo that was just delete
                    
                    self.list.removeAll { todo in
                        //check for the todo to remove
                        return todo.id == todoToDelete.id
                }
       
                    
                }
            }
        }
    }
    
    
    func addData(name: String, notes: String) {
        
        // get a reference to the database
        let db = Firestore.firestore()
        
        //add a document to a collection
        db.collection("todos").addDocument(data: ["name": name, "notes": notes]) { error in
            
            
            //check for errors
            if error == nil {
                //no errors
                
                //call get data to retrive latest data
                self.getData()
            }
            else {
                //handle the error
            }
            
        }
    }
    
    func getData() {
        
        //         get a reference to the data base
        let db = Firestore.firestore()
        
        // Read the documents at a specific path
        db.collection("todos").getDocuments { snapshot, error in
          
//        db.collection("todos").getDocument { snapshot, error in
            
            // check for errors
            if error == nil {
                // no errors
                
                if let snapshot = snapshot {
                    
                    //update the list property in the main thread
                    DispatchQueue.main.async {
                        
                        // get all the documents and creaate Todos
                        self.list = snapshot.documents.map { d in
                            
                            //create a todo item for each documents return
                            return Todo(id: d.documentID,
                                        name: d["name"] as? String ?? "",
                                        notes: d["notes"] as? String ?? "")
                        }
                    }
                   
                }
            }
            else {
                
            }
        }
    }
}
