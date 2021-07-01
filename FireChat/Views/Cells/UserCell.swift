//
//  UserCell.swift
//  FireChat
//
//  Created by Kato Drake Smith on 01/07/2021.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell {
    
    //MARK: - Property
      var user : User? {
        didSet {
         configure()
        }
      }
      
      private let profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemRed
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
      }()
      
      private let usernameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 1)
        label.text = "Batman"
        return label
      }()
      
      private let fullnameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "Bruce Wyne"
        return label
      }()
      
      //MARK: - Lifecycle
      
      override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        profileImageView.setDimensions(height: 56, width: 56)
        profileImageView.layer.cornerRadius = 56 / 2
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stack.axis = .vertical
        stack.spacing = 2
        
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 12)
      }
      
      required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }
      
      //MARK: - Helpers
      func configure() {
        guard let user = user else {return}
        fullnameLabel.text = "Email: \(user.email)"
        usernameLabel.text = "@\(user.username)"
        
        guard let url = URL(string: user.profileImageUrl) else {return}
        profileImageView.sd_setImage(with: url)
      }

}
