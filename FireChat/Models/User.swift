//
//  User.swift
//  FireChat
//
//  Created by Kato Drake Smith on 01/07/2021.
//

import Foundation

struct User {
  let uid: String
  let profileImageUrl: String
  let username: String
  let email: String
  
  init(dictionary : [String : Any]) {
    self.uid = dictionary["uid"] as? String ?? ""
    self.profileImageUrl = dictionary["image"] as? String ?? ""
    self.username = dictionary["name"] as? String ?? ""
    self.email = dictionary["email"] as? String ?? ""
  }
}
