//
//  UpdateCheckerViewModel.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 18/03/24.
//

import Foundation

class UpdateCheckerViewModel: ObservableObject {
    private var updateChecker = UpdateChecker()
    
    @Published var isUpdateAvailable = false
    
    func checkForUpdates() {
        updateChecker.getLatestVersionFromServer { latestVersion in
            DispatchQueue.main.async {
                if let latestVersion = latestVersion {
                    let currentVersion = self.updateChecker.getCurrentlyInstalledVersion()
                    self.isUpdateAvailable = self.updateChecker.isUpdateRequired(currentlyInstalledVersion: currentVersion, latestavailableVersion: latestVersion)
                }
            }
        }
    }
}
