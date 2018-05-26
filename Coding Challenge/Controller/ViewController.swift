//
//  ViewController.swift
//  Coding Challenge
//
//  Created by Carl Brenneisen on 3/15/18.
//  Copyright © 2018 Carl Brenneisen. All rights reserved.
//

import UIKit
import CoreLocation

final class ViewController: UIViewController {

    var issPassTime:ISSPassTime?
    let locationManager = LocationManager()
    
    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func getTime(datetime:Int)->String{
        let date = Date(timeIntervalSinceNow: TimeInterval(datetime))
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        return "\(hour):\(minutes).\(seconds)"
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numPasses = issPassTime?.request.passes else {return 0}
        return numPasses
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "time", for: indexPath) as! ISSPassTimeCell
        
        guard let duration = issPassTime?.response[indexPath.row].duration else {return cell}
        
        guard let time = issPassTime?.response[indexPath.row].risetime else {return cell}
        
        cell.durationLabel.text = "Duration: \(duration) seconds"
        
        let timeStr = self.getTime(datetime: time)
        
        cell.timeLabel.text = "Time: " + timeStr
        
        return cell
    }
    
}

extension ViewController: LocationManagerDelegate {
    
    func updated(location: CLLocation?) {
        guard let lat = location?.coordinate.latitude else {return}
        guard let lon = location?.coordinate.longitude else {return}

        Networking.shared.GetISSPassTimes(LAT: lat, LON: lon) { (passTime) in
            guard let passTime = passTime else {return}
            self.issPassTime = passTime
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print(self.issPassTime?.message ?? "Failed to get data")
        }
    }
    
    func updatedAuthorization(status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            askForPermission()
        }
    }
    
    private func askForPermission(){
        let alert = UIAlertController(
            title: "Location Services Disabled",
            message: "Please enable Location Services in Settings",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}





