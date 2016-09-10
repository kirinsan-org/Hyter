//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by 史翔新 on 2016/09/11.
//  Copyright © 2016年 Crazism. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
		
		DispatchQueue.global().async {
			
			while true {
				DispatchQueue.main.async {
					WKInterfaceDevice.current().play(.retry)
				}
				Thread.sleep(forTimeInterval: 2)
			}
			
		}
		
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
