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
        musicNameLabel.font = .systemFont(ofSize: 23)
        musicNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return musicNameLabel
    }()
    
    private lazy var playButton: UIButton = {
        let playButton = UIButton()
        playButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        playButton.contentMode = .scaleAspectFit
        playButton.addTarget(self, action: #selector(self.playButtonTap), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    }()
    
    private lazy var nextAudioButton: UIButton = {
        let nextAudioButton = UIButton()
        nextAudioButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        nextAudioButton.contentMode = .scaleAspectFit
        nextAudioButton.addTarget(self, action: #selector(self.nextButtonTap), for: .touchUpInside)
        nextAudioButton.translatesAutoresizingMaskIntoConstraints = false
        return nextAudioButton
    }()
    
    private lazy var backAudioButton: UIButton = {
        let backAudioButton = UIButton()
        backAudioButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        backAudioButton.contentMode = .scaleAspectFit
        backAudioButton.addTarget(self, action: #selector(self.backButtonTap), for: .touchUpInside)
        backAudioButton.translatesAutoresizingMaskIntoConstraints = false
        return backAudioButton
    }()
    
    private lazy var stopButton: UIButton = {
        let stopButton = UIButton()
        stopButton.setBackgroundImage(UIImage(systemName: "stop.fill"), for: .normal)
        stopButton.contentMode = .scaleAspectFit
        stopButton.addTarget(self, action: #selector(self.stopButtonTap), for: .touchUpInside)
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        return stopButton
    }()
    
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
            self.musicNameLabel.bottomAnchor.constraint(equalTo: self.playButton.topAnchor, constant: -70),
            self.musicNameLabel.topAnchor.constraint(equalTo: self.musicNameLabel.bottomAnchor, constant: -30),
            
            self.nextAudioButton.leftAnchor.constraint(equalTo: self.playButton.rightAnchor, constant: 65),
            self.nextAudioButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -60),
            self.nextAudioButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -210),
            self.nextAudioButton.topAnchor.constraint(equalTo: self.nextAudioButton.bottomAnchor, constant: -45),
            
            self.backAudioButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 60),
            self.backAudioButton.rightAnchor.constraint(equalTo: self.playButton.leftAnchor, constant: -65),
            self.backAudioButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -210),
            self.backAudioButton.topAnchor.constraint(equalTo: self.backAudioButton.bottomAnchor, constant: -45),

            self.playButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 170),
            self.playButton.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -170),
            self.playButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -203),
            self.playButton.topAnchor.constraint(equalTo: self.playButton.bottomAnchor,constant: -60),
            
            self.stopButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 170),
            self.stopButton.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -170),
            self.stopButton.bottomAnchor.constraint(equalTo: self.stopButton.topAnchor,constant: 50),
            self.stopButton.topAnchor.constraint(equalTo: self.playButton.bottomAnchor,constant: 30),
        
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
            playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        else {
            player.play()
            playButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    @objc func stopButtonTap() {
        if player.currentTime != 0 {
            player.stop()
            player.currentTime = 0
            playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    @objc func nextButtonTap() {
        if position < (songs.count - 1) {
            position = position + 1
            player.stop()
        }
        configuratePlayer()
        playButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    
    @objc func backButtonTap() {
        if position > 0 {
            position = position - 1
            player.stop()
        }
        configuratePlayer()
        playButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
}
