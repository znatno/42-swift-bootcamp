//
//  NoteListViewController.swift
//  DeathNote
//
//  Created by Ivan BOHUN on 2/6/20.
//  Copyright © 2020 Ivan BOHUN. All rights reserved.
//

import UIKit

class NoteListViewController: UITableViewController {
	
	var notes: [Note] =	[
				Note(title : "One",		description : "Lorem Ipsum",	date : Date(timeIntervalSinceNow: 0)),
				Note(title : "Two",		description : "Dolor Set Amet", date : Date(timeIntervalSinceNow: 86400)),
				Note(title : "Three",	description : "Slava Ukraini",	date : Date(timeIntervalSinceNow: -86400)),
	]
	
	@IBAction func cancel(segue:UIStoryboardSegue) {}
	@IBAction func done(segue:UIStoryboardSegue) {
		let noteDetailVC = segue.source as! NoteDetailViewController
		
		if let newNote = noteDetailVC.getNote {
			notes.append(newNote)
			print("title: \(newNote.title)")
			print("description: \(newNote.description)")
			print("date: \(newNote.date)")
		}
		
		tableView.reloadData()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell
		
		let note = notes[indexPath.row]
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
	
		cell.noteDescription.numberOfLines = 0
		
		cell.noteTitle.text = note.title
		cell.noteDescription.text = note.description
		cell.noteDate.text = dateFormatter.string(from: note.date)
		
        return cell
    }

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}

	
}
