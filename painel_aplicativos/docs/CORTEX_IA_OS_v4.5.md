# Cortex IA OS v4.5

Componentes: MetricKit profiler, SF Symbols, Xcode Cloud, XCTest.

## Árvore

- `native/apple_intelligence/Core/NeuralEngineProfiler.swift`
- `native/apple_intelligence/UI/SFSymbolsIntegrator.swift`
- `native/apple_intelligence/Tests/CortexSecurityTests.swift`
- `.xcodecloud/ci_post_xcodebuild.sh`

## Xcode Cloud

1. Xcode → Xcode Cloud → Create Workflow
2. Repo GitHub `painel-aplicativos`
3. Scripts em `.xcodecloud/` rodam automaticamente
4. Post-action TestFlight no workflow

Docs Apple: https://developer.apple.com/xcode-cloud/
