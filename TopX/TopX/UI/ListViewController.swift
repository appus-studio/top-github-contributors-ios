//
//  ViewController.swift
//  TopX
//
//  Created by Andrew Mysyk on 4/12/19.
//  Copyright © 2019 Andrew Mysyk. All rights reserved.
//

import UIKit
import PKHUD
import CoreLocation

// Cocoapods - 3rd party dependency manager, that helps in easy way manage 3rd party library's

// MVC - one of the most popular and simple architectures, that divides app modules into 3 components: model, view, controller

class ListViewController: UIViewController {
    // Table view - ready UI element that provides the ability to develop custom list
    @IBOutlet weak var tableView: UITableView!
    
    var loader = PKHUD.sharedHUD
    var refreshControl: UIRefreshControl!
    var dataSource = Users() {
        didSet {
            tableView.reloadData()
        }
    }
    
    /*
     *  Developing UI and layout in storyboard
     *  Helps save development time by visualizing the view hierarchy, constraints
     *  And less source code
     */
    
    /*
     *  Constraints provides provide the development of a flexible user interface that will adapt to the screens of different devices
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        tableView.refreshControl = refreshControl
        showLoader()
        loadContributors(with: Const.offset)
    }
    
    @objc func refreshList() {
        loadContributors(with: Const.offset)
    }
    
    // MARK: UI
    
    func showLoader() {
        loader.contentView = PKHUDProgressView()
        loader.show()
    }
    
    func hideLoader() {
        loader.hide()
    }
    
    func makeErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Network
    
    /*
     *  URLSession - native instrument with many features, like:
     *  - privacy storage for cookies, cache and other;
     *  - ability to managing downloads;
     *  - downloads and uploads data in background and others;
     */
    
    func loadContributors(with offset: Int) {
        let headers = ["Accept": "application/json"]
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.github.com/repos/apple/swift/contributors?q=contributions&order=desc&per_page=\(offset)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { [weak self] (data, _, error) -> Void in
            guard let uSelf = self else { return }
            DispatchQueue.main.async {
                uSelf.hideLoader()
                uSelf.refreshControl.endRefreshing()
                if let error = error {
                    uSelf.makeErrorAlert(with: error.localizedDescription)
                } else if let data = data {
                    do {
                        uSelf.dataSource = try JSONDecoder().decode(Users.self, from: data)
                    } catch {
                        uSelf.makeErrorAlert(with: "Incorrect data from server.")
                    }
                } else {
                    uSelf.makeErrorAlert(with: "Something went wrong, please, try again later.")
                }
            }
        })
        
        dataTask.resume()
    }
    
    func loadUser(with userName: String) {
        showLoader()
        let headers = ["Accept": "application/json"]
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.github.com/users/\(userName)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { [weak self] (data, _, error) -> Void in
            guard let uSelf = self else { return }
            DispatchQueue.main.async {
                uSelf.hideLoader()
                if let error = error {
                    uSelf.makeErrorAlert(with: error.localizedDescription)
                } else if let data = data {
                    do {
                        let user = try JSONDecoder().decode(UserDetails.self, from: data)
                        if let location = user.location {
                            let locationStringUrl = "http://maps.apple.com/?address=\(location)"
                            guard let locationUrl = URL(string: locationStringUrl) else {
                                uSelf.makeErrorAlert(with: "Cannot get user location.")
                                return
                            }
                            if UIApplication.shared.canOpenURL(locationUrl) {
                                UIApplication.shared.open(locationUrl, options: [:], completionHandler: nil)
                            } else {
                                uSelf.makeErrorAlert(with: "Cannot open maps app.")
                            }
                        } else {
                            uSelf.makeErrorAlert(with: "User has no location.")
                        }
                    } catch {
                        uSelf.makeErrorAlert(with: "Incorrect data from server.")
                    }
                } else {
                    uSelf.makeErrorAlert(with: "Something went wrong, please, try again later.")
                }
            }
        })
        
        dataTask.resume()
    }
    
    // MARK: Location
    
    func getCoordinate(addressString: String,
                       completion: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?.first, let location = placemark.location {
                    completion(location.coordinate, nil)
                    return
                }
            }
            
            completion(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
}

// MARK: Cell Delegate

extension ListViewController: ListCellDelegate {
    func didChooseUserLocation(with userName: String) {
        loadUser(with: userName)
    }
}

// MARK: TableView Data Source

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellId, for: indexPath) as! ListCell
        cell.configure(with: self, and: dataSource[indexPath.row])
        return cell
    }
}
