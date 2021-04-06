//
//  ConversationsController.swift
//  FireChat
//
//  Created by Dr.Drake 007 on 06/04/2021.
//

import UIKit

private let reuseIdentifer = "ConversationsCell"

class ConversationsController: UIViewController {
    
    
    // MARK: - Properties
    private let tableView = UITableView()
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    // MARK: - Selectors
    @objc func showProfile()  {
        print("dskbdjkb")
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        
        configureNavigationBar()
        configureTableView()
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifer)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.frame = view.frame
         
    }
    
    func configureNavigationBar(){
        let apperance = UINavigationBarAppearance()
        apperance.configureWithOpaqueBackground()
        apperance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        apperance.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 1)
        
        navigationController?.navigationBar.standardAppearance = apperance
        navigationController?.navigationBar.compactAppearance = apperance
        navigationController?.navigationBar.scrollEdgeAppearance = apperance
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Drake Chat"
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationController?.overrideUserInterfaceStyle = .dark
        
    }
    
}
//

extension ConversationsController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.textLabel?.text = "Text Cell: \(1 + indexPath.row)"
        cell.textLabel?.textColor = #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 1)
        return cell
    }
    
    
}
extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(1 + indexPath.row)")
        
    }
}
