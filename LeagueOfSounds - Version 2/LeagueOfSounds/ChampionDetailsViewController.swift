//
//  ChampionDetailsViewController.swift
//  LeagueOfSounds
//
//  Created by Ramadugu, Akshith on 3/15/23.
//

import UIKit
import AVFoundation

class ChampionDetailsViewController: UIViewController {
    
    var champion: Champion!
    var options = SoundOption.allValues
    var pickerView: UIPickerView!
    var titleLabel: UILabel!
    
    init(champion: Champion) {
        self.champion = champion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configureUI() {
        // Create and add the title label
        titleLabel = UILabel()
        titleLabel.text = "Pick a Sound"
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Add constraints for the title label
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        
        // Create and add the picker view to the view hierarchy
        pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerView)
        
        // Add constraints to center the picker view horizontally and position it below the title label
        pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pickerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        
        // Set the delegate and data source for the picker view
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @objc func playSound() {
        // Get the selected row from the picker view
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        
        // Get the filename for the sound associated with the selected option
        guard let soundFilename = getSoundFilename(forOption: options[selectedRow]) else {
            // If the sound file could not be loaded, show an error message
            let alert = UIAlertController(title: "Error", message: "Could not load sound file", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Load the sound file and play it
        if let soundUrl = Bundle.main.url(forResource: soundFilename, withExtension: "mp3") {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            AudioServicesPlaySystemSound(soundId)
        }
    }
    
    func getSoundFilename(forOption option: String) -> String? {
        switch option {
        case "Pick":
            return "\(champion.name)_pick"
        case "Ban":
            return "\(champion.name)_ban"
        case "Taunt":
            return "\(champion.name)_taunt"
        case "Laugh":
            return "\(champion.name)_laugh"
        default:
            return nil
        }
    }
}

extension ChampionDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        playSound()
    }
}

