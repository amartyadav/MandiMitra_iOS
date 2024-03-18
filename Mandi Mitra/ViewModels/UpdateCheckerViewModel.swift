//
//  UpdateCheckerViewModel.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 18/03/24.
//

import Foundation

class UpdateCheckerViewModel: ObservableObject {
    private var updateChecker = UpdateChecker()
    
    func checkForUpdates() {
        updateChecker.getLatestVersionFromServer()
    }
}
