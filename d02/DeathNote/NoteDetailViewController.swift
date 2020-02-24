//
//  NoteDetailViewController.swift
//  DeathNote
//
//  Created by Ivan BOHUN on 2/6/20.
//  Copyright © 2020 Ivan BOHUN. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {
	
	var getNote: Note? {
		let title: String = noteName.text ?? ""
		let description: String = noteDescription.text ?? ""
		let date: Date = noteDate.date
		
		if title == ""	{ return nil }
		else			{ return Note(title: title, description: description, date: date) }
	}
	
	@IBOutlet weak var noteName: UITextField!
	@IBOutlet weak var noteDescription: UITextView!
	@IBOutlet weak var noteDate: UIDatePicker!
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "doneSegue" {}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		let midnightToday = Calendar.current.startOfDay(for: Date())
		noteDate.minimumDate = midnightToday
		noteDate.date = midnightToday
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
