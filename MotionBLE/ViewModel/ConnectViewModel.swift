
import Foundation

final class ConnectViewModel: ObservableObject {
    @Published var state = State.idle
    @Published var eixoX: Float = 0.0
    @Published var eixoY: Float = 0.0
    @Published var eixoZ: Float = 0.0
    
    var useCase: PeripheralUseCaseProtocol
    let connectedPeripheral: Peripheral
    
    init(useCase: PeripheralUseCaseProtocol,
         connectedPeripheral: Peripheral) {
        self.useCase = useCase
        self.useCase.peripheral = connectedPeripheral
        self.connectedPeripheral = connectedPeripheral
        self.setCallbacks()
    }
    
    private func setCallbacks() {
        useCase.onPeripheralReady = { [weak self] in
            self?.state = .ready
        }
        
        useCase.onWriteLedState = { [weak self] value in
            self?.state = .ledState(value)
        }
        
        useCase.onError = { error in
            print("Error \(error)")
        }
        
        useCase.onReadAccelerometer = { [weak self] x, y, z in
            DispatchQueue.main.async {
                self?.eixoX = x
                self?.eixoY = y
                self?.eixoZ = z
            }
        }
    }
    
    func turnOnLed() {
        useCase.writeLedState(isOn: true)
    }
    
    func turnOffLed() {
        useCase.writeLedState(isOn: false)
    }
}

extension ConnectViewModel {
    enum State {
        case idle
        case ready
        case ledState(Bool)
    }
}
