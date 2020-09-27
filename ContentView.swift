//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ping Yun on 9/27/20.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled() //array of all the country images, shuffled() randomizes array order
    @State private var correctAnswer = Int.random(in: 0...2) //auto picks random number, used to decide which country flag is correct
    @State private var showingScore = false //stores whether alert is showing or not
    @State private var scoreTitle = "" //stores title shown inside alert
    @State private var userScore = 0 //stores # of correct answers
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all) //sets background to linear gradient from blue to black that goes to edges
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white) //changes text color to white
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle) //makes text bigger
                        .fontWeight(.black) //makes text extra bold
                }
                
                ForEach(0 ..< 3) { number in
                    Button (action: {
                        //flag was tapped
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original) //tells SwiftUI to render original image pixels
                            .clipShape(Capsule()) //makes flags capsule shaped
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1)) //adds black border around flags
                            .shadow(color: .black, radius: 2) //adds shadow around flags
                    }
                }
                Spacer() //pushes UI to top of screen
            }
        }
        
        //alert presented when showingScore is true
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(userScore)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion() //dismiss button calls askQuestion() when tapped
                })
        }
    }
    
    //accepts number of tapped button, compares to correct answer, sets scoreTitle and showingScore properties
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1 //adds 1 to userScore if answer is correct
        } else {
            scoreTitle = "Wrong"
            userScore -= 1 //subtracts 1 from userScore if answer is wrong
        }
        
        showingScore = true
    }
    
    //resets game by shuffling countries array, setting new correctAnswer
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}

