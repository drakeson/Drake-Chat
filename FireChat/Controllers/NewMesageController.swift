//
//  NewMesageController.swift
//  FireChat
//
//  Created by Kato Drake Smith on 01/07/2021.
//

import UIKit

private let reuseIdentifier = "userCell"

class NewMesageController: UITableViewController {

    //MARK: - Properties
    private var users = [User]()
    
    //MARK: - Lifesycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
    }
    
    //MARK: - Selectors
    
    @objc func handleDismissal(){
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - API
    func fetchUsers(){
        Service.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        configureNavigationBar(withTitle: "New Message", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
    }
    
    
    
    


}

//MARK:- UITableViewDataSource
extension NewMesageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.user = users[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(1 + indexPath.row)")
        
    }
}
