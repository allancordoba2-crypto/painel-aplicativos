import XCTest

final class CortexSecurityTests: XCTestCase {
    func testConfigDefaultsSeguros() {
        let config = AppleIntelligenceConfig.defaults
        XCTAssertTrue(config.secureEnclaveEnforcement)
        XCTAssertGreaterThan(config.maxTokenContextLimit, 0)
    }

    func testSFSymbolsMapeamentoBasico() {
        XCTAssertEqual(SFSymbolsIntegrator.mapearIconeParaSymbol("🛡️"), "shield.checkered")
        XCTAssertEqual(SFSymbolsIntegrator.mapearIconeParaSymbol("🧠"), "brain.head.profile")
    }

    func testProfilerSingleton() {
        XCTAssertTrue(NeuralEngineProfiler.shared === NeuralEngineProfiler.shared)
        XCTAssertEqual(NeuralEngineProfiler.shared.snapshot()["subsystem"] as? String, "com.cortex.iaos")
    }
}
