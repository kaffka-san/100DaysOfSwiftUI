//
//  ContentView.swift
//  WordScramble
//
//  Created by Anastasia Lenina on 02.06.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var newWord = ""
    @State private var rootWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var isAlertActive = false
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("", text: $newWord).textInputAutocapitalization(.never)
                }
                .onSubmit(addWord)
                .onAppear(perform: startGame)
                .alert(errorTitle, isPresented: $isAlertActive){
                    Button("OK", role: .cancel){}
                } message: {
                    Text(errorMessage)
                }
                
                Section{
                    ForEach(usedWords, id: \.self){ word in
                        HStack{
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                    }
                }
                
            }.navigationTitle(rootWord)
        }
        
    }
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    func wordError(title: String, messgae : String){
        errorTitle = title
        errorMessage = messgae
        isAlertActive = true
    }
    func isPossible(word: String) -> Bool{
        var tempRootWord = rootWord
        for char in word{
            if let pos = tempRootWord.firstIndex(of: char){
                tempRootWord.remove(at: pos)
            } else {return false}
        }
        return true
    }
    func addWord(){
        let formattedWord = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard formattedWord.count > 0 else {return}
        guard isOriginal(word: formattedWord) else{
           wordError(title: "Word used already", messgae: "Be more creative")
            return
        }
        guard isPossible(word: formattedWord) else {
            wordError(title: "Word not possible", messgae: "You can't spell it from \(rootWord)")
            return
        }
        guard isReal(word: formattedWord) else {
            wordError(title: "Word does not exist", messgae: "You have to use real words")
            return
        }
        
        usedWords.insert(formattedWord, at: 0)
        newWord = ""
    }
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let missSpellingRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en-US")
        return !(missSpellingRange.location == NSNotFound)
    }
    func startGame(){
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let allWords = try? String(contentsOf: startWordsUrl){
                let wordsArray = allWords.components(separatedBy: "\n")
                rootWord = wordsArray.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load  start.txt from the Bundle")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
