//
//  Note.swift
//  DeathNote
//
//  Created by Ivan BOHUN on 2/6/20.
//  Copyright © 2020 Ivan BOHUN. All rights reserved.
//

import Foundation

struct Note {
	var title: String
	var description: String
	var date: Date
	
	init (title: String, description: String, date: Date) {
		self.title = title
		self.description = description
		self.date = date
	}
}
