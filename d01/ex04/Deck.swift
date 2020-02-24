import Foundation

class Deck: NSObject {
	var cards: [Card]
	var disards: [Card] = []
	var outs: [Card] = []
	
	override var description: String {
		var description = ""
		
		cards.forEach { card in
			description = description + ", " + card.description
		}
		
		if description == "" {
			return "Empty"
		} else {
			description.removeFirst()
			description.removeFirst()
			return description
		}
	}
	
	static let allSpades: [Card] = Value.allValues.map {
		Card(c: Color.Spade, v: $0)
	}
	
	static let allDiamonds: [Card] = Value.allValues.map {
		Card(c: Color.Diamond, v: $0)
	}
	
	static let allHearts: [Card] = Value.allValues.map {
		Card(c: Color.Heart, v: $0)
	}
	
	static let allClubs: [Card] = Value.allValues.map {
		Card(c: Color.Club, v: $0)
	}
	
	static let allCards: [Card] = allSpades + allDiamonds + allHearts + allClubs
	
	init(isMixed: Bool) {
		if isMixed {
			self.cards = Deck.allCards.shuffle()
		} else {
			self.cards = Deck.allCards
		}
	}
	
	func draw() -> Card? {
		if cards.count > 0 {
			let card = cards.removeFirst()
			outs.insert(card, at: 0)
			return card
		} else {
			return nil
		}
	}
	
	func fold(c: Card) {
		for (index, cardT) in outs.enumerated() {
			
			if cardT == c {
				let card = outs.remove(at: index)
				disards.insert(card, at: 0)
				return
			}
			
		}
		print("Not in outs")
	}
}

extension Array where Element: Card {
	func shuffle() -> [Element] {
		var arr = self
		var shuffledArr: [Element] = []

		for _ in 0 ..< arr.count {
			let rand = Int(arc4random_uniform(UInt32(arr.count)))
			shuffledArr.append(arr[rand])
			arr.remove(at: rand)
		}

		return shuffledArr
	}
}

