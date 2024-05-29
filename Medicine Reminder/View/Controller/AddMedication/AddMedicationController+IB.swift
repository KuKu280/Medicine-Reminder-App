//
//  AddMedicationController+IB.swift
//  Medicine Reminder
//
//  Created by kukuzan on 28/05/2024.
//

import UIKit

extension AddMedicationController {
    typealias IB = AddMedicationController_IB
}

class AddMedicationController_IB: NSObject {
    
    @IBOutlet private(set) var nameTextField: UITextField!
    @IBOutlet private(set) var dosageTextField: UITextField!
    @IBOutlet private(set) var refillIntervalTextField: UITextField!
    @IBOutlet private(set) weak var notiTimeTextField: UITextField!
    
    @IBOutlet private(set) var frequencySegmentControl: UISegmentedControl!
    @IBOutlet private(set) var reminderTypeSegmentControl: UISegmentedControl!
    
    @IBOutlet private(set) weak var capsuleBgView: UIView!
    @IBOutlet private(set) weak var injectionBgView: UIView!
    @IBOutlet private(set) weak var tabletBgView: UIView!
    
    lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = .wheels
        }
        return timePicker
    }()
    
    var iconName: IconString = .capsule
    var times: [Date] = []
    
    func updateIconAndBackground(forTag tag: Int) {
        // Reset all background colors first
        resetBackgroundColors()
        
        // Update icon name and specific background color based on tag
        switch tag {
        case 1:
            iconName = .inject
            injectionBgView.backgroundColor = .systemTeal
        case 2:
            iconName = .tablet
            tabletBgView.backgroundColor = .systemTeal
        default:
            iconName = .capsule
            capsuleBgView.backgroundColor = .systemTeal
        }
    }
    
    private func resetBackgroundColors() {
        capsuleBgView.backgroundColor = .white
        tabletBgView.backgroundColor = .white
        injectionBgView.backgroundColor = .white
    }
    
    func setupTimePickerView() {
        notiTimeTextField.inputView = timePicker
        notiTimeTextField.delegate = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem.init(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(onTapDone)
        )
        toolBar.setItems([doneButton], animated: true)
        notiTimeTextField.inputAccessoryView = toolBar
        
        timePicker.addTarget(
            self,
            action: #selector(onTimeChanged),
            for: .valueChanged
        )
    }
    
    @objc func onTimeChanged() {
        let selectedTime = timePicker.date
        if !times.contains(selectedTime) {
            times.append(selectedTime)
            notiTimeTextField.text = timePicker.date.toString()
        }
        
    }
    
    @objc func onTapDone() {
        times.append(timePicker.date)
        notiTimeTextField.text = timePicker.date.toString()
        notiTimeTextField.resignFirstResponder()
    }
}

extension AddMedicationController_IB: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if textField == notiTimeTextField {
            return false
        }
        
        return true
    }
}
