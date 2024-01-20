//
//  DeviceDetailsTableViewCell.swift
//  MyTV
//
//  Created by Rahul Anand on 20/01/24.
//

import UIKit

class DeviceDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak private var infoLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        self.descriptionLabel.isHidden = false
    }
    func setDeviceInfoAndDescription(info: DeviceDetailsCells) {
        switch info {
        case .deviceName:
            self.infoLabel.text = "Device Info"
            self.descriptionLabel.text = UIDevice.current.name
        case .deviceModel:
            self.infoLabel.text = "Device Model"
            self.descriptionLabel.text = UIDevice.current.model
        case .deviceSystemName:
            self.infoLabel.text = "OS Type"
            self.descriptionLabel.text = UIDevice.current.systemName
        case .deviceSystemVersion:
            self.infoLabel.text = "OS Version"
            self.descriptionLabel.text = UIDevice.current.systemVersion
        case .deviceIdentifier:
            self.infoLabel.text = "Device Identifier"
            self.descriptionLabel.text = UIDevice.current.identifierForVendor?.uuidString
        }
    }
    
    func setLanguageDetails(info: String) {
        self.descriptionLabel.isHidden = true
        self.infoLabel.text = info
    }

}
