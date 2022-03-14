//
//  ChooseLanguageVC.swift
//  Swift - Localization
//
//  Created by Bhanuteja on 09/06/21.
//

import UIKit
import CoreLocation

struct TableNames {
    var id: Int?
    var topLbl: String?
    var bottommLbl: String?
}

class ChooseLanguageVC: UIViewController {

    @IBOutlet weak var chooseLanguageTableView: UITableView!
    private var displayTableData = [TableNames]()
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        locationManagerStuff()
    }

    func setUpData() {
        displayTableData.append(TableNames(id: 0, topLbl: ChooseLanguageStrings.englishTopLbl.localized,
                                           bottommLbl: ChooseLanguageStrings.englishBottomLbl.localized))
        displayTableData.append(TableNames(id: 1, topLbl: ChooseLanguageStrings.arabicTopLbl.localized,
                                           bottommLbl: ChooseLanguageStrings.arabicBottomLbl.localized))
        displayTableData.append(TableNames(id: 2, topLbl: ChooseLanguageStrings.frenchTopLbl.localized,
                                           bottommLbl: ChooseLanguageStrings.frenchBottomLbl.localized))
        displayTableData.append(TableNames(id: 3, topLbl: ChooseLanguageStrings.spanishTopLbl.localized,
                                           bottommLbl: ChooseLanguageStrings.spanishBottomLbl.localized))
        chooseLanguageTableView.reloadData()
    }
    
    func locationManagerStuff() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        checkLocationStatus()
    }
    
    func checkLocationStatus() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways:
            print("Granted permission always")
        case .authorizedWhenInUse:
            print("Already granted permission")
        case .denied:
            print("Permission denied")
        case .notDetermined:
            print("Permission not determined")
        case .restricted:
            print("Permission restricted")
        default:
            print("Something went wrong")
        }
    }
}

extension ChooseLanguageVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print("Location updated latitude is: \(latitude) & longitude is: \(longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension ChooseLanguageVC: UITableViewDelegate, UITableViewDataSource {
    func registerTableView() {
        chooseLanguageTableView.register(UINib(nibName: "ChooseLanguageTableCell", bundle: nil),
                                         forCellReuseIdentifier: "ChooseLanguageTableCell")
        chooseLanguageTableView.tableFooterView = UIView()
        setUpData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayTableData.count 
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseLanguageTableCell", for: indexPath) as! ChooseLanguageTableCell
        cell.topLabel.text = displayTableData[indexPath.row].topLbl
        cell.bottomLbl.text = displayTableData[indexPath.row].bottommLbl
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            Language.setAppLanguageTo("en")
        } else if indexPath.row == 1 {
            Language.setAppLanguageTo("ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else if indexPath.row == 2 {
            Language.setAppLanguageTo("fr")
        } else if indexPath.row == 3 {
            Language.setAppLanguageTo("es")
        }
        if Language.currentAppLanguage() != "ar" {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        } else {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        UserDefaults.standard.setValue(displayTableData[indexPath.row].topLbl, forKey: "selectedLanguage")
        _ = navigationController?.popViewController(animated: true)
    }
}
