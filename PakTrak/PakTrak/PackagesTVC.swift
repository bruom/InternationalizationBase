//
//  PackagesTVC.swift
//  PakTrak
//
//  Created by Bruno Omella Mainieri on 05/08/19.
//  Copyright © 2019 Bruno Omella Mainieri. All rights reserved.
//

import UIKit

class PackagesTVC: UITableViewController {
    
    var packageList:[Package] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        packageList = Package.placeholderData(amount: 8)
        packageList.sort { (a, b) -> Bool in
            a.deliveryDate < b.deliveryDate
        }
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packageList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "packageCell", for: indexPath) as? PackageCell{
            let thisPackage = packageList[indexPath.row]
            
            let packageFormat = NSLocalizedString("Package #%d from %@", comment: "Numero e remetente do pacote.")
            cell.packageLabel.text = String.localizedStringWithFormat(packageFormat, thisPackage.id, thisPackage.sender)
            
            let deliveryDate:String = DateFormatter.localizedString(from: thisPackage.deliveryDate, dateStyle: .medium, timeStyle: .none)
            if thisPackage.deliveryDate < Date() {
                //already delivered
                let deliveryFormat = NSLocalizedString("Arrived on %@", comment: "Data de chegada.")
                cell.dateLabel.text = String.localizedStringWithFormat(deliveryFormat, deliveryDate)
                
                cell.packageImageView.image = UIImage(named: NSLocalizedString("openBox", comment: "Titulo da imagem de pacote aberto"))
            } else{
                //yet to arrive
                let deliveryFormat = NSLocalizedString("Arrives on %@ (in %d days)", comment: "Data de entrega e número de dias até esta data.")
                cell.dateLabel.text = String.localizedStringWithFormat(deliveryFormat, deliveryDate, Int(thisPackage.deliveryDate.timeIntervalSinceNow/86400))
                
                cell.packageImageView.image = UIImage(named: NSLocalizedString("closedBox", comment: "Titulo da imagem de pacote fechado"))
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }

}
