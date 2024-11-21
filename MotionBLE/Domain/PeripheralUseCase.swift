import Foundation
import CoreBluetooth

protocol PeripheralUseCaseProtocol {

    var peripheral: Peripheral? { get set }
    
    var onWriteLedState: ((Bool) -> Void)? { get set }
    var onReadAccelerometer: ((Float, Float, Float) -> Void)? { get set } // New callback for accelerometer
    var onPeripheralReady: (() -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }

    func writeLedState(isOn: Bool)
    func readLedStatus()
    func readAccelerometer() // New method for reading accelerometer data
    func notifyAccelerometer(_ isOn: Bool) // New method for subscribing to accelerometer notifications
}

class PeripheralUseCase: NSObject, PeripheralUseCaseProtocol {
    func readLedStatus() {
        print("azar")
    }
    

    var peripheral: Peripheral? {
        didSet {
            self.peripheral?.cbPeripheral?.delegate = self
            cbPeripheral?.discoverServices(nil) // Descobre os serviços
        }
    }
    
    var cbPeripheral: CBPeripheral? {
        peripheral?.cbPeripheral
    }
    
    var onWriteLedState: ((Bool) -> Void)?
    var onReadTemperature: ((Int) -> Void)?
    var onReadAccelerometer: ((Float, Float, Float) -> Void)? // New callback implementation
    var onPeripheralReady: (() -> Void)?
    var onError: ((Error) -> Void)?

    private var ledCharacteristic: CBCharacteristic?
    private var accelerometerCharacteristic: CBCharacteristic? // New characteristic for accelerometer

    func writeLedState(isOn: Bool) {
        guard let ledCharacteristic = cbPeripheral?.services?
            .flatMap({ $0.characteristics ?? [] })
            .first(where: { $0.uuid == UUIDs.ledStatusCharacteristic }) else { return }
        let value: UInt8 = isOn ? 1 : 0
        cbPeripheral?.writeValue(Data([value]), for: ledCharacteristic, type: .withResponse)
    }
        
    func readAccelerometer() { // New method
        guard let accelerometerCharacteristic = accelerometerCharacteristic else { return }
        cbPeripheral?.readValue(for: accelerometerCharacteristic)
    }
    
    func notifyAccelerometer(_ isOn: Bool) { // New method
        guard let accelerometerCharacteristic = accelerometerCharacteristic else { return }
        cbPeripheral?.setNotifyValue(isOn, for: accelerometerCharacteristic)
    }
}

extension PeripheralUseCase: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard error == nil else {
            print("Error discovering services: \(error!)")
            onError?(error!)
            return
        }
        print("Services discovered: \(String(describing: peripheral.services))")
        peripheral.services?.forEach { service in
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard error == nil else {
            print("Error discovering characteristics: \(error!)")
            onError?(error!)
            return
        }
        print("Characteristics discovered for service: \(service.uuid)")
        service.characteristics?.forEach { characteristic in
            print("Characteristic: \(characteristic.uuid)")
            switch characteristic.uuid {
            case UUIDs.ledStatusCharacteristic:
                ledCharacteristic = characteristic
            case UUIDs.accelerometerCharacteristic:
                accelerometerCharacteristic = characteristic
                print("Accelerometer characteristic found, enabling notifications...")
                peripheral.setNotifyValue(true, for: characteristic)
            default:
                break
            }
        }
        onPeripheralReady?()
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard error == nil else {
            print("Error updating value for characteristic: \(error!)")
            onError?(error!)
            return
        }

        if characteristic == accelerometerCharacteristic,
           let value = characteristic.value, value.count == 12 {
            let x = value.withUnsafeBytes { $0.load(fromByteOffset: 0, as: Float.self) }
            let y = value.withUnsafeBytes { $0.load(fromByteOffset: 4, as: Float.self) }
            let z = value.withUnsafeBytes { $0.load(fromByteOffset: 8, as: Float.self) }
            print("Accelerometer Data - X: \(x), Y: \(y), Z: \(z)")
            onReadAccelerometer?(x, y, z)
        }
    }

}
