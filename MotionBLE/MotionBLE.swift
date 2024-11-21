
import SwiftUI

@main
struct MotionBLE: App {
    
    @StateObject var viewModel = ScanViewModel(useCase: CentralUseCase())
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ScanView(viewModel: viewModel)
            }
        }
    }
}
