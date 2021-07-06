//
//  MessageViewModel.swift
//  FireChat
//
//  Created by Kato Drake Smith on 06/07/2021.
//

import Foundation
import UIKit

struct MessageViewModel {
  
  private let message: Message
  
  var messageBackgroundColor: UIColor {
    return message.isFromCurrentUser ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
  }
  
  var messageTextColor: UIColor {
    return message.isFromCurrentUser ? .black : .white
  }
  
  var rightAnchorActive: Bool {
    return message.isFromCurrentUser
  }
  
  var leftAnchorActive: Bool {
    return !message.isFromCurrentUser
  }
  
  var shouldHideProfileImage: Bool {
    return message.isFromCurrentUser
  }
  
  var profileImageUrl: URL? {
    guard let user = message.user else {return nil}
    return URL(string: user.profileImageUrl)
  }
  
  init(message: Message) {
    self.message = message
  }
}
