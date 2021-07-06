//
//  ConversationCell.swift
//  FireChat
//
//  Created by Kato Drake Smith on 06/07/2021.
//

import UIKit
import SDWebImage

class ConversationCell: UITableViewCell {

    //MARK:- properties
    var conversation: Conversation? {
        didSet { configure()}
    }
    
    private let profileImageView : UIImageView = {
      let iv = UIImageView()
      iv.backgroundColor = .systemRed
      iv.contentMode = .scaleAspectFill
      iv.clipsToBounds = true
      return iv
    }()
    
    private let timestampLabel : UILabel = {
      let label = UILabel()
      label.font = UIFont.boldSystemFont(ofSize: 12)
      label.textColor = .lightGray
      return label
    }()
    
    private let usernameLabel : UILabel = {
      let label = UILabel()
      label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
      return label
    }()
    
    private let messageTextLabel : UILabel = {
      let label = UILabel()
      label.font = UIFont.boldSystemFont(ofSize: 14)
      label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
      return label
    }()
    
    
    //MARK:- Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor, paddingLeft: 12, width: 50, height: 50)
        profileImageView.layer.cornerRadius = 50 / 2
        profileImageView.centerY(inView: self)
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, messageTextLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerY(inView: profileImageView)
        stack.anchor(left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 16)
        
        addSubview(timestampLabel)
        timestampLabel.anchor(top: topAnchor, right: rightAnchor, paddingTop: 20, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK:- Helpers
    func configure() {
        guard let conversation = conversation else {return}
        let viewmodel = ConversationViewModel(conversation: conversation)
        timestampLabel.text = "Sent at: \(viewmodel.timestamp)"
        messageTextLabel.text = conversation.message.text
        
        usernameLabel.text = "@\(conversation.user.username.lowercased())"
        
        profileImageView.sd_setImage(with: viewmodel.profileImageUrl)
    }
}
