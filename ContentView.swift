import SwiftUI

struct ContentView: View {
    @State private var timerValue: Double = 0
    @State private var isActive: Bool = false
    @State private var activityData: [CGFloat] = [0.4, 0.6, 0.8, 0.5, 0.7, 0.3, 1.0]

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                TimerView(timerValue: $timerValue, isActive: $isActive)
                    .padding(.top, 50)
                
                ActivityGraph(activityData: activityData)
                    .padding(.top, 50)
                    .padding(.horizontal, 20)
                
                Spacer()
            }
        }
    }
}

struct TimerView: View {
    @Binding var timerValue: Double
    @Binding var isActive: Bool
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text(String(format: "%.0f", timerValue))
                .font(.system(size: 72, weight: .bold))
                .foregroundColor(Color("NeonPurple"))
            
            Button(action: {
                isActive.toggle()
            }) {
                Text(isActive ? "Pause" : "Start")
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .padding()
                    .background(Color("NeonPurple"))
                    .cornerRadius(10)
            }
            .onReceive(timer) { _ in
                if isActive {
                    timerValue += 1
                }
            }
        }
    }
}

struct ActivityGraph: View {
    var activityData: [CGFloat]
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            ForEach(activityData.indices, id: \.self) { index in
                Capsule()
                    .fill(Color("NeonPurple"))
                    .frame(width: 20, height: activityData[index] * 200)
            }
        }
    }
}

private extension Color {
    static let neonPurple = Color(red: 143/255, green: 0, blue: 255/255)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}