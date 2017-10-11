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
    
   var sections = ContactsSource.sectionContacts
   let sectionTitles = ContactsSource.sortedUniqueFirstLetter

    override func viewDidLoad() {
        super.viewDidLoad()
    

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Data Source
    
    //for giving section title indice
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    // display alphabetic letters
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let Contactcell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {
            fatalError()
        }
        let contact = sections[indexPath.section][indexPath.row]
//        let contact = contacts[indexPath.row]
        Contactcell.profileImageView.image = contact.image
        Contactcell.nameLabel.text = "\(contact.firstName) \(contact.lastName)"
        Contactcell.cityLabel.text = contact.city
        
        if contact.favorite {
            Contactcell.favoriteIcon.image = #imageLiteral(resourceName: "Star")
        }
        
        return Contactcell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showContact" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let contact = sections[indexPath.section][indexPath.row]
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
        var outerIndex: Array.Index? = nil
        var innerIndex: Array.Index? = nil
        for (index, contacts) in sections.enumerated() {
            if let indexOfContact = contacts.index(of: contact){
                outerIndex = index
                innerIndex = indexOfContact
                break
            }
        }
        if let outerIndex = outerIndex, let innerIndex = innerIndex {
            var favoriteContact = sections[outerIndex][innerIndex]
            favoriteContact.favorite = true
            sections[outerIndex][innerIndex] = favoriteContact
            
            tableView.reloadData()
        }
    }
}
