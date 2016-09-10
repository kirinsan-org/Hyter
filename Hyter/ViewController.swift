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
	
	fileprivate let kirinsan = Kirinsan()
	
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
	
	private func vibrate() {
		DispatchQueue.main.async {
			AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
		}
	}
	
	fileprivate func runKirinsanVibration() {
		
		let kirinsan = self.kirinsan
		kirinsan.rhythm.forEach { (code) in
			
			defer {
				Thread.sleep(forTimeInterval: kirinsan.codeLength)
			}
			
			if code > 0 {
				self.vibrate()
			}
			
		}
		
	}
	
}

extension ViewController {
	
	private func animate() {
		DispatchQueue.main.async {
			self.vibrationView.animate(withDuration: self.kirinsan.codeLength, completion: nil)
		}
	}
	
	fileprivate func runKirinsanAnimation() {
		
		let kirinsan = self.kirinsan
		kirinsan.rhythm.forEach { (code) in
			
			defer {
				Thread.sleep(forTimeInterval: kirinsan.codeLength)
			}
			
			if code > 0 {
				self.animate()
			}
			
		}
		
	}
	
}

extension ViewController {
	
	func startVibration() {
		DispatchQueue.global().async {
			while true {
				self.runKirinsanVibration()
			}
		}
	}
	
	func startAnimation() {
		DispatchQueue.global().async {
			while true {
				self.runKirinsanAnimation()
			}
		}
	}
		
}
