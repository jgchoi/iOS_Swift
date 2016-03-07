import Foundation

class DeckOfCards {
   var deck = [Int : String]( )
   var draw : String = ""
   
   init( ) {
      var index : Int = 0
      for rank in ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"] {
         for suit in ["S", "C", "D", "H"] {
            deck[index] = rank + suit
            index++
         }                      // 4 marks for dictionary/array
      }
   }
   func dealHand(n: Int) {
      var hand : [Int] = [ ]
      for var i = 0; i < n; i++ {
         let card = Int(arc4random_uniform(52))
         hand.append(card)
      }                         // 4 marks for random number generation and storage of values
      hand = hand.sort{$0 < $1} // to allow for easy comparison, but not required
      for i in 0..<hand.count { // create string for display
         draw += deck[hand[i]]! + " "
      }
      print("\(draw)")          // 4 marks for creating and displaying cards/strings
      
      for i in 0..<n { // because duplicates are allowed, algorithm captures false positives
         for var j=i+1; j < n; j++ {
            if (hand[i] + 1 == hand[j] || hand[i] + 2 == hand[j] || hand[i] + 3 == hand[j]
               || hand[i] + 4 == hand[j]) && hand[j] % 4 != 0 {
               print("found at least a pair...\n")
            }
         }
      }                // 4 marks for a relatively functional algorithm that detects pairs
   }
}


var myCards = DeckOfCards( )
myCards.dealHand(5)

