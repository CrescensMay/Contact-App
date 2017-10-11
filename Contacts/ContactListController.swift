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
        
        return Array(uniqueFirstLetters).sorted()
    }
    
    static var sectionContacts: [[Contact]] {
        return sortedUniqueFirstLetter.map {
            firstLetter in let filteredContacts = contacts.filter {
                $0.firstLetterForSort == firstLetter
            }
            return filteredContacts.sorted(by: {$0.firstName < $1.firstName})
        }
    }
}

class ContactListController: UITableViewController {
    
    let dataSource = ContactsDataSource(sectionedData: ContactsSource.sectionContacts, sectionTitles: ContactsSource.sortedUniqueFirstLetter)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
    

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showContact" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let contact = dataSource.object(at: indexPath)
//                let contact = contacts[indexPath.row]
                
                guard let navigationController = segue.destination as? UINavigationController, let contactDetailController = navigationController.topViewController as? ContactDetailController
                    else { return }
                
                contactDetailController.contact = contact
                contactDetailController.delegate = self
            }
        }
    }

}
extension Contact: Equatable {
    static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.street == rhs.street && lhs.city == rhs.city && lhs.state == rhs.state && lhs.zip == rhs.zip && lhs.phone == rhs.phone && lhs.email == rhs.email
    }
}

extension ContactListController: contactDetailControllerDelegate {
    func didMarkAsFavoriteContact(_ contact: Contact) {
        guard let indexPath = dataSource.indexPath(for: contact) else {
            return
        }
        var favoriteContact =  dataSource.object(at: indexPath)
        favoriteContact.favorite = true
        
        dataSource.updateContact(favoriteContact, at: indexPath)
        
        tableView.reloadData()
        }
    
}
