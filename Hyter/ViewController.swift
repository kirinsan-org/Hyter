//
//  ViewController.swift
//  Hyter
//
//  Created by 史翔新 on 2016/07/03.
//  Copyright © 2016年 Crazism. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let view = VibrationView(frame: self.view.bounds)
		view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
		self.view.addSubview(view)
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		vibration()
		kirinsan()
		
	}


	func vibration() {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
			while true {
				dispatch_async(dispatch_get_main_queue(), { 
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				})
				NSThread.sleepForTimeInterval(0.4)
			}
		})
	}
	
	func animate() {
		for subview in self.view.subviews {
			if let view = subview as? VibrationView {
				view.animate()
			}
		}
	}
	
	func vibrate(for vibrationCounter: Int) {
		for _ in 0 ..< vibrationCounter {
			NSThread.sleepForTimeInterval(0.4)
			AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
		}
		AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate)
	}
	
	func animate(for duration: NSTimeInterval, completion: (() -> Void)?) {
		for subview in self.view.subviews {
			if let view = subview as? VibrationView {
				view.animate(duration, completion: completion)
			}
		}
	}
	
	func kirinsan() {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
			while true {
				dispatch_async(dispatch_get_main_queue()) {
					self.animate(for: 0.4, completion: {
						NSThread.sleepForTimeInterval(0.4)
						self.animate(for: 1.2, completion: {
							NSThread.sleepForTimeInterval(0.4)
							self.animate(for: 0.4, completion: {
								NSThread.sleepForTimeInterval(0.4)
								self.animate(for: 2.8, completion: nil)
							})
						})
					})
				}
				NSThread.sleepForTimeInterval(6.4)
			}
		}
	}
	
}
