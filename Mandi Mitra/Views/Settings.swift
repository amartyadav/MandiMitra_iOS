import SwiftUI

struct Settings: View {
    let settingsOptions: [SettingOption] = [
        SettingOption(title: NSLocalizedString("Release Notes", comment: ""), iconName: "doc.plaintext"),
        SettingOption(title: NSLocalizedString("View Developer's Website", comment: ""), iconName: "person.circle"),
        SettingOption(title: NSLocalizedString("Notifications", comment: ""), iconName: "bell.fill"),
        SettingOption(title: NSLocalizedString("Language", comment: ""), iconName: "globe"),
        SettingOption(title: NSLocalizedString("Privacy Policy", comment: ""), iconName: "lock.fill")
        
    ]
    
    var body: some View {
        NavigationStack {
            List(settingsOptions) { option in
                Button(action: {
                    performAction(for: option)
                }) {
                    HStack {
                        Image(systemName: option.iconName)
                            .foregroundColor(.blue)
                            .frame(width: 24, height: 24)
                        Text(option.title)
                        Spacer()
                    }
                    .padding(.vertical, 8)
                }
                .background(Color.white) // Set the background color of the NavigationStack
            }
            .listStyle(PlainListStyle()) // Use PlainListStyle for more control over appearance
            .background(Color.white) // Set the background color of the NavigationStack
            .navigationTitle(NSLocalizedString("Settings", comment: ""))
        }
    }
}

func performAction(for option: SettingOption) {
    switch option.title {
    case NSLocalizedString("Language", comment: ""):
        // navigate to language selection screen
        print("Opening Mandi Mitra notification settings in the Settings app")
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(settingsUrl) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(settingsUrl)
        } else {
            UIApplication.shared.openURL(settingsUrl)
        }
    case NSLocalizedString("View Developer's Website", comment: ""):
        if let url = URL(string: "https://amartyadav.com/") {
            UIApplication.shared.open(url)
        }
    case NSLocalizedString("Release Notes", comment: ""):
        if let url = URL(string: "https://aatmamartya.notion.site/Mandi-Mitra-Release-Notes-iOS-d0ebda548533482c9fbda9692a28e8a2?pvs=4") {
            UIApplication.shared.open(url)
        }
    case NSLocalizedString("Privacy Policy", comment: ""):
        if let url = URL(string: "https://docs.google.com/document/d/1xjscbL1W_GOkL2C4xp_o-ILJhdr_hRq5iTRiOJVcN9w/edit?usp=sharing") {
            UIApplication.shared.open(url)
        }
    case NSLocalizedString("Notifications", comment: ""):
        // todo: open the app's notification settings in the phone's settings menu
        print("Opening Mandi Mitra notification settings in the Settings app")
        guard let settingsUrl = URL(string: UIApplication.openNotificationSettingsURLString),
              UIApplication.shared.canOpenURL(settingsUrl) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(settingsUrl)
        } else {
            UIApplication.shared.openURL(settingsUrl)
        }
    default:
        break
    }
}

#Preview {
    Settings()
}

struct SettingOption: Identifiable {
    var id = UUID()
    var title: String
    var iconName: String
}
