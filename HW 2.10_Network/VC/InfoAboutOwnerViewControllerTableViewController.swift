//
//  InfoAboutOwnerViewControllerTableViewController.swift
//  HW 2.10_Network
//
//  Created by Anastasia on 30.08.2022.
//

import UIKit

class InfoAboutOwnerViewController: UITableViewController {
    
    private var owners: [Owner] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchOwner()
    }
    

    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        owners.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTV", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let owner = owners[indexPath.row]
        content.text = owner.name
        content.secondaryText = "\(owner.age)" 
        
        cell.contentConfiguration = content
        
        return cell
    }
    
   
}

extension InfoAboutOwnerViewController {
     func fetchOwner() {
        
        // создаем URL - адрес
        guard let url = URL(string: Link.ownerURL.rawValue) else {return}
        
        // создаем URL сессию
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error")
                return
            }
            
            do {
                let owner = try JSONDecoder().decode(Owner.self, from: data)
                DispatchQueue.main.async {
                    self.owners.append(owner)
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        } .resume() // !!!!НЕ ЗАБЫВАТЬ ПРО resume, иначе ничего не сработает
        
    }
}

 
