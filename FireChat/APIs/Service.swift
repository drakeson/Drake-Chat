//
//  Service.swift
//  FireChat
//
//  Created by Kato Drake Smith on 01/07/2021.
//

import Foundation
import Firebase


struct Service {
    static func fetchUsers(completion : @escaping([User]) -> Void){
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                let user = User(dictionary: document.data())
                users.append(user)
                completion(users)
            })
        }
    }
}
