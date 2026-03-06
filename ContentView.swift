import SwiftUI

struct ContentView: View {
    @State private var timerRunning = false
    @State private var timeRemaining = 30
    
    let neonPurple = Color(red: 138/255, green: 43/255, blue: 226/255)
    let darkBackground = Color.black
    
    var body: some View {
        ZStack {
            darkBackground.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                VStack {
                    Text("Fitness Aura")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(neonPurple)
                    
                    Text("Future of Fitness Tracking")
                        .foregroundColor(neonPurple.opacity(0.7))
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 15)
                        .fill(neonPurple.opacity(0.3))
                        .frame(width: 200, height: 200)
                    
                    Text("\(timeRemaining)s")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(neonPurple)
                        .onAppear {
                            timerRunning = true
                            startTimer()
                        }
                }
                
                Spacer()
                
                VStack {
                    HStack {
                        Text("Activity")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(neonPurple)
                        
                        Spacer()
                    }
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [neonPurple, .clear]), startPoint: .top, endPoint: .bottom)
                            )
                            .frame(width: 50, height: 150)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [neonPurple, .clear]), startPoint: .top, endPoint: .bottom)
                            )
                            .frame(width: 50, height: 100)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [neonPurple, .clear]), startPoint: .top, endPoint: .bottom)
                            )
                            .frame(width: 50, height: 130)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [neonPurple, .clear]), startPoint: .top, endPoint: .bottom)
                            )
                            .frame(width: 50, height: 180)
                    }
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
    
    func startTimer() {
        if timerRunning {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timer.invalidate()
                    timerRunning = false
                }
            }
        }
    }
}