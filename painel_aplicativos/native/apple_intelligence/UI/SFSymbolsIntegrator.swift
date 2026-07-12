import SwiftUI

struct CortexLogEntry: Identifiable, Equatable {
    let id: UUID
    let icone: String
    let mensagem: String
    let timestamp: Date
    init(id: UUID = UUID(), icone: String, mensagem: String, timestamp: Date = Date()) {
        self.id = id; self.icone = icone; self.mensagem = mensagem; self.timestamp = timestamp
    }
}

enum SFSymbolsIntegrator {
    static func mapearIconeParaSymbol(_ emoji: String) -> String {
        switch emoji {
        case "🛡️", "shield": return "shield.checkered"
        case "☁️", "cloud": return "cloud.sun.bolt.fill"
        case "🧠", "brain": return "brain.head.profile"
        case "💻", "terminal": return "terminal.fill"
        case "🎙️", "mic": return "waveform.and.mic"
        case "🔐", "lock": return "lock.shield.fill"
        case "📈", "chart": return "chart.line.uptrend.xyaxis"
        default: return "cpu"
        }
    }

    static func iconeParaMensagem(_ mensagem: String) -> String {
        let m = mensagem.lowercased()
        if m.contains("secure") || m.contains("enclave") || m.contains("privad") { return "🛡️" }
        if m.contains("cloud") || m.contains("pcc") { return "☁️" }
        if m.contains("neural") || m.contains("modelo") || m.contains("engine") { return "🧠" }
        if m.contains("siri") || m.contains("voz") { return "🎙️" }
        if m.contains("cpu") || m.contains("metric") { return "📈" }
        return "💻"
    }
}

struct CortexLogListView: View {
    let logs: [CortexLogEntry]
    let estaProcessando: Bool
    var body: some View {
        ForEach(logs) { log in
            HStack(spacing: 12) {
                Image(systemName: SFSymbolsIntegrator.mapearIconeParaSymbol(log.icone))
                    .font(.title3)
                    .symbolEffect(.bounce, value: estaProcessando)
                Text(log.mensagem).font(.subheadline)
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}
