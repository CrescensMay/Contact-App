//
//  ContactListController.swift
//  Contacts
//
//  Created by Mac on 10/10/2017.
//  Copyright © 2017 Smart Soft. All rights reserved.
//

import UIKit

// MARK: Sorting

extension Contact {
    var firstLetterForSort: String {
        return String(firstName.characters.first!).uppercased()
    }
}

extension ContactsSource {
    static var sortedUniqueFirstLetter: [String] {
        let firstLetters = contacts.map {
            $0.firstLetterForSort
        }
        let uniqueFirstLetters = Set(firstLetters)
        
        return Array(firstLetters).sorted()
    }
    
    static var sectionContacts: [[Contact]] {
        let sections = sortedUniqueFirstLetter.map {
            firstLetter in let filteredContacts = contacts.filter {
                $0.firstLetterForSort == firstLetter
            }
            return filteredContacts.sorted(by: {$0.firstName < $1.firstName})
        }
    }
}

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
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showContact" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let contact = contacts[indexPath.row]
                
                guard let navigationController = segue.destination as? UINavigationController, let contactDetailController = navigationController.topViewController as? ContactDetailController
                    else { return }
                
                contactDetailController.contact = contact
            }
        }
    }

}
