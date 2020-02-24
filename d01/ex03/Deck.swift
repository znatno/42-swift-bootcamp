import Foundation

class Deck: NSObject {
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

