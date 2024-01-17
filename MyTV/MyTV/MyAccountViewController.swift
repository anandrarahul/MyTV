//
//  MyAccountViewController.swift
//  MyTV
//
//  Created by Rahul Anand on 20/12/23.
//

import UIKit

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
            cell?.cellTitle.text = NSLocalizedString("deviceInfo.title", comment: "")
            cell?.accessoryType = .disclosureIndicator
        case .language:
            cell?.cellTitle.text = NSLocalizedString("language.title", comment: "")
            cell?.accessoryType = .disclosureIndicator
        case .helpAndFeedback:
            cell?.cellTitle.text = NSLocalizedString("helpAndFeedback.title", comment: "")
            cell?.accessoryType = .detailDisclosureButton
        case .aboutAndLegal:
            cell?.cellTitle.text = NSLocalizedString("aboutAndLegal.title", comment: "")
            cell?.accessoryType = .detailDisclosureButton
        case .signout:
            cell?.cellTitle.text = NSLocalizedString("signout.title", comment: "")
            cell?.accessoryType = .none
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellRawValue: MyAccountCells = MyAccountCells(rawValue: indexPath.row)!
        let accountDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountDetailsViewController") as! AccountDetailsViewController
        switch cellRawValue {
        case .deviceInfo:
            print("Device Info")
        case .language:
            print("Language")
        case .helpAndFeedback, .aboutAndLegal:
            if cellRawValue == .helpAndFeedback {
                let titleText = NSLocalizedString("helpAndFeedback.title", comment: "")
                let descText = NSLocalizedString("maintenance.title", comment: "")
                accountDetailsViewController.setTitleAndDescription(title: titleText, description: descText)
            } else {
                let titleText = NSLocalizedString("aboutAndLegal.title", comment: "")
                let descText = NSLocalizedString("legalDescription.title", comment: "")
                accountDetailsViewController.setTitleAndDescription(title: titleText, description: descText)
            }
            self.navigationController?.pushViewController(accountDetailsViewController, animated: true)
        case .signout:
            self.dismiss(animated: true)
        }
    }
    
}
