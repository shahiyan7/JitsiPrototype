import SwiftUI
import UIKit

struct VideoCallBridge: UIViewControllerRepresentable {
    let roomName: String
    let userName: String
    @Binding var isActive: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> VideoCallViewController {
        let controller = VideoCallViewController()
        controller.roomIdentifier = roomName
        controller.participantName = userName
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: VideoCallViewController, context: Context) {
        
    }
    
    static func dismantleUIViewController(_ uiViewController: VideoCallViewController, coordinator: Coordinator) {
        uiViewController.disconnectFromCall()
    }
    
    class Coordinator: NSObject, VideoCallViewControllerDelegate {
        var parent: VideoCallBridge
        
        init(_ parent: VideoCallBridge) {
            self.parent = parent
            super.init()
        }
        
        func videoCallDidEnd() {
            parent.isActive = false
        }
    }
}