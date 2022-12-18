//
//  PlayableScreen.swift
//  WordBuilder
//
//  Created by ilya on 13.10.22.
//

import SwiftUI
import RealmSwift

class LevelModel: ObservableObject {
    @Published var words: [String] = []
    @Published var arraysLetters: [String] = []
    @Published var letters: [String] = []
    @Published var maxWordsLength: Int = 0
}

struct PlayableScreen: View {
    @AppStorage("isDarkMode") public var isDark = false
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    let maxNumberOfLettersPerRow = 8
    let maxNumberOfRows = 2
    let minNumberOfRows = 1
    let maxWordLengthMinValue = 5
    let letterButtonSizePercent = 0.1
    @State var enteredWord = ""
    @State var guessedWordIndices: Set<Int> = []
    @State var currentLevelIndex: Int
    @State private var showErrorAlert = false
    @ObservedObject var levelModel: LevelModel = LevelModel()
    @ObservedResults(LevelCompleted.self) var results
    var levels: [Level] = []
    let application: Application
    
    init(levelIndex: Int, levelList: [Level], application: Application) {
        self.application = application
        _currentLevelIndex = State(initialValue: levelIndex)
        levels = levelList
        initLevel(levelIndex: currentLevelIndex, levelList: levelList)
    }
    
    func initLevel(levelIndex: Int, levelList: [Level]) {
        let words = levelList.count == 0 ? [] : Array(levelList[levelIndex].words)
        let arrayLetters = words.joined().map{String($0)}
        let letters = NSOrderedSet(array: arrayLetters.shuffled()).array as! [String]
        var maxWordLength = words.reduce("", { (value, element) in
                                        element.count > value.count ? element : value}).count
        maxWordLength = maxWordLength < maxWordLengthMinValue ? maxWordLengthMinValue : maxWordLength
        
        levelModel.words = words
        levelModel.letters = letters
        levelModel.arraysLetters = arrayLetters
        levelModel.maxWordsLength = maxWordLength
    }
    
    func handleLetterButtonPressed(letter: String) -> Void {
        let words = levelModel.words
        let maxWordLength = levelModel.maxWordsLength
        
        if(guessedWordIndices.count != words.count && enteredWord.count + 1 <= maxWordLength) {
            enteredWord += letter
            let index = words.firstIndex(of: enteredWord)
            
            if(index != nil && !guessedWordIndices.contains(index!)) {
                guessedWordIndices.insert(index!)
                enteredWord = ""
                
                if(guessedWordIndices.count == words.count) {
                    let realm = try! Realm()
                    
                    let levelCompleted = LevelCompleted()
                    let id = (realm.objects(LevelCompleted.self).max(ofProperty: "id") as Int? ?? 0) + 1
                    levelCompleted.id = id
                    
                    levelCompleted.levelId = levels[currentLevelIndex].id
                    try! realm.write {
                        realm.add(levelCompleted)
                    }
                    
                    Network.createPostRequest(
                        endpoint: Endpoints.levelsCompleted,
                        application: application,
                        parameters: Array(results.elements.map{$0.levelId}),
                        onSuccess: {_ in
                           
                    }, onError: {
                        self.showErrorAlert.toggle()
                    }
                    )
                }
            }
        }
    }
    
    func getLetterPicker() -> some View {
        let letters = levelModel.letters
        let numberOfRows = letters.count > maxNumberOfLettersPerRow ? maxNumberOfRows : minNumberOfRows

        return VStack {
            ForEach(0...(numberOfRows - 1), id: \.self) { index in
                let rowLetters = index == 0
                    ? letters[0...(numberOfRows == 1 ? letters.count - 1 : Int(ceil(Double(letters.count) / 2)) - 1)]
                    : letters[Int(ceil(Double(letters.count) / 2))...(letters.count - 1)]
                    
                HStack {
                    ForEach(rowLetters, id: \.self) { letter in
                        Button(
                            action: {
                                handleLetterButtonPressed(letter: letter)
                            },
                            label: {
                                Text("\(letter)".uppercased())
                                    .font(.system(size: CGFloat(getFontSizeBasedOnScreenWidth())))
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
    }
    
    func goToNextLevel() {
        if(levels.contains(levels[currentLevelIndex + 1])) {
            currentLevelIndex += 1
            initLevel(levelIndex: currentLevelIndex, levelList: levels)
            enteredWord = ""
            guessedWordIndices.removeAll()
        }
    }
    
    func getFontSizeBasedOnScreenWidth() -> Double {
        return Double(UIScreen.main.bounds.size.width * 0.07)
    }
    
    var body: some View {
        let words = levelModel.words
        let maxWordLength = levelModel.maxWordsLength
        
            return VStack {
                ForEach(words.indices, id: \.self) { wordIndex in
                    HStack {
                        ForEach(Array(words[wordIndex]), id: \.self) { letter in
                            Rectangle()
                                .foregroundColor(.white)
                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                                .cornerRadius(3)
                                .frame(width: UIScreen.main.bounds.size.width * 0.75 / CGFloat(maxWordLength), height: UIScreen.main.bounds.size.width * 0.75 / CGFloat(maxWordLength))
                                .overlay(
                                    Text(
                                        !guessedWordIndices.contains(wordIndex)
                                            ? ""
                                            : "\(letter.uppercased())" as String
                                    )
                                    .foregroundColor(Color.black)
                                    .font(.system(size: CGFloat(getFontSizeBasedOnScreenWidth())))
                                )
                        }
                    }
                }
                HStack {
                    //empty space is required for constant height
                    Text(enteredWord.isEmpty ? " " : enteredWord.uppercased()).fontWeight(.bold)

                    Button(
                        action: {
                            if(!enteredWord.isEmpty) {
                                enteredWord.removeLast()
                            }
                        },
                        label: {
                            Image(systemName: "delete.left").foregroundColor(isDark ? .white : .black)
                        }
                    )
                    .opacity(enteredWord == "" ? 0 : 1)
                }
                
                Button(
                    action: {
                        guessedWordIndices.count == words.count ? goToNextLevel() : nil
                    },
                    label: {
                        Image(systemName: "play")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                Color.green
                                    .cornerRadius(10)
                                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            )
                    }
                )
                .opacity(guessedWordIndices.count == words.count ? 1 : 0)
                .alert(isPresented: $showErrorAlert) {
                    Alert(title: Text("Server error"),
                          message: Text("Please, go to back screen and play level again"),
                          dismissButton: .default(Text("OK")))
                }
                
                getLetterPicker()
                    .navigationBarTitle("level_screen_level_number".localized(language) + String(levels.count == 0 ? 0 : levels[currentLevelIndex].number), displayMode: .inline)
            }
    }
}
