//
//  ContentView.swift
//  Multiply Challendge
//
//  Created by Anastasia Lenina on 16.06.2023.
//



import SwiftUI

struct gameView: View{
    @State private var userAnswear = ""
    @State private var isAlertShown = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var correctAnswear = 0
    var selectedDifficulty = 0
    var multiplicationTable = 0
    @State private var generated = ""
    @State private var correct = 0
    init( selectedDifficulty: Int = 0, multiplicationTable: Int = 0) {

        self.selectedDifficulty = selectedDifficulty
        self.multiplicationTable = multiplicationTable

    }
    var body: some View{
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.pink,.orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack{
                Spacer()
                VStack{
                    Text(generated)
                        .font(.title2)
                        .fontWeight(.bold)
                    TextField(
                        "Type the answear",
                        text: $userAnswear
                    )
                    .keyboardType(.decimalPad)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding()
                    .border(.secondary)
                   
                    
                }
                .padding(40)
                .frame(width: 330, height: 300)
                .background(.ultraThinMaterial)
                .foregroundColor(.white)
                .cornerRadius(30)
                .padding()
                Spacer()
                Button("Check"){
                    checkAnswear()
                    isAlertShown = true
                }
                .frame(width: 200, height: 80)
                .background(Color.pink)
                .fontWeight(.bold)
                .cornerRadius(15)
                .alert(isPresented: $isAlertShown) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("again")){
                        generated = createOperation()
                    })
                    
                }
                
            }
            .onAppear(){
                generated = createOperation()
            }
         
        }
    }
    func checkAnswear() {
        if let safeUserInput = Int(userAnswear){
            if safeUserInput == self.correct{
                alertTitle = "Congratulations!🎉"
                alertMessage = "You got it right"
                
            }
            else{
                alertTitle = "Sorry!😢"
                alertMessage = "You got it wrong"
               
            }
        }
    }
    func generateNumber() -> Int{
        
        var num = multiplicationTable
        if selectedDifficulty == 0{
            num = Int.random(in: 1...4)
        } else if selectedDifficulty == 1{
            num = Int.random(in: 5...8)
        } else {
            num = Int.random(in: 9...12)
        }
        return num
    }
    func createOperation()-> String{
        userAnswear = ""
        let num1 = generateNumber()
        let num2 = multiplicationTable
        self.correct = num1 * num2
        return String("\(num1) * \(num2) = ?")
    }
   
}

struct ContentView: View {
    let difficulties = ["easy 🌸", "normal 🍬", "hard 🦄"]
    @State private var multiplicationTable = 2
    @State private var selectedDifficulty = "easy 🌸"
    @State private var isShowingDetailView = false
  
    var body: some View{
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.indigo,.mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack{
                    Spacer()
                    VStack(alignment: .leading){
                        Text("Select multiplication Table")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        
                        Stepper(value: $multiplicationTable, in: 2...12){
                            Text("For number: \(multiplicationTable)")
                                .fontWeight(.bold)
                            
                            
                        }
                        Divider()
                        Text("Select Difficulty")
                            .font(.title2)
                            .fontWeight(.bold)
                        Picker("", selection: $selectedDifficulty) {
                            ForEach(difficulties, id: \.self){
                                Text($0).foregroundColor(Color.white)
                                
                            }
                            
                        }.pickerStyle(.segmented)
                            .foregroundColor(.white)
                        
                        
                        
                        
                    }
                    .padding(40)
                    .frame(width: 330, height: 300)
                    .background(.ultraThinMaterial)
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .padding()
                    Spacer()
                    VStack{
                        NavigationLink( "", isActive: $isShowingDetailView){
                            gameView(selectedDifficulty: difficulties.firstIndex(of: selectedDifficulty) ?? 0, multiplicationTable: multiplicationTable)
                        }
                        Button("Start Game"){
                            isShowingDetailView = true
                        }
                        .frame(width: 200, height: 80)
                        .background(Color.indigo)
                        
                        .fontWeight(.bold)
                        .cornerRadius(15)
                    }
                    
                    
                }
                
                
                
                
            }    .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image(systemName: "gamecontroller.fill")
                            .foregroundColor(.white)
                        Text("Multiplication Game")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                }
            }
            
            
            
            
            
        }.accentColor(.white)
        
    }
   
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
