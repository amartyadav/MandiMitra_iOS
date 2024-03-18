//
//  UpdateChecker.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 11/03/24.
//

import Foundation

struct UpdateChecker {
    public func getLatestVersionFromServer(completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://mandimitraversioninfoserver.azurewebsites.net/get_ios_version") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("API Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server responded with an error")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received from server")
                completion(nil)
                return
            }
            
            do {
                // decoding the json data from the api
                let decoder = JSONDecoder()
                let versionInfo = try decoder.decode(VersionInfo.self, from: data)
                completion(versionInfo.version)
                
                print("Latest version on server: \(versionInfo.version)")
            }
            
            catch {
                print("Failed to decode JSON from API: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func getCurrentlyInstalledVersion() -> String {
        guard let currentlyInstalledVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return "Unknown"
        }
        return currentlyInstalledVersion
    }
    
    func isUpdateRequired(currentlyInstalledVersion: String, latestavailableVersion: String) -> Bool {
        if currentlyInstalledVersion != latestavailableVersion {
            return true
        }
        else {
            return false
        }
    }
}
