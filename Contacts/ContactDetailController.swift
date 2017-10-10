//
//  ContactDetailController.swift
//  Contacts
//
//  Created by Mac on 10/10/2017.
//  Copyright © 2017 Smart Soft. All rights reserved.
//

import UIKit

class ContactDetailController: UITableViewController {
    
    var contact: Contact?
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        guard let contact = contact else {
            return
        }
        phoneNumberLabel.text = contact.phone
        emailLabel.text = contact.email
        streetLabel.text = contact.street
        cityLabel.text = contact.city
        stateLabel.text = contact.state
        zipLabel.text = contact.zip
        
    }


}
