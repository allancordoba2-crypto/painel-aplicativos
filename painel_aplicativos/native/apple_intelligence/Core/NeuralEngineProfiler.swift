import Foundation
import OSLog
import MetricKit

final class NeuralEngineProfiler: NSObject, MXMetricManagerSubscriber {
    static let shared = NeuralEngineProfiler()
    private let logger = Logger(subsystem: "com.cortex.iaos", category: "HardwarePerformance")
    private let signpostLog = OSLog(subsystem: "com.cortex.iaos", category: "NeuralEngine")
    private(set) var ultimoResumoCPU: String = "—"
    private(set) var historicoMetricas: [String] = []

    private override init() {
        super.init()
        MXMetricManager.shared.add(self)
        logger.info("📊 Profiler da Neural Engine inicializado via MetricKit.")
    }

    deinit { MXMetricManager.shared.remove(self) }

    func didReceive(_ payloads: [MXMetricPayload]) {
        for payload in payloads {
            if let cpuMetric = payload.cpuMetrics {
                let desc = cpuMetric.cumulativeCPUTime.description
                ultimoResumoCPU = desc
                logger.log("📈 Uso de CPU: \(desc, privacy: .public)")
                anexarHistorico("CPU cumulative: \(desc)")
            }
        }
    }

    func didReceive(_ payloads: [MXDiagnosticPayload]) {
        for payload in payloads {
            logger.warning("🩺 Diagnostic: \(String(describing: payload), privacy: .public)")
        }
    }

    func rastrearGargaloArvoreIA(etapa: String) {
        os_signpost(.begin, log: signpostLog, name: "Processamento Arvore", "%{public}s", etapa)
    }

    func encerrarRastreioGargalo() {
        os_signpost(.end, log: signpostLog, name: "Processamento Arvore")
    }

    func snapshot() -> [String: Any] {
        [
            "ultimoResumoCPU": ultimoResumoCPU,
            "historicoMetricas": Array(historicoMetricas.suffix(40)),
            "subsystem": "com.cortex.iaos",
            "categoria": "HardwarePerformance",
        ]
    }

    private func anexarHistorico(_ linha: String) {
        historicoMetricas.append("\(ISO8601DateFormatter().string(from: Date())) \(linha)")
        if historicoMetricas.count > 100 {
            historicoMetricas.removeFirst(historicoMetricas.count - 100)
        }
    }
}
