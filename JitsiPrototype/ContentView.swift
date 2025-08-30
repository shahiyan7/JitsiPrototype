//
//  ContentView.swift
//  JitsiPrototype
//
//  Created by Shahiyan Khan on 30/08/25.
//

import SwiftUI

struct ContentView: View {
    @State private var roomIdentifier = ""
    @State private var participantName = ""
    @State private var showVideoCall = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Video Conference")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your Name")
                            .font(.headline)
                        TextField("Enter your display name", text: $participantName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Conference Room")
                            .font(.headline)
                        TextField("Enter room identifier", text: $roomIdentifier)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                .padding(.horizontal)
                
                Button(action: {
                    if !roomIdentifier.isEmpty && !participantName.isEmpty {
                        showVideoCall = true
                    }
                }) {
                    Text("Start Conference")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            (roomIdentifier.isEmpty || participantName.isEmpty) 
                            ? Color.gray 
                            : Color.green
                        )
                        .cornerRadius(10)
                }
                .disabled(roomIdentifier.isEmpty || participantName.isEmpty)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Conference App")
            .fullScreenCover(isPresented: $showVideoCall) {
                VideoCallBridge(
                    roomName: roomIdentifier,
                    userName: participantName,
                    isActive: $showVideoCall
                )
                .ignoresSafeArea()
            }
        }
        .onAppear {
            if participantName.isEmpty {
                participantName = "My name"
            }
            if roomIdentifier.isEmpty {
                roomIdentifier = "test"
            }
        }
    }
}

#Preview {
    ContentView()
}
