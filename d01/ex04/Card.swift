import Foundation

class Card: NSObject {
	
	let color: Color
	let value: Value
	
	override var description: String {
		return "\(value.rawValue), \(color.rawValue)"
	}
	
	init (c: Color, v: Value) {
		self.color = c
		self.value = v
	}
	
	override func isEqual(_ object: Any?) -> Bool {
		guard let other = object as? Card else { return false }
		return self.color == other.color && self.value == other.value
	}
	
	static func ==(lhs: Card, rhs: Card) -> Bool {
		return lhs.color == rhs.color && lhs.value == rhs.value
	}
}
