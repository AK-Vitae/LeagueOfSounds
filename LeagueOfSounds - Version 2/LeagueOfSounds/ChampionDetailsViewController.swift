//
//  ChampionDetailsViewController.swift
//  LeagueOfSounds
//
//  Created by Ramadugu, Akshith on 3/15/23.
//

import UIKit
import AVFoundation

class MyViewController: UIViewController {

    var options = ["Option 1", "Option 2", "Option 3"]
    var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create and add the picker view to the view hierarchy
        pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerView)
        
        // Add constraints to center the picker view horizontally and vertically
        pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // Set the delegate and data source for the picker view
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Add a button to play a sound when an option is selected
        let playSoundButton = UIButton()
        playSoundButton.translatesAutoresizingMaskIntoConstraints = false
        playSoundButton.setTitle("Play Sound", for: .normal)
        playSoundButton.setTitleColor(.blue, for: .normal)
        playSoundButton.addTarget(self, action: #selector(playSound), for: .touchUpInside)
        view.addSubview(playSoundButton)
        
        // Add constraints to position the button below the picker view
        playSoundButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playSoundButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 20).isActive = true
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
        // Return the filename for the sound associated with the given option
        switch option {
        case "Option 1":
            return "sound1"
        case "Option 2":
            return "sound2"
        case "Option 3":
            return "sound3"
        default:
            return nil
        }
    }
}

extension MyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
}

