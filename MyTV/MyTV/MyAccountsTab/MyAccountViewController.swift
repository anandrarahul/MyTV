//
//  MyAccountViewController.swift
//  MyTV
//
//  Created by Rahul Anand on 20/12/23.
//

import UIKit

enum MyAccountCells: Int, CaseIterable {
    case deviceInfo = 0
    case language
    case helpAndFeedback
    case aboutAndLegal
    case signout
}

class MyAccountViewController: UIViewController {

    @IBOutlet weak var accountTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.accountTableView.dataSource = self
        self.accountTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("myAccount.title", comment: "")
    }

}

extension MyAccountViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MyAccountCells.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.accountTableView.dequeueReusableCell(withIdentifier: "MyAccountTableViewCell", for: indexPath) as? MyAccountTableViewCell
        let cellRawValue: MyAccountCells = MyAccountCells(rawValue: indexPath.row)!
        switch cellRawValue {
        case .deviceInfo:
            cell?.setTitleForCell(title: NSLocalizedString("deviceInfo.title", comment: ""), accessoryType: .disclosureIndicator)
        case .language:
            cell?.setTitleForCell(title: NSLocalizedString("language.title", comment: ""))
        case .helpAndFeedback:
            cell?.setTitleForCell(title: NSLocalizedString("helpAndFeedback.title", comment: ""), accessoryType: .detailDisclosureButton)
        case .aboutAndLegal:
            cell?.setTitleForCell(title: NSLocalizedString("aboutAndLegal.title", comment: ""), accessoryType: .detailDisclosureButton)
        case .signout:
            cell?.setTitleForCell(title: NSLocalizedString("signout.title", comment: ""))
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellRawValue: MyAccountCells = MyAccountCells(rawValue: indexPath.row)!
        switch cellRawValue {
        case .deviceInfo, .language:
            let deviceDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DeviceDetailsViewController") as! DeviceDetailsViewController
            deviceDetailsViewController.setCellName(cellName: cellRawValue)
            self.navigationController?.pushViewController(deviceDetailsViewController, animated: true)
        case .helpAndFeedback, .aboutAndLegal:
            let accountsDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountsDetailViewController") as! AccountsDetailViewController
            if cellRawValue == .helpAndFeedback {
                let titleText = NSLocalizedString("helpAndFeedback.title", comment: "")
                let descText = NSLocalizedString("maintenance.title", comment: "")
                accountsDetailViewController.setTitleAndDescription(title: titleText, description: descText)
            } else {
                let titleText = NSLocalizedString("aboutAndLegal.title", comment: "")
                let descText = NSLocalizedString("legalDescription.title", comment: "")
                accountsDetailViewController.setTitleAndDescription(title: titleText, description: descText)
            }
            self.navigationController?.pushViewController(accountsDetailViewController, animated: true)
        case .signout:
            self.dismiss(animated: true)
        }
    }
    
}
