//
//  Extensions.swift
//  Hyter
//
//  Created by 史翔新 on 2016/07/04.
//  Copyright © 2016年 Crazism. All rights reserved.
//

import Foundation

infix operator =? {}

func =? <T> (inout lhs: T, rhs: T?) {
	if let rhs = rhs {
		lhs = rhs
	}
}

func =? <T> (inout lhs: T?, rhs: T?) {
	if let rhs = rhs {
		lhs = rhs
	}
}

