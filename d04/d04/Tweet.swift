//
//  Tweet.swift
//  d04
//
//  Created by Ivan BOHUN on 2/8/20.
//  Copyright © 2020 Ivan BOHUN. All rights reserved.
//

import Foundation

struct Tweet {
	let name: String
	let text: String
	let date: Date
	
	init (name: String, text: String, date: Date) {
		
		self.name = name
		self.text = text
		self.date = date
	}
}

extension Tweet: CustomStringConvertible {
	
	var description: String {
		return "(\(name): \(text))"
	}

}
