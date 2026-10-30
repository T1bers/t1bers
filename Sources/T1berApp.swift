import SwiftUI

@main
struct T1berApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}

struct ContentView: View {
    @State private var showEgg = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 40) {
                Text("Посхалка t1ber для долбаеба")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .padding(.horizontal)

                Button {
                    showEgg = true
                } label: {
                    Text("Пасхалка")
                        .font(.title2.bold())
                        .padding(.horizontal, 40)
                        .padding(.vertical, 16)
                        .background(Capsule().fill(Color.blue))
                        .foregroundStyle(.white)
                }
            }
        }
        .fullScreenCover(isPresented: $showEgg) {
            EasterEggView()
        }
    }
}

struct EasterEggView: View {
    @Environment(\.dismiss) private var dismiss

    private func wrap(_ v: Double) -> Double {
        v - floor(v)
    }

    var body: some View {
        TimelineView(.animation) { context in
            let t = context.date.timeIntervalSinceReferenceDate
            let hue = wrap(t * 0.35)

            ZStack {
                Color.black.ignoresSafeArea()

                Text("Ну вот говорю же долбаеб")
                    .font(.system(size: 42, weight: .heavy, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                Color(hue: hue, saturation: 1, brightness: 1),
                                Color(hue: wrap(hue + 0.33), saturation: 1, brightness: 1),
                                Color(hue: wrap(hue + 0.66), saturation: 1, brightness: 1)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .shadow(color: Color(hue: hue, saturation: 1, brightness: 1), radius: 20)
                    .scaleEffect(1 + 0.08 * sin(t * 4))
                    .rotationEffect(.degrees(3 * sin(t * 2)))
                    .padding()
            }
        }
        .onTapGesture { dismiss() }
    }
}
