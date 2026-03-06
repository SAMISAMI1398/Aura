import SwiftUI

struct ContentView: View {
    @State private var timerValue: Int = 0
    @State private var isTimerRunning: Bool = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                
                Text("Neon Fitness Timer")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .padding()

                ZStack {
                    Circle()
                        .stroke(lineWidth: 16)
                        .foregroundColor(Color.purple.opacity(0.5))
                        .padding()
                    
                    Text("\(timerValue) sec")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(Color.white)
                }
                
                Spacer()
                
                HStack {
                    Button(action: {
                        isTimerRunning.toggle()
                        if isTimerRunning {
                            startTimer()
                        }
                    }) {
                        Text(isTimerRunning ? "Pause" : "Start")
                            .font(.title2)
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Capsule().fill(Color.purple))
                            .shadow(color: Color.purple, radius: 5)
                    }
                    
                    Button(action: resetTimer) {
                        Text("Reset")
                            .font(.title2)
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Capsule().fill(Color.purple))
                            .shadow(color: Color.purple, radius: 5)
                    }
                }
                
                Spacer()
                
                ActivityGraph()
                    .padding()
            }
        }
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.isTimerRunning {
                self.timerValue += 1
            } else {
                timer.invalidate()
            }
        }
    }
  
    func resetTimer() {
        isTimerRunning = false
        timerValue = 0
    }
}

struct ActivityGraph: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Activity Graph")
                .font(.title2)
                .foregroundColor(Color.white)
            
            GeometryReader { geometry in
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    path.move(to: CGPoint(x: 0, y: height * 0.7))
                    path.addLine(to: CGPoint(x: width * 0.2, y: height * 0.5))
                    path.addLine(to: CGPoint(x: width * 0.4, y: height * 0.8))
                    path.addLine(to: CGPoint(x: width * 0.6, y: height * 0.4))
                    path.addLine(to: CGPoint(x: width * 0.8, y: height * 0.6))
                    path.addLine(to: CGPoint(x: width, y: height * 0.3))
                }
                .stroke(Color.purple, lineWidth: 3)
                .shadow(color: Color.purple, radius: 5)
            }
            .frame(height: 150)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}