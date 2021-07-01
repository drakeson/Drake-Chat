//
//  AuthService.swift
//  FireChat
//
//  Created by Dr.Drake 007 on 10/04/2021.
//

import Firebase
import UIKit

struct RegistrationCredentials {
    let name: String
    let email: String
    let password: String
    let profileImage: UIImage
    
}

struct AuthService {
    
    static let shared = AuthService()
    
    func logUser(withEmail email: String, password: String, completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func createUser(credentials: RegistrationCredentials, completion: ((Error?) -> Void)?){
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else {return}
        
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/image/\(fileName).png")
        ref.putData(imageData, metadata: nil){ (meta, error) in
            if let error = error {
                completion!(error)
                print("Erroe: \(error.localizedDescription)")
            }
            ref.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else {return}
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                    if let error = error {
                        completion!(error)
                        print("Error: \(error.localizedDescription)")
                        return
                    }
                    guard let uid = result?.user.uid else {return}
                    let data = ["name": credentials.name, "email": credentials.email, "uid": uid, "image": imageUrl ] as [String: Any]
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)

                }
            }
        }
    }
    
}
