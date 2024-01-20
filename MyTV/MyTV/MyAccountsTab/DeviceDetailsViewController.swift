//
//  DeviceDetailsViewController.swift
//  MyTV
//
//  Created by Rahul Anand on 20/01/24.
//

import UIKit

enum DeviceDetailsCells: Int, CaseIterable {
    case deviceName
    case deviceModel
    case deviceSystemName
    case deviceSystemVersion
    case deviceIdentifier
}

class DeviceDetailsViewController: UIViewController {

    @IBOutlet weak var deviceDetailsTableView: UITableView!
    
    var cellName: MyAccountCells = .deviceInfo
    let deviceDetailsCellCount: Int = DeviceDetailsCells.allCases.count
    let languageCount: Int = Bundle.main.localizations.count
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.deviceDetailsTableView.dataSource = self
        self.deviceDetailsTableView.delegate = self
    }
    
    func setCellName(cellName: MyAccountCells) {
        self.cellName = cellName
    }

}

extension DeviceDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.cellName == .deviceInfo {
            return self.deviceDetailsCellCount
        } else if self.cellName == .language {
            return self.languageCount
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailsTableViewCell = self.deviceDetailsTableView.dequeueReusableCell(withIdentifier: "DeviceDetailsTableViewCell", for: indexPath) as! DeviceDetailsTableViewCell
        if self.cellName == .deviceInfo {
            detailsTableViewCell.setDeviceInfoAndDescription(info: DeviceDetailsCells(rawValue: indexPath.row)!)
        } else {
            detailsTableViewCell.setLanguageDetails(info: Bundle.main.localizations[indexPath.row])
        }
        return detailsTableViewCell
    }
    
    
}
