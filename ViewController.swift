//
//  ViewController.swift
//  Scribe
//
//  Created by Luke Klepfer on 10/24/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.isHidden = true
        self.audioPlayer.delegate = self
        
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        spinner.isHidden = true
        spinner.stopAnimating()
    }
    
    
    @IBAction func btnPress(_ sender: AnyObject) {
        spinner.isHidden = false
        spinner.startAnimating()
        reqSpeechAuth()
        
    }
    
    func reqSpeechAuth(){
        SFSpeechRecognizer.requestAuthorization {authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized{
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a", subdirectory: nil, localization: nil){
                    do{
                        let sound = try AVAudioPlayer(contentsOf: path, fileTypeHint: "m4a")
                        self.audioPlayer = sound
                        sound.play()
                    }catch{
                            print("Sound Error!!")
                    }
                    
                    let recog = SFSpeechRecognizer()
                    let reque = SFSpeechURLRecognitionRequest(url: path)
                    recog?.recognitionTask(with: reque) { (result, error) in
                        if let error = error{
                            print("Recongnition error: \(error)")
                        }else{
                            //print(result?.bestTranscription.formattedString)
                            self.textField.text = result?.bestTranscription.formattedString
                        }
                    }
                }
            }
        }
    }
    
}

