//
//  InfoAboutOwnerViewControllerTableViewController.swift
//  HW 2.10_Network
//
//  Created by Anastasia on 30.08.2022.
//

import UIKit

class InfoAboutOwnerViewController: UITableViewController {
    
    private var owners: [Owner] = []
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        owners.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTV", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let owner = owners[indexPath.row]
        content.text = owner.name
        content.secondaryText = "Age \(owner.age ?? 0)"
        
        cell.contentConfiguration = content
        
        return cell
    }
}

extension InfoAboutOwnerViewController {
    
    func fetchOwner(from url:String?) {
        
        NetworkManager.shared.fetchOwner(from: url) { owner in
            self.owners.append(owner)     // обновили текущую модель как свойство класса
            self.tableView.reloadData()   // перезагружаем методы протокола UITABLEVIEWDATASOURCE
        }
    }
}


