import SwiftUI

/// Exemplo de integração SwiftUI (app nativo).
struct AppleIntelligencePanelView: View {
    @StateObject private var appleIntelligence = AppleIntelligenceKernel()
    @State private var textoComando: String = ""
    @State private var resposta: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Apple Intelligence Kernel")
                .font(.title2.bold())

            Text(appleIntelligence.statusSeguranca)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            TextField("Prompt privado…", text: $textoComando)
                .textFieldStyle(.roundedBorder)

            Button("Processar com privacidade") {
                appleIntelligence.processarComandoPrivado(prompt: textoComando) { respostaNativa in
                    resposta = respostaNativa
                    print(respostaNativa)
                }
            }
            .buttonStyle(.borderedProminent)

            if !resposta.isEmpty {
                Text(resposta)
                    .padding(8)
                    .background(Color.gray.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            List(appleIntelligence.logDispositivo, id: \.self) { line in
                Text(line).font(.caption.monospaced())
            }
        }
        .padding()
    }
}

#Preview {
    AppleIntelligencePanelView()
}
