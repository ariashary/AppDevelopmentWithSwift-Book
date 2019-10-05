import UIKit
import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]

    var formattedWord: String {
        var guessedWord =  String()
        for letter in word.characters {
            print(letter)
            if guessedLetters.contains(letter) {
                print("Ada")
                guessedWord += "\(letter)"
            } else {
                print("Tidak Ada")
                guessedWord += "_"
            }
        }
        return guessedWord
    }

    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if word.characters.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
}

var game = Game(word: "swift", incorrectMovesRemaining: 7, guessedLetters: [])
//game.playerGuessed(letter: "f")
//game.playerGuessed(letter: "t")
//game.playerGuessed(letter: "s")

//game.formattedWord

//print(game.guessedLetters)
//print(game.incorrectMovesRemaining)

let a = ["s", "f", "t"]
//let b: String = "swift"
//let c: [Character]
//
//var aaa: String {
//    var formattedWord: String {
//    //    var guessedWord =  String()
//        for aa in b.characters {
//            if aa.contains(a) {
//    //            guessedWord += "\(a)"
//                print(aa)
//            }
//    //        else {
//    //            guessedWord += "_"
//    //        }
//        }
//    //    return guessedWord
//    }
//}

if !a.isEmpty {
    print("a")
} else {
    print("b")
}
