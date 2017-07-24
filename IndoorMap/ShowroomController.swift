//
//  ShowroomController.swift
//  IndoorMap
//
//  Created by Tom Barrett on 24/07/2017.
//  Copyright © 2017 Estimote, Inc. All rights reserved.
//

import UIKit

class ShowroomController: UIViewController, ESTTriggerManagerDelegate {
    
    let triggerManager = ESTTriggerManager()
    
    @IBOutlet weak var lab: UILabel!
    
   // @IBOutlet weak var labelV: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert], categories: nil))
        self.triggerManager.delegate = self
        
        let rule1 = ESTOrientationRule.orientationEquals(
            .horizontalUpsideDown, for: .shoe)
        let rule2 = ESTMotionRule.motionStateEquals(
            true, forNearableIdentifier: "1b089cf2ccbf058b")
        let trigger = ESTTrigger(rules: [rule1, rule2], identifier: "tom the trigger")
        
        self.triggerManager.startMonitoring(for: trigger)
        print("plz")
    }

    func triggerManager(_ manager: ESTTriggerManager,
                        triggerChangedState trigger: ESTTrigger) {
        print("work")
        if (trigger.identifier == "tom the trigger" && trigger.state == true) {
            print("Hello, digital world! The physical world has spoken.")
            lab.text="You moved that shoe!"
        } else {
            print("Goodnight. <spoken in the voice of a turret from Portal>")
        }
    }
    
}
