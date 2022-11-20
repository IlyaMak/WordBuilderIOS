//
//  PlayableScreen.swift
//  WordBuilder
//
//  Created by ilya on 13.10.22.
//

import SwiftUI

struct PlayableScreen: View {
    let maxNumberOfLettersPerRow = 4
    let maxNumberOfRows = 2
    let minNumberOfRows = 1
    let maxWordLengthMinValue = 5
    let letterButtonSizePercent = 0.1
//    @EnvironmentObject var viewRouter: ViewRouter
    var words: [String] = ["cow", "low", "bow", "bowl"]
    @State var enteredWord = ""
    @State var guessedWordIndices: Set<Int> = []
    @State var maxWordLength: Int = 0
    var currentLevelIndex: Int
    @State private var showLevelView = false
    @State private var showLeaderboardView = false
    
//    var letters: [String] {
//            get {
//                return Array(Set(words.reduce("", {(value, element) in
//                    value + element
//                }).map{String($0)}))
//            }
//        }
    
    var arrayLetters: [String]
//    {
//        get {
//            var letters = [String]()
//            for word in words {
//                for letter in word {
//                    letters.append(String(letter))
//                }
//            }
//            return letters
//        }
//    }
    
    var letters: [String]
    
    init(levelIndex: Int) {
        arrayLetters = words.joined().map{String($0)}
        letters = NSOrderedSet(array: arrayLetters.shuffled()).array as! [String]
        currentLevelIndex = levelIndex
    }
    
    func handleLetterButtonPressed(letter: String) -> Void {
        maxWordLength = words.reduce("", { (value, element) in
                                        element.count > value.count ? value : element}).count
        maxWordLength = maxWordLength < maxWordLengthMinValue ? maxWordLengthMinValue : maxWordLength
        
        if(guessedWordIndices.count != words.count && enteredWord.count + 1 <= maxWordLength) {
            enteredWord += letter
            var index = words.firstIndex(of: enteredWord)
            if(index != nil && !guessedWordIndices.contains(index!)) {
                guessedWordIndices.insert(index!)
                enteredWord = ""
                
                
            }
        }
    }
    
    func getLetterPicker() -> some View {
        let numberOfRows = letters.count > maxNumberOfLettersPerRow ? maxNumberOfRows : minNumberOfRows
        return ForEach(Array(arrayLiteral: numberOfRows), id: \.self) { index in
                HStack {
//                    (index == 0
//                    ? letters[0...numberOfRows == 1 ? 0 : ceil(letters.count / 2)]
//                    : letters[(letters.count / 2)...letters.count]).map {
//                            (letter) -> String in
//                    let a = letters[0...Int(ceil(Double((letters.count / 2))))].map({$0})
                    
//                    let letterSliceForFirstIndex = numberOfRows == 1 ? 0 : Int(ceil(Double(letters.count / 2)))
//                    let elementsInRows = (index == 0 ? letters[0...letterSliceForFirstIndex] : letters[Int(ceil(Double((letters.count) / 2)))...letters.count - 1])
//                    Text("\(elementsInRows)" as String).fontWeight(.bold)
                    
                    ForEach(letters, id: \.self) { letter in
                        Button(
                            action: {
                                handleLetterButtonPressed(letter: letter)
                            },
                            label: {
                                Text("\(letter)".uppercased())
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(
                                        Color.purple
                                            .cornerRadius(10)
                                            .shadow(radius: 5)
                                    )
                            }
                        )
                    }
                }
            }
    }
    
    var body: some View {
            VStack {
                ForEach(words.indices) { wordIndex in
                    HStack {
                        ForEach(Array(words[wordIndex]), id: \.self) { letter in
                            Rectangle()
                                .foregroundColor(.white)
                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                                .cornerRadius(3)
                                .frame(width: 50, height: 50)
                                .overlay(Text(!guessedWordIndices.contains(wordIndex) ? "" : "\(letter.uppercased())" as String))
                        }
                    }
                }
                
                Text(enteredWord.uppercased()).fontWeight(.bold)
                
                getLetterPicker()
                
            }
    }
}

struct PlayableScreen_Previews: PreviewProvider {
    static var currentLevelIndex = 0
    
    static var previews: some View {
        PlayableScreen(levelIndex: currentLevelIndex)
    }
}
