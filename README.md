# Medicine-Reminder-App
The Medicine Reminder App is designed to help users manage their medication schedules and improve adherence to prescribed treatments. The app allows users to input their medication details, set reminders, and receive notifications for taking their medication and refilling prescriptions.

## Features

- **Medication Schedule**: Input medication names, dosages, frequencies, and specific times for reminders.
- **Customizable Reminders**: Set reminders for specific times or intervals (e.g., daily, weekly, monthly) based on the medication regimen.
- **Flexible Scheduling**: Schedule one-time reminders, recurring reminders, or reminders based on specific conditions (e.g., before meals, after waking up).
- **Refill Notifications**: Alert users when it’s time to refill their prescriptions based on their specified refill intervals or remaining supply.
- **User Alerts and Notifications**: Send alerts and notifications for missed doses or overdue medications to encourage adherence.

## Installation

### Prerequisites

- Xcode 12.0 or later
- iOS 13.0 or later

### Setup

1. **Clone the Repository**
    ```bash
    git clone https://github.com/KuKu280/Medicine-Reminder-App.git
    cd medicine-reminder-app
    ```

2. **Open the Project in Xcode**
    ```bash
    open MedicineReminderApp.xcodeproj
    ```

3. **Install Dependencies**
    - Ensure you have the necessary dependencies and frameworks set up in your project (e.g., CoreData, UserNotifications).

## Project Structure

- **AddMedicationController.swift**: Handles the user interface and logic for adding new medications.
- **AddMedicationViewModel.swift**: Contains the business logic for saving and managing medication data.
- **MedicationListViewController.swift**: Displays the list of medications and allows users to delete medications.
- **MedicationListViewModel.swift**: Manages the medication list and provides methods to update and delete medications.
- **MedicationRepository.swift**: Handles the data storage and retrieval of medication data using Core Data.
- **MedicationDataEntity.swift**: Defines the Core Data entity for storing medication information.

## Usage

### Adding a New Medication

1. Launch the app.
2. Tap the "+" button to add a new medication.
3. Fill in the medication details (name, dosage, frequency, time, refill interval, remaining supply).
4. Select the reminder interval (daily, weekly, monthly).
5. Select the reminder type (one-time, recurring).
6. Tap the "Save" button to save the medication.

### Viewing and Deleting Medications

1. Launch the app.
2. The medication list will display all added medications.
3. Swipe left on a medication to delete it.
