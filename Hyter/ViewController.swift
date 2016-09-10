//
//  ViewController.swift
//  Hyter
//
//  Created by 史翔新 on 2016/07/03.
//  Copyright © 2016年 Crazism. All rights reserved.
//

import UIKit
import AudioToolbox
import Eltaso

class ViewController: UIViewController {
	
	fileprivate var vibrationView: VibrationView!
	
	fileprivate let kirinsanRhythm = [
		1, 0, 1, 0, //きりんさん
		1, 0, 1, 0, //きりんさん
		1, 0, 1, 0, //首が長いの
		1, 1, 1, 0, //ねー
	]
	fileprivate let codeLength: TimeInterval = 0.5
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let view = VibrationView(frame: self.view.bounds)
		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.vibrationView = view
		self.view.addSubview(view)
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		self.startVibration()
		self.startAnimation()
		
	}
	
}

extension ViewController {
	
	fileprivate func vibrate() {
		GCD.runAsynchronizedQueue(with: {
			AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
		})
	}
	
	fileprivate func runKirinsanVibration() {
		
		self.kirinsanRhythm.forEach { (code) in
			
			defer {
				Thread.sleep(forTimeInterval: self.codeLength)
			}
			
			if code > 0 {
				self.vibrate()
			}
			
		}
		
	}
	
}

extension ViewController {
	
	fileprivate func animate() {
		GCD.runAsynchronizedQueue { 
			self.vibrationView.animate(self.codeLength, completion: nil)
		}
	}
	
	fileprivate func runKirinsanAnimation() {
		
		self.kirinsanRhythm.forEach { (code) in
			
			defer {
				Thread.sleep(forTimeInterval: self.codeLength)
			}
			
			if code > 0 {
				self.animate()
			}
			
		}
		
	}
	
}

extension ViewController {
	
	func startVibration() {
		GCD.runAsynchronizedQueue(at: .Global(priority: .Default)) { 
			while true {
				self.runKirinsanVibration()
			}
		}
	}
	
	func startAnimation() {
		GCD.runAsynchronizedQueue(at: .Global(priority: .Default)) { 
			while true {
				self.runKirinsanAnimation()
			}
		}
	}
		
}
