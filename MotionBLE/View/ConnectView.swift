
import SwiftUI
import UIKit

struct ConnectView: View {
    
    @ObservedObject var viewModel: ConnectViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State var isToggleOn: Bool = false
    @State var isPeripheralReady: Bool = false
    @State var lastTemperature: Int = 0

    var body: some View {
        VStack {
            Text(viewModel.connectedPeripheral.name ?? "Unknown")
                .font(.title)
            VStack {
                Text("Acelerômetro:")
                    .font(.headline)
                Text("X: \(viewModel.eixoX, specifier: "%.2f")")
                Text("Y: \(viewModel.eixoY, specifier: "%.2f")")
                Text("Z: \(viewModel.eixoZ, specifier: "%.2f")")
                Spacer()
            }
            ZStack {
//                CardView()
                HStack {
                    Text("Led")
                        .padding(.horizontal)
                    Button("On") {
                        viewModel.turnOnLed()
                    }
                    .disabled(!isPeripheralReady)
                    .buttonStyle(.borderedProminent)
                    Button("Off") {
                        viewModel.turnOffLed()
                    }
                    .disabled(!isPeripheralReady)
                    .buttonStyle(.borderedProminent)
                }
            }
            
            
            Spacer()
                .frame(maxHeight:.infinity)
            Button {
                dismiss()
            } label: {
                Text("Disconnect")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
        }
        .onReceive(viewModel.$state) { state in
            switch state {
            case .ready:
                isPeripheralReady = true
            default:
                print("Not handled")
            }
        }
    }
}

//struct PeripheralView_Previews: PreviewProvider {
//    
//    final class FakeUseCase: PeripheralUseCaseProtocol {
//        
//        var peripheral: Peripheral?
//        
//        var onWriteLedState: ((Bool) -> Void)?
//        var onReadTemperature: ((Int) -> Void)?
//        var onPeripheralReady: (() -> Void)?
//        var onError: ((Error) -> Void)?
//
//        func writeLedState(isOn: Bool) {}
//        
//        func readTemperature() {
//            onReadTemperature?(25)
//        }
//        
//        func notifyTemperature(_ isOn: Bool) {}
//    }
//    
//    static var viewModel = {
//        ConnectViewModel(useCase: FakeUseCase(),
//                            connectedPeripheral: .init(name: "iOSArduinoBoard"))
//    }()
//    
//    
//    static var previews: some View {
//        ConnectView(viewModel: viewModel, isPeripheralReady: true)
//    }
//}
//
//struct CardView: View {
//  var body: some View {
//    RoundedRectangle(cornerRadius: 16, style: .continuous)
//      .shadow(color: Color(white: 0.5, opacity: 0.2), radius: 6)
//      .foregroundColor(.init(uiColor: .secondarySystemBackground))
//  }
//}
