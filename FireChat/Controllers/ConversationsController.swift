//
//  ConversationsController.swift
//  FireChat
//
//  Created by Dr.Drake 007 on 06/04/2021.
//

import UIKit
import Firebase

private let reuseIdentifier = "ConversationsCell"

class ConversationsController: UIViewController {
    
    
    // MARK: - Properties
    private let tableView = UITableView()
    
    
    private let newMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.imageView?.setDimensions(height: 24, width: 24)
        button.addTarget(self, action: #selector(showNewMesageController), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    // MARK: - Selectors
    @objc func showProfile()  {
        logOut()
    }
    
    
    @objc func showNewMesageController(){
        let nav = UINavigationController(rootViewController: NewMesageController())
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    // MARK: - API
    func authenticateUser(){
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        } else {
            print("User ID: \(String(describing: Auth.auth().currentUser?.uid))")
        }
    }
    
    func logOut() {
        showLoader(true, withText: "Signing Out")
        do {
            try Auth.auth().signOut()
            showLoader(false)
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginVC())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } catch {
            showLoader(false)
            print("Signing Out")
        }
        
    }
    
    // MARK: - Helpers
    
    func presentLoginScreen(){
        DispatchQueue.main.async {
            let nav = UINavigationController(rootViewController: LoginVC())
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    func configureUI(){
        view.backgroundColor = .white
        
        configureNavigationBar(withTitle: "Drake Chat", prefersLargeTitles: true)
        configureTableView()
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        authenticateUser()
        
        
        view.addSubview(newMessageButton)
        newMessageButton.layer.cornerRadius = 56 / 2
        newMessageButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingBottom: 16, paddingRight: 24, width: 56, height: 56)
    }
    
    func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.rowHeight = 80
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.frame = view.frame
         
    }
    
    
    
}

//MARK:- UITableViewDataSource

extension ConversationsController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        return cell
    }
    
    
}
extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(1 + indexPath.row)")
        
    }
}
