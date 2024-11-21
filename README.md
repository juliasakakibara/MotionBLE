# **MotionBLE iOS App**

[![Swift Version](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)  
[![SwiftUI Version](https://img.shields.io/badge/SwiftUI-2.0-green.svg)](https://developer.apple.com/documentation/swiftui)  
[![Xcode Version](https://img.shields.io/badge/Xcode-14.3-blue.svg)](https://developer.apple.com/xcode/)

## **Description**

The [**MotionBLE iOS App**](https://github.com/juliasakakibara/MotionBLE_ArduinoSketch) allows scanning and connecting to Bluetooth Low Energy (BLE) devices that advertise specific services and characteristics. 
The app has two main screens:

- **Scan:** Searches for and displays nearby BLE devices. Once a device is selected, a connection can be established.
- **Connect:** Allows interaction with the characteristics of the connected BLE device:
  - **Read and Notify:** Receives data from the peripheral and displays real-time updates.
  - **Write:** Sends commands to the peripheral, such as turning the built-in LED on or off.

The app is built using the [CoreBluetooth](https://developer.apple.com/documentation/corebluetooth) framework to manage Bluetooth connectivity.

---

## **BLE Characteristics**

The app supports the following BLE characteristics:

| Characteristic           | UUID                                     | Service                                   |
| ------------------------ | ---------------------------------------- | ----------------------------------------- |
| Read and Notify           | `d888a9c3-f3cc-11ed-a05b-0242ac120003`   | `d888a9c2-f3cc-11ed-a05b-0242ac120003`   |
| Write                     | `cd48409b-f3cc-11ed-a05b-0242ac120003`   | `cd48409a-f3cc-11ed-a05b-0242ac120003`   |

---

## **Modifications**

This project is adapted from the original work by [Leonardo Cavagnis](https://github.com/leonardocavagnis) and [Andrea Finollo](https://github.com/DrAma999). 

### Adaptations:
1. Added support for real-time accelerometer data reading (X, Y, Z axes).
2. Modified to work with an Arduino Nano RP2040 Connect powered by an external battery.
3. Updated design to reflect the new project name: **MotionBLE**.

The corresponding Arduino sketch for this app can be found here:  
[MotionBLE Arduino Sketch Repository](https://github.com/yourusername/MotionBLE_ArduinoSketch)

---

## **Languages, Tools, and Environment**

- **Swift 5.0**
- **SwiftUI**
- **Xcode 14.3**

---

## **Device Compatibility**

This app works exclusively on physical iOS devices (iPhones). It cannot run on simulators due to the lack of Bluetooth support.

---

## **Authors**

This project was developed by:
- [Leonardo Cavagnis](https://github.com/leonardocavagnis)
- [Andrea Finollo](https://github.com/DrAma999)
- Original repositories:
  [Medium](https://leonardocavagnis.medium.com/from-arduino-programming-to-ios-app-development-8b5da1783e1e)
  [iOSArduinoBLE iOS App](https://github.com/leonardocavagnis/iOSArduinoBLE_iOSApp)
  [iOSArduinoBLE Arduino Sketch](https://github.com/leonardocavagnis/iOSArduinoBLE_ArduinoSketch)


Adaptations made by:
- **[Your Name]**

---

## **License**

This project is licensed under the MIT License. See the `LICENSE` file for more details.
