//
//  ContactsDataSource.swift
//  Contacts
//
//  Created by Mac on 11/10/2017.
//  Copyright © 2017 Smart Soft. All rights reserved.
//

import Foundation
import UIKit

class ContactsDataSource: NSObject, UITableViewDataSource {
    private var sectionedData: [[Contact]]
    let sectionTitles: [String]
    
    init(sectionedData: [[Contact]], sectionTitles: [String]){
        self.sectionedData = sectionedData
        self.sectionTitles = sectionTitles
        
        super.init()
    }
    // MARK: Data Source
    
    //for giving section title indice
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    // display alphabetic letters
     func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return sectionedData.count
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionedData[section].count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let Contactcell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {
            fatalError()
        }
        let contact = sectionedData[indexPath.section][indexPath.row]
        //        let contact = contacts[indexPath.row]
        Contactcell.profileImageView.image = contact.image
        Contactcell.nameLabel.text = "\(contact.firstName) \(contact.lastName)"
        Contactcell.cityLabel.text = contact.city
        
        if contact.favorite {
            Contactcell.favoriteIcon.image = #imageLiteral(resourceName: "Star")
        } else{
           Contactcell.favoriteIcon.image = nil
        }
        
        return Contactcell
    }
    
    func object(at indexPath: IndexPath) -> Contact {
        return sectionedData[indexPath.section][indexPath.row]
    }
    
    func indexPath(for contact: Contact) -> IndexPath? {
        for (index, contacts) in sectionedData.enumerated() {
            if let indexOfContact = contacts.index(of: contact) {
                return IndexPath(row: indexOfContact, section: index)
            }
        }
        return nil
    }
    
    func updateContact(_ contact: Contact, at indexPath: IndexPath)  {
        sectionedData[indexPath.section][indexPath.row] =  contact
    }

}
