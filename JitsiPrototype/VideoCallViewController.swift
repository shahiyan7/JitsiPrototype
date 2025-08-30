import UIKit
import JitsiMeetSDK

protocol VideoCallViewControllerDelegate: AnyObject {
    func videoCallDidEnd()
}

class VideoCallViewController: UIViewController {
    
    var roomIdentifier: String = "default-room"
    var participantName: String = "Anonymous"
    weak var delegate: VideoCallViewControllerDelegate?
    
    private var videoCallInterface: JitsiMeetView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoCallInterface = JitsiMeetView()
        videoCallInterface.delegate = self
        videoCallInterface.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(videoCallInterface)
        
        NSLayoutConstraint.activate([
            videoCallInterface.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            videoCallInterface.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoCallInterface.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoCallInterface.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        connectToVideoCall()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        videoCallInterface.leave()
    }
    
    private func connectToVideoCall() {
        let conferenceSettings = JitsiMeetConferenceOptions.fromBuilder { [self] builder in
            builder.serverURL = URL(string: "https://meet.jit.si")
            builder.room = roomIdentifier
            builder.userInfo = JitsiMeetUserInfo(displayName: participantName, andEmail: nil, andAvatar: nil)
            builder.setAudioMuted(false)
            builder.setVideoMuted(false)
            builder.setFeatureFlag("ios.screensharing.enabled", withBoolean: true)
            builder.setFeatureFlag("welcomepage.enabled", withBoolean: false)
            builder.setFeatureFlag("chat.enabled", withBoolean: true)
            builder.setFeatureFlag("hangup.enabled", withBoolean: true)
            builder.setFeatureFlag("toolbox.enabled", withBoolean: true)
        }
        
        videoCallInterface.join(conferenceSettings)
    }
    
    func disconnectFromCall() {
        videoCallInterface.leave()
        delegate?.videoCallDidEnd()
    }
}

extension VideoCallViewController: JitsiMeetViewDelegate {
    
    func conferenceJoined(_ data: [AnyHashable : Any]!) {
        
    }
    
    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        DispatchQueue.main.async {
            self.delegate?.videoCallDidEnd()
        }
    }
    
    func conferenceWillJoin(_ data: [AnyHashable : Any]!) {
        
    }
    
    func participantJoined(_ data: [AnyHashable : Any]!) {
        
    }
    
    func participantLeft(_ data: [AnyHashable : Any]!) {
        
    }
    
    func enterPicture(inPicture data: [AnyHashable : Any]!) {
        
    }
    
    func exitPicture(inPicture data: [AnyHashable : Any]!) {
        
    }
    
    func conferenceWillLeave(_ data: [AnyHashable : Any]!) {
        DispatchQueue.main.async {
            self.delegate?.videoCallDidEnd()
        }
    }
    
    func hangUp(_ data: [AnyHashable : Any]!) {
        DispatchQueue.main.async {
            self.delegate?.videoCallDidEnd()
        }
    }
}