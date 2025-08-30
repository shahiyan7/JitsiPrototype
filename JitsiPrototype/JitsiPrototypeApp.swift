//
//  JitsiPrototypeApp.swift
//  JitsiPrototype
//
//  Created by Shahiyan Khan on 30/08/25.
//

import SwiftUI
import AVFoundation

@main
struct JitsiPrototypeApp: App {
    init() {
        // Request camera and microphone permissions on app launch
        requestPermissions()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func requestPermissions() {
        // Request camera permission
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                if granted {
                    print("Camera permission granted")
                } else {
                    print("Camera permission denied")
                }
            }
        }
        
        // Request microphone permission
        AVCaptureDevice.requestAccess(for: .audio) { granted in
            DispatchQueue.main.async {
                if granted {
                    print("Microphone permission granted")
                } else {
                    print("Microphone permission denied")
                }
            }
        }
    }
}
