//
//  Firebase.swift
//  iosApp
//
//  Created by Dennis Skokov on 31/05/2019.
//

import app
import Firebase
import FirebaseFirestore

class FirebaseFactory: Factory {
    typealias SuccessHandler = (Any) -> KotlinUnit

    let db = Firestore.firestore()

    func listener(block: @escaping (Any) -> KotlinUnit) -> Removable {
        return FirebaseListener(db: db, success: block)
    }
}

class FirebaseListener: Removable {
    var listener: ListenerRegistration?
    init(db: Firestore, success: @escaping (Any) -> KotlinUnit) {
        listener = db.collection("users").addSnapshotListener { snapshot, error in
            if let snapshot = snapshot {
                _ = success(snapshot.documents)
            }

            if let error = error {
                debugPrint("error: \(error)")
            }
        }
    }

    func remove() {
        listener?.remove()
    }
}
