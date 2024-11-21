
import Foundation
import CoreBluetooth

enum UUIDs {
    static let ledService = CBUUID(string: "cd48409a-f3cc-11ed-a05b-0242ac120003")
    static let ledStatusCharacteristic = CBUUID(string:  "cd48409b-f3cc-11ed-a05b-0242ac120003") // Write
    
    static let accelerometerService = CBUUID(string: "12345678-1234-5678-1234-56789abcdef0")
    static let accelerometerCharacteristic = CBUUID(string: "12345678-1234-5678-1234-56789abcdef1")

}
