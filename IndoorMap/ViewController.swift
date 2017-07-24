//
//  ViewController.swift
//  IndoorMap
//

import UIKit

class ViewController: UIViewController, EILIndoorLocationManagerDelegate {

    let locationManager = EILIndoorLocationManager()

    var location: EILLocation!

    @IBOutlet weak var locationView: EILIndoorLocationView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // You can get them by adding your app on https://cloud.estimote.com/#/apps
        ESTConfig.setupAppID("toms-location-odr", andAppToken: "c76685df7fdccaec45b617c18cf50bdc")

        self.locationManager.delegate = self
        self.locationManager.mode = EILIndoorLocationManagerMode.light

        // You will find the identifier on https://cloud.estimote.com/#/locations
        let fetchLocationRequest = EILRequestFetchLocation(locationIdentifier: "deveire-meeting-room-")
        fetchLocationRequest.sendRequest { (location, error) in
            if let location = location {
                self.location = location

                // You can configure the location view to your liking:
                self.locationView.showTrace = true
                self.locationView.rotateOnPositionUpdate = false
                // Consult the full list of properties on:
                // http://estimote.github.io/iOS-Indoor-SDK/Classes/EILIndoorLocationView.html

                self.locationView.drawLocation(location)
                self.locationManager.startPositionUpdates(for: self.location)
            } else if let error = error {
                print("can't fetch location: \(error)")
            }
        }
    }

    func indoorLocationManager(_ manager: EILIndoorLocationManager, didFailToUpdatePositionWithError error: Error) {
        print("failed to update position: \(error)")
    }

    func indoorLocationManager(_ manager: EILIndoorLocationManager, didUpdatePosition position: EILOrientedPoint, with positionAccuracy: EILPositionAccuracy, in location: EILLocation) {
        print(String(format: "x: %5.2f, y: %5.2f, orientation: %3.0f", position.x, position.y, position.orientation))

        self.locationView.updatePosition(position)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
