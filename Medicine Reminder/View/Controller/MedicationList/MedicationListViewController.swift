//
//  MedicationListViewController.swift
//  Medicine Reminder
//
//  Created by kukuzan on 28/05/2024.
//

import UIKit
import NotificationCenter

class MedicationListViewController: UITableViewController {
    
    // MARK: instances
    private var viewModel: MedicationListViewModel!
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let repository = MedicationRepositoryImpl()
        viewModel = MedicationListViewModel(repository: repository)
        setupNotification()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: Helper function
    private func setupNotification() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]
        ) { granted, error in
            if granted {
                print("Permission granted")
            } else {
                print("Permission denied")
            }
        }
    }

    private func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addMedication)
        )
        tableView.registerCell(ofType: MedicationCell.self)
    }
    
    @objc func addMedication() {
        let addMedicationVC = AddMedicationController()
        navigationController?.pushViewController(addMedicationVC, animated: true)
    }
    
    // MARK: UITableView Delegate & DataSource
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.medications.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.deque(MedicationCell.self, indexPath)
        cell.medication = viewModel.medications[indexPath.row]
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            let medication = viewModel.medications[indexPath.row]
            guard let id = medication.id else { return }
            viewModel.deleteMedication(by: id)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}


