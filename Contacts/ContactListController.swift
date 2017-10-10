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
    
    // MARK: 
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

}
