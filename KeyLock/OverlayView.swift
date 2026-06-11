import SwiftUI

struct OverlayView: View {
    @ObservedObject var appState: AppState
    @State private var isPulsing = false
    
    var body: some View {
        ZStack {
            // Elegant solid-dark background to highlight keyboard smudges & screen dust
            Color.black.opacity(0.94)
                .ignoresSafeArea()
            
            VStack(spacing: 48) {
                // Central Glowing Security Shield
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color.blue.opacity(0.15), Color.clear],
                                center: .center,
                                startRadius: 0,
                                endRadius: 120
                            )
                        )
                        .frame(width: 240, height: 240)
                    
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 80, weight: .light))
                        .foregroundColor(.blue)
                        .shadow(color: .blue.opacity(0.6), radius: isPulsing ? 25 : 12)
                        .scaleEffect(isPulsing ? 1.06 : 0.94)
                        .animation(
                            .easeInOut(duration: 2.5).repeatForever(autoreverses: true),
                            value: isPulsing
                        )
                }
                .onAppear {
                    isPulsing = true
                }
                
                // Status Description
                VStack(spacing: 16) {
                    Text("Cleaning Mode Active")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .tracking(1.8)
                    
                    Text("Keyboard, trackpad, and mouse are temporarily locked.")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.5))
                }
                
                // Unlock Progress & Interaction instructions
                VStack(spacing: 20) {
                    Text("Press ESC 5 times rapidly to unlock")
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundColor(.white.opacity(0.4))
                        .tracking(1.0)
                    
                    HStack(spacing: 16) {
                        ForEach(0..<5) { index in
                            Circle()
                                .fill(index < appState.escPresses.count ? Color.blue : Color.white.opacity(0.12))
                                .frame(width: 14, height: 14)
                                .shadow(
                                    color: index < appState.escPresses.count ? Color.blue.opacity(0.9) : Color.clear,
                                    radius: 8
                                )
                                .scaleEffect(index < appState.escPresses.count ? 1.35 : 1.0)
                                .animation(
                                    .spring(response: 0.35, dampingFraction: 0.55),
                                    value: appState.escPresses.count
                                )
                        }
                    }
                    .padding(.vertical, 8)
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 24)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.02))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white.opacity(0.06), lineWidth: 1.5)
                        )
                )
            }
        }
    }
}

#Preview {
    OverlayView(appState: AppState())
}
