//
//  PlayableScreen.swift
//  WordBuilder
//
//  Created by ilya on 13.10.22.
//

import SwiftUI

struct PlayableScreen: View {
    let maxNumberOfLettersPerRow = 8
    let maxNumberOfRows = 2
    let minNumberOfRows = 1
    let maxWordLengthMinValue = 5
    let letterButtonSizePercent = 0.1
    @EnvironmentObject var viewRouter: ViewRouter
    var words: [String] = ["hello", "holla"]
    @State var enteredWord = ""
    @State var guessedWordIndices: Set<Int> = []
    @State var maxWordLength: Int = 0
//    var letters: [String] {
//        get {
//            return Array(Set(words.joined().map{String($0)}))
//        }
//    }
    
//    var letters: [String] {
//            get {
//                return Array(Set(words.reduce("", {(value, element) in
//                    value + element
//                }).map{String($0)}))
//            }
//        }
    
    var arrayLetters: [String] {
        get {
            var letters = [String]()
            for word in words {
                for letter in word {
                    letters.append(String(letter))
                }
            }
            return letters
        }
    }
    
    var letters: [String] {
        get {
            NSOrderedSet(array: arrayLetters.shuffled()).array as! [String]
        }
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
        return VStack {
//            ForEach(Array(arrayLiteral: numberOfRows), id: \.self) { index in
                HStack {
//                    (index == 0
//                    ? letters[0...numberOfRows == 1 ? 0 : ceil(letters.count / 2)]
//                    : letters[(letters.count / 2)...letters.count]).map {
//                            (letter) -> String in
//                    let a = letters[0...Int(ceil(Double((letters.count / 2))))].map({$0})
                    
//                    let letterSliceForFirstIndex = numberOfRows == 1 ? 0 : Int(ceil(Double(letters.count / 2)))
//                    let elementsInRows = (index == 0 ? letters[0...letterSliceForFirstIndex] : letters[Int(ceil(Double((letters.count - 1) / 2)))...letters.count - 1])
//                    Text("\(elementsInRow)" as String)
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
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                    )
                            }
                        )
                    }
                }
//            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    ForEach(words.indices) { word in
                        HStack {
                            ForEach(Array(words[word]), id: \.self) { letter in
                                Rectangle()
                                    .foregroundColor(.white)
                                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(3)
                                    .frame(width: 50, height: 50)
                                    .overlay(Text("\(letter)" as String))
                            }
                                
                        }
                    }
                }
                Text("\(letters)" as String)
                VStack {
                    Text(enteredWord).fontWeight(.bold)
                    getLetterPicker()
                }
            }
                .navigationBarTitle("Play", displayMode: .inline)
                .navigationBarItems(
                    leading: Button(
                        action: {
                            withAnimation {
                                viewRouter.currentPage = .page2
                            }
                        },
                        label: {
                            Image(systemName: "arrow.backward")
                        }
                    ),
                    trailing: Button(
                        action: {
                            withAnimation {
                                viewRouter.currentPage = .page4
                            }
                        },
                        label: {
                            Image(systemName: "crown.fill").foregroundColor(.yellow)
                        }
                    )
                )
        }
    }
}

struct PlayableScreen_Previews: PreviewProvider {
    static var previews: some View {
        PlayableScreen().environmentObject(ViewRouter())
    }
}
