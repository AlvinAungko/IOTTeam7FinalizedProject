//
//  FirebaseDataManager.swift
//  FoodDetectApp
//
//  Created by Alvin  on 23/05/2023.
//

import Foundation
import FirebaseCore
import FirebaseDatabase


class FirebaseDataManager {
    
    static let shared = FirebaseDataManager()
    var ref: DatabaseReference = Database.database().reference()
    
    private init() {}
    
    func getFirebaseValue(pathName: String, completion: @escaping(Int) -> Void) {
        let directory = ref.child(pathName)
        directory.observe(.value) { snapshot in
            if let value = snapshot.value as? Int {
                completion(value)
            }
        }
    }
    
}

