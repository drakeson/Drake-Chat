//
//  MessageCell.swift
//  FireChat
//
//  Created by Kato Drake Smith on 06/07/2021.
//

import UIKit
import SDWebImage

class MessageCell : UICollectionViewCell {
  //MARK: - Properties
  
  var message : Message? {
    didSet {
      configure()
    }
  }
  
  var bubbleLeftAnchor : NSLayoutConstraint!
  var bubbleRightAnchor : NSLayoutConstraint!
  
  private let profileImageView : UIImageView  = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    return iv
  }()
  
  private let textView : UITextView = {
    let tv = UITextView()
    tv.backgroundColor = .clear
    tv.font = .systemFont(ofSize: 16)
    tv.isScrollEnabled = false
    tv.isEditable = false
    tv.isSelectable = true
    tv.textColor = .white
    return tv
  }()
  
  private let bubbleContainer : UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    return view
  }()
  
  //MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(profileImageView)
    profileImageView.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 8, paddingBottom: 4, width: 35, height: 35)
    profileImageView.layer.cornerRadius = 32 / 2

    addSubview(bubbleContainer)
    bubbleContainer.layer.cornerRadius = 10
    bubbleContainer.anchor(top: topAnchor)
    bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
    
    bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
    bubbleLeftAnchor.isActive = false
    bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
    bubbleRightAnchor.isActive = false
    
    bubbleContainer.addSubview(textView)
    textView.anchor(top: bubbleContainer.topAnchor, left: bubbleContainer.leftAnchor, bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: -4, paddingRight: 12)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Helpers
  func configure() {
    guard let message = message else {return}
    let viewModel = MessageViewModel(message: message)

    bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
    textView.textColor = viewModel.messageTextColor
    textView.text = message.text

    bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
    bubbleRightAnchor.isActive = viewModel.rightAnchorActive

    profileImageView.isHidden = viewModel.shouldHideProfileImage
    profileImageView.sd_setImage(with: viewModel.profileImageUrl)
  }
  
}
