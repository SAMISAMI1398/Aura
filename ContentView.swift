import SwiftUI

struct ContentView: View {
    @State private var timerValue: Int = 0
    @State private var isTimerRunning: Bool = false
    
    let gradientBackground = LinearGradient(
        gradient: Gradient(colors: [Color.black, Color.purple, Color.blue]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    var body: some View {
        ZStack {
            gradientBackground
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Text("Fitness Timer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white.opacity(0.8))
                    .padding(.top, 40)
                
                Text("\(timerValue) s")
                    .font(.system(size: 64, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        Circle()
                            .fill(Color.purple.opacity(0.8))
                            .frame(width: 200, height: 200)
                    )
                    .onTapGesture {
                        toggleTimer()
                    }
                
                HStack(spacing: 30) {
                    ActivityGraphView(progress: 0.7, title: "Steps")
                    ActivityGraphView(progress: 0.5, title: "Calories")
                    ActivityGraphView(progress: 0.9, title: "Heart Rate")
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    func toggleTimer() {
        isTimerRunning.toggle()
        if isTimerRunning {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                self.timerValue += 1
                if !self.isTimerRunning {
                    timer.invalidate()
                }
            }
        } else {
            // Reset timer or stop behavior can be implemented here
        }
    }
}

struct ActivityGraphView: View {
    var progress: CGFloat
    var title: String
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(
                        Color.gray.opacity(0.3),
                        lineWidth: 15
                    )
                    .frame(width: 100, height: 100)
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(
                        AngularGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                        center: .center),
                        style: StrokeStyle(lineWidth: 15, lineCap: .round)
                    )
                    .frame(width: 100, height: 100)
                    .rotationEffect(Angle(degrees: -90))
                
                Text("\(Int(progress * 100))%")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            Text(title)
                .foregroundColor(.white)
                .font(.subheadline)
                .padding(.top, 8)
        }
    }
}