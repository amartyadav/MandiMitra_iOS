//
//  UpdateChecker.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 11/03/24.
//

import Foundation

struct UpdateChecker {
    public func getLatestVersionFromServer() {
        guard let url = URL(string: "https://mandimitraversioninfoserver.azurewebsites.net/get_ios_version") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("API Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server responded with an error")
                return
            }
            
            guard let data = data else {
                print("No data received from server")
                return
            }
            
            do {
                // decoding the json data from the api
                let decoder = JSONDecoder()
                let versionInfo = try decoder.decode(VersionInfo.self, from: data)
                
                print("Latest version on server: \(versionInfo.version)")
            }
            
            catch {
                print("Failed to decode JSON from API: \(error)")
            }
            
            
        }
        
        task.resume()
    }
    
    func getCurrentlyInstalledVersion() -> String {
        let currentlyInstalledVersion = "1.0.2"
        // implement this method to dynamically get the current version of the app installed on the device
        return currentlyInstalledVersion
    }
    
    func isUpdateRequired(currentlyInstalledVersion: String, latestavailableVersion: String) -> Bool {
        let isUpdateRequired = false
        if currentlyInstalledVersion != latestavailableVersion {
            return true
        }
        else {
            return false
        }
    }
}
