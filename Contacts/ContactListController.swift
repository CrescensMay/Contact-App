//
//  ContactListController.swift
//  Contacts
//
//  Created by Mac on 10/10/2017.
//  Copyright © 2017 Smart Soft. All rights reserved.
//

import UIKit

class ContactListController: UITableViewController {
    
    //getting some data
    var contacts = ContactsSource.contacts

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = contact.firstName
        cell.imageView?.image = contact.image
        cell.detailTextLabel?.text = contact.lastName
        
        return cell
    }

}
