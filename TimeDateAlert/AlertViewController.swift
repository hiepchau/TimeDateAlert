//
//  AlertViewController.swift
//  TimeDateAlert
//
//  Created by Châu Hiệp on 30/11/2022.
//

import UIKit

class AlertViewController: UIViewController, UITableViewDataSource {
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var items = [String]()
    
    private let floatingButton: UIButton = {
        let floatingButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        floatingButton.layer.masksToBounds = true
        floatingButton.layer.cornerRadius = 30
//        floatingButton.backgroundColor = .systemPink
        let image = UIImage(named: "logo")
        floatingButton.setImage(image, for: .normal)
        return floatingButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize
        title = "Alert in todo app"
        self.items = UserDefaults.standard.stringArray(forKey: "items") ?? []
        view.addSubview(table)
        view.addSubview(floatingButton)
        table.dataSource = self
        
        //action
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapClear))
        floatingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    //Navigation action
    @objc private func didTapClear(){
        let alert = UIAlertController(title: "Clear list", message: "Do you want to empty list ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yessssss", style: .default, handler: {[weak self] (_) in
            if let items = self?.items, !items.isEmpty{
                DispatchQueue.main.async {
                    var currentItems = UserDefaults.standard.stringArray(forKey: "items") ?? []
                    currentItems.removeAll()
                    UserDefaults.standard.setValue(currentItems, forKey:  "items")
                    self?.items.removeAll()
                    self?.table.reloadData()
                }
            }
        }))
        present(alert, animated: true)
    }
    
    @objc private func didTapAdd(){
        let alert = UIAlertController(title: "New Item", message: "Enter new to do list item", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Enter item..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: {[weak self] (_) in
            if let field = alert.textFields?.first{
                if let text = field.text, !text.isEmpty{
                    
                    //Enter new to do list item
                    DispatchQueue.main.async{
                        var currentItems = UserDefaults.standard.stringArray(forKey: "items") ?? []
                        currentItems.append(text)
                        UserDefaults.standard.setValue(currentItems, forKey:  "items")
                        self?.items.append(text)
                        self?.table.reloadData()
                    }

                }
            }
                                      }))
        present(alert, animated: true)
    }
    
    //Button action
    @objc private func didTapButton(){
        let alert = UIAlertController(title: "Welcome!!", message: "Beetech hello.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

    
    //Define view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width - 100
                                      , y: view.frame.size.height - 200
                                      , width: 60
                                      , height: 60)
        table.frame = view.bounds
    }
}
