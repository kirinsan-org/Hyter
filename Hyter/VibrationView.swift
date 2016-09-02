//
//  VibrationView.swift
//  Hyter
//
//  Created by 史翔新 on 2016/07/04.
//  Copyright © 2016年 Crazism. All rights reserved.
//

import UIKit

class VibrationView: UIView {
	
	weak var squareLayoutView: UIView?
	weak var circleView: UIView?
	
	override init(frame: CGRect) {
		
		let squareLayoutView = UIView()
		self.squareLayoutView = squareLayoutView
	
		let circleView = UIView()
		self.circleView = circleView
		
		super.init(frame: frame)
		
		squareLayoutView.addSubview(circleView)
		self.addSubview(squareLayoutView)
		
		circleView.backgroundColor = .whiteColor()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	convenience init() {
		self.init(frame: .zero)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		if let squareview = self.squareLayoutView, circleView = self.circleView {
			
			let length = min(self.frame.width, self.frame.height)
			squareview.frame.size = CGSize(width: length, height: length)
			squareview.center = self.center
			
			circleView.frame = squareview.bounds
			circleView.layer.cornerRadius = circleView.frame.width / 2
			circleView.clipsToBounds = true
			
			circleView.transform = CGAffineTransformMakeScale(0.5, 0.5)
			
		}
		
	}
	
	func animate() {
		
		if let squareView = self.squareLayoutView, circleView = self.circleView {
			UIView.animateWithDuration(0.2, animations: {
				circleView.backgroundColor = UIColor(red: 0.545, green: 0.827, blue: 1, alpha: 1)
			}, completion: nil)
			
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
				while true {
					dispatch_async(dispatch_get_main_queue(), {
						let view = UIView(frame: squareView.bounds)
						view.layer.cornerRadius = view.frame.width / 2
						view.layer.borderColor = UIColor(red: 0.545, green: 0.827, blue: 1, alpha: 1).CGColor
						view.layer.borderWidth = 2
						view.transform = circleView.transform
						squareView.addSubview(view)
						UIView.animateWithDuration(1, animations: {
							view.transform = CGAffineTransformIdentity
							view.alpha = 0
							}, completion: { (_) in
								view.removeFromSuperview()
						})
					})
					NSThread.sleepForTimeInterval(0.2)
				}
			})
			
		}
		
	}
	
	func animate(duration: NSTimeInterval, completion: (() -> Void)?) {
		
		let duration = duration >= 0.4 ? duration : 0.4
		
		if let squareView = self.squareLayoutView, circleView = self.circleView {
			UIView.animateWithDuration(0.1, animations: {
				circleView.backgroundColor = UIColor(red: 0.545, green: 0.827, blue: 1, alpha: 1)
			}, completion: { (_) in
				UIView.animateWithDuration(0.3, delay: duration - 0.1, options: [], animations: {
					circleView.backgroundColor = .whiteColor()
				}, completion: { (_) in
					completion?()
				})
			})
			
			let circles = Int(duration * 5)
			for i in 0 ..< circles {
				let view = UIView(frame: squareView.bounds)
				view.layer.cornerRadius = view.frame.width / 2
				view.layer.borderColor = UIColor(red: 0.545, green: 0.827, blue: 1, alpha: 1).CGColor
				view.layer.borderWidth = 2
				view.transform = circleView.transform
				squareView.addSubview(view)
				UIView.animateWithDuration(1, delay: NSTimeInterval(i) * 0.2, options: [], animations: {
					view.transform = CGAffineTransformIdentity
					view.alpha = 0
				}, completion: { (_) in
					view.removeFromSuperview()
				})
			}
			
		}
		
	}
	
	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		self.animate(0.4, completion: nil)
	}
	
}
