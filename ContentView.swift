import SwiftUI

struct ContentView: View {
    @State private var timerValue: Int = 0
    @State private var isTimerRunning: Bool = false
    @State private var activityData: [CGFloat] = [0.2, 0.4, 0.6, 0.8, 0.5, 0.7, 0.3]
    @State private var timer: Timer? = nil

    var body: some View {
        ZStack {
            // Background
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Aura Fitness")
                    .font(.largeTitle)
                    .foregroundColor(.neonPurple)
                    .padding(.top, 50)
                
                Spacer()
                
                // Timer
                Text("\(timerValue)")
                    .font(.system(size: 80, weight: .bold))
                    .foregroundColor(.neonPurple)
                
                HStack(spacing: 30) {
                    Button(action: startTimer) {
                        Text(isTimerRunning ? "Pause" : "Start")
                            .font(.title)
                            .foregroundColor(.black)
                            .frame(width: 120, height: 50)
                            .background(Color.neonPurple)
                            .cornerRadius(10)
                    }
                    
                    Button(action: resetTimer) {
                        Text("Reset")
                            .font(.title)
                            .foregroundColor(.black)
                            .frame(width: 120, height: 50)
                            .background(Color.neonPurple)
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom, 50)

                // Activity Graph
                ActivityGraph(data: activityData)
                    .frame(height: 200)
                    .padding()
                
                Spacer()
            }
        }
    }
    
    func startTimer() {
        isTimerRunning.toggle()
        if isTimerRunning {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                timerValue += 1
            }
        } else {
            timer?.invalidate()
        }
    }
    
    func resetTimer() {
        timer?.invalidate()
        timerValue = 0
        isTimerRunning = false
    }
}

struct ActivityGraph: View {
    var data: [CGFloat]
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width / CGFloat(data.count)
            let maxHeight = geometry.size.height
            
            HStack(alignment: .bottom) {
                ForEach(data.indices) { index in
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.neonPurple, .black]), startPoint: .top, endPoint: .bottom))
                        .frame(width: width, height: maxHeight * data[index])
                        .cornerRadius(5)
                }
            }
        }
    }
}

extension Color {
    static let neonPurple = Color(red: 148/255, green: 0, blue: 211/255)
}

#Preview {
    ContentView()
}