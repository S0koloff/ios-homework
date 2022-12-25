//
//  AudioViewController.swift
//  Navigation
//
//  Created by Sokolov on 24.12.2022.
//

import UIKit
import AVFoundation

final class AudioViewController: UIViewController {
    
    var player = AVAudioPlayer()
    
    var songs:[Song] = []
    
    var position = 0

    private lazy var musicNameLabel: UILabel = {
        let musicNameLabel = UILabel()
        musicNameLabel.textColor = .systemBlue
        musicNameLabel.textAlignment = .center
        musicNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return musicNameLabel
    }()
    
    private lazy var playButton = CustomButton(title: "Play", titleColor: .white, backgroundButtonColor: .systemBlue, cornerRadius: 6, useShadow: false, action: { self.playButtonTap()})
    
    private lazy var stopButton = CustomButton(title: "Stop", titleColor: .white, backgroundButtonColor: .systemBlue, cornerRadius: 6, useShadow: false, action: { self.stopButtonTap()})
    
    private lazy var nextAudioButton = CustomButton(title: "Next", titleColor: .white, backgroundButtonColor: .systemBlue, cornerRadius: 6, useShadow: false, action: { self.nextButtonTap()})
    
    private lazy var backAudioButton = CustomButton(title: "Back", titleColor: .white, backgroundButtonColor: .systemBlue, cornerRadius: 6, useShadow: false, action: { self.backButtonTap()})
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.view.backgroundColor = .systemBackground
        
        songs.append(Song(name: "Gem Club - Twins"))
        songs.append(Song(name: "KDrew - Bullseye"))
        songs.append(Song(name: "Motorama - Letter Home"))
        songs.append(Song(name: "Nils Frahm - La"))
        songs.append(Song(name: "Nils Frahm - Sol"))
        
        configuratePlayer()
    }
    
    private func setupView() {
        
        self.view.addSubview(self.musicNameLabel)
        self.view.addSubview(self.playButton)
        self.view.addSubview(self.stopButton)
        self.view.addSubview(self.nextAudioButton)
        self.view.addSubview(self.backAudioButton)
        
        NSLayoutConstraint.activate([
            
            self.musicNameLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            self.musicNameLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            self.musicNameLabel.bottomAnchor.constraint(equalTo: self.playButton.topAnchor, constant: -50),
            self.musicNameLabel.topAnchor.constraint(equalTo: self.musicNameLabel.bottomAnchor, constant: -30),
            
            self.nextAudioButton.leftAnchor.constraint(equalTo: self.playButton.rightAnchor, constant: 15),
            self.nextAudioButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40),
            self.nextAudioButton.bottomAnchor.constraint(equalTo: self.stopButton.bottomAnchor, constant: -15),
            self.nextAudioButton.topAnchor.constraint(equalTo: self.playButton.topAnchor, constant: 15),
            
            self.backAudioButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40),
            self.backAudioButton.rightAnchor.constraint(equalTo: self.playButton.leftAnchor, constant: -15),
            self.backAudioButton.bottomAnchor.constraint(equalTo: self.stopButton.bottomAnchor, constant: -15),
            self.backAudioButton.topAnchor.constraint(equalTo: self.playButton.topAnchor, constant: 15),

            self.playButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 150),
            self.playButton.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -150),
            self.playButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -200),
            self.playButton.topAnchor.constraint(equalTo: self.playButton.bottomAnchor,constant: -30),
            
            self.stopButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 150),
            self.stopButton.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -150),
            self.stopButton.bottomAnchor.constraint(equalTo: self.stopButton.topAnchor,constant: 30),
            self.stopButton.topAnchor.constraint(equalTo: self.playButton.bottomAnchor,constant: 10),
        
        ])
    }
    
    private func configuratePlayer() {

        let song = songs[position]
        
        musicNameLabel.text = song.name
        
        print(song.name)
        
        let urlString = Bundle.main.path(forResource: song.name, ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)

            guard let urlString = urlString else {
                print("Url error")
                return
            }
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: urlString))
                
            player.play()
            
        } catch {
            
            print("error")
        }
    }
    
    @objc func playButtonTap() {
        if player.isPlaying == true {
            player.stop()
            playButton.setTitle("Play", for: .normal)
        }
        else {
            player.play()
            playButton.setTitle("Pause", for: .normal)
        }
    }
    
    @objc func stopButtonTap() {
        if player.currentTime != 0 {
            player.stop()
            player.currentTime = 0
            playButton.setTitle("Play", for: .normal)
        }
    }
    
    @objc func nextButtonTap() {
        if position < (songs.count - 1) {
            position = position + 1
            player.stop()
        }
        configuratePlayer()
    }
    
    @objc func backButtonTap() {
        if position > 0 {
            position = position - 1
            player.stop()
        }
        configuratePlayer()
    }
}
