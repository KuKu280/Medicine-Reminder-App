//
//  AddMedicationController.swift
//  Medicine Reminder
//
//  Created by kukuzan on 28/05/2024.
//

import UIKit

class AddMedicationController: UIViewController {
    
    // To hold the IB (Interface Builder) outlets
    @IBOutlet private(set) var ib: IB!
    
    // Initializer for creating the view controller
    init() {
        super.init(
            nibName: "AddMedicationController",
            bundle: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var viewModel: AddMedicationViewModel!

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let repository = MedicationRepositoryImpl()
        viewModel = AddMedicationViewModel(repository: repository)
        setupUI()
        ib.setupTimePickerView()
    }

    private func setupUI() {
        title = "Add Medication"
        view.backgroundColor = .systemGray6
    }
    
    // MARK: IBAction & Helper function
    @IBAction
    private func reminderIntervalChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel.reminderInterval = "daily"
        case 1:
            viewModel.reminderInterval = "weekly"
        case 2:
            viewModel.reminderInterval = "monthly"
        default:
            break
        }
    }
      
    @IBAction
    private func reminderTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel.reminderType = "one-time"
        case 1:
            viewModel.reminderType = "recurring"
        default:
            break
        }
    }

    @IBAction 
    private func saveMedication() {
        viewModel.name = ib.nameTextField.text ?? ""
        viewModel.dosage = ib.dosageTextField.text ?? ""
        viewModel.frequency = ib.frequencySegmentControl.titleForSegment(
            at: ib.frequencySegmentControl.selectedSegmentIndex) ?? ""
        viewModel.time = ib.timePicker.date
        viewModel.reminderTime = ib.timePicker.date.toString()
        viewModel.icons = ib.iconName
        viewModel.refillInterval = Int16(ib.refillIntervalTextField.text ?? "0") ?? 0
        viewModel.saveMedication()
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction 
    private func onTapType(_ sender: UIButton) {
        ib.updateIconAndBackground(forTag: sender.tag)
    }
    
}
