import Flutter
import UIKit

/// Bridge Flutter ↔ AppleIntelligenceKernel (MethodChannel).
public class AppleIntelligencePlugin: NSObject, FlutterPlugin {
    public static let channelName = "painel_aplicativos/apple_intelligence"

    private let kernel = AppleIntelligenceKernel()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: channelName,
            binaryMessenger: registrar.messenger()
        )
        let instance = AppleIntelligencePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getStatus":
            result(kernel.snapshot())

        case "processarComando":
            guard
                let args = call.arguments as? [String: Any],
                let prompt = args["prompt"] as? String
            else {
                result(FlutterError(
                    code: "bad_args",
                    message: "Esperado { prompt: String }",
                    details: nil
                ))
                return
            }
            kernel.processarComandoPrivado(prompt: prompt) { resposta in
                result([
                    "resposta": resposta,
                    "snapshot": self.kernel.snapshot(),
                ])
            }

        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
