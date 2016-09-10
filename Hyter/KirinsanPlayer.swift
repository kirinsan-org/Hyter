//
//  KirinsanPlayer.swift
//  Hyter
//
//  Created by 史翔新 on 2016/09/11.
//  Copyright © 2016年 Crazism. All rights reserved.
//

#if os(iOS)
import UIKit
import AudioToolbox

#elseif os(watchOS)
import WatchKit

#endif

class KirinsanPlayer {
	
	fileprivate let kirinsan = Kirinsan()
	
	#if os(iOS)
	let vibrationView = VibrationView()
	#endif
	
}

extension KirinsanPlayer {
	
	func play() {
		self.startVibration()
		
		#if os(iOS)
		self.startAnimation()
		#endif
	}
	
}

extension KirinsanPlayer {
	
	private func vibrate() {
		
		DispatchQueue.main.async {
			
		#if os(iOS)
			AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
		#elseif os(watchOS)
			WKInterfaceDevice.current().play(.retry)
		#endif
			
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

#if os(iOS)
extension KirinsanPlayer {
	
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
#endif

extension KirinsanPlayer {
	
	func startVibration() {
		DispatchQueue.global().async {
			while true {
				self.runKirinsanVibration()
			}
		}
	}
	
	#if os(iOS)
	func startAnimation() {
		DispatchQueue.global().async {
			while true {
				self.runKirinsanAnimation()
			}
		}
	}
	#endif
	
}
