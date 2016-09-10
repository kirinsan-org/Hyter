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
		
		circleView.backgroundColor = .white()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	convenience init() {
		self.init(frame: .zero)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		if let squareview = self.squareLayoutView, let circleView = self.circleView {
			
			let length = min(self.frame.width, self.frame.height)
			squareview.frame.size = CGSize(width: length, height: length)
			squareview.center = self.center
			
			circleView.frame = squareview.bounds
			circleView.layer.cornerRadius = circleView.frame.width / 2
			circleView.clipsToBounds = true
			
			circleView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
			
		}
		
	}
	
	func animate(_ duration: TimeInterval, completion: (() -> Void)?) {
		
		let duration = duration > 0.5 ? duration : 0.5
		
		if let squareView = self.squareLayoutView, let circleView = self.circleView {
			
			let circles = Int(duration * 10)
			let delayUnit: TimeInterval = duration / TimeInterval(circles)
			
			UIView.animate(withDuration: 0.1, animations: {
				circleView.backgroundColor = UIColor(red: 0.545, green: 0.827, blue: 1, alpha: 1)
			}, completion: { (_) in
				UIView.animate(withDuration: 0.3, delay: duration - 0.1, options: [], animations: {
					circleView.backgroundColor = .white()
				}, completion: { (_) in
					completion?()
				})
			})
			
			for i in 0 ..< circles {
				let view = UIView(frame: squareView.bounds)
				view.layer.cornerRadius = view.frame.width / 2
				view.layer.borderColor = UIColor(red: 0.545, green: 0.827, blue: 1, alpha: 1).cgColor
				view.layer.borderWidth = 2
				view.transform = circleView.transform
				squareView.addSubview(view)
				UIView.animate(withDuration: 1, delay: TimeInterval(i) * delayUnit, options: [], animations: {
					view.transform = CGAffineTransform.identity
					view.alpha = 0
				}, completion: { (_) in
					view.removeFromSuperview()
				})
			}
			
		}
		
	}
	
}
