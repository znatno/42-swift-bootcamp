print("=== ex01")

print()

let cardX = Card(c: Color.Heart, v: Value.King)
print("cardX: \(cardX)")

let cardY = Card(c: Color.Diamond, v: Value.Ten)
print("cardY: \(cardY)")

let cardZ = Card(c: Color.Heart, v: Value.King)
print("cardZ: \(cardZ)")

print("cardX.isEqual(cardY) = \(cardX.isEqual(cardY))")
print("cardX.isEqual(cardZ) = \(cardX.isEqual(cardZ))")

print("(cardX == cardY) = \(cardX == cardY)")
print("(cardX == cardZ) = \(cardX == cardZ)")

print()
