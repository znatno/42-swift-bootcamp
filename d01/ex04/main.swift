print("=== ex04")

print()

let deckX = Deck(isMixed: false)
let deckY = Deck(isMixed: true)

print("Description of deckX:\n\(deckX)")
print()
print("Description of deckY (shuffled):\n\(deckY)")

print()

print("Draw first card from deckX and showing card, outs of deckX:")
print(deckX.draw() ?? "Already empty")
print(deckX.outs)

print("Remove all elements of deckX and try to draw again:")
deckX.cards.removeAll()
print(deckX.draw() ?? "Already empty")

print()

print("Draw and Fold first card from deckY and showing disards of deckY:")
let drawedCard = deckY.draw()
deckY.fold(c: drawedCard!)
print(deckY.disards)

print("The same, but with card not from outs:")
let someCard = deckY.cards[0]
deckY.fold(c: someCard)

print()

