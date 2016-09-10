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
	
	private let player = KirinsanPlayer()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let view = self.player.vibrationView
		view.frame = self.view.bounds
		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.view.addSubview(view)
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		self.player.play()
		
	}
	
}
