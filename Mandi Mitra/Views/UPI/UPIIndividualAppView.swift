//
//  UPIIndividualAppView.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 04/03/24.
//

import SwiftUI

struct UPIIndividualAppView: View {
    var model: UPIAppListViewDataModel
    var body: some View {
//            RoundedRectangle(cornerRadius: 20)
//                .strokeBorder(lineWidth: 3)
//                .foregroundColor(.green)
            VStack {
                if(model.appname == "paytm") {
                    Image(model.appname)
                            .resizable()
                            .frame(width: 90, height: 30)
                            .padding(5)
                }
                if(model.appname == "gpay") {
                    Image(model.appname)
                            .resizable()
                            .frame(width: 60, height: 50)
                            .padding(5)
                }
                if(model.appname == "phonePe") {
                    Image(model.appname)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(5)
                }
                if(model.appname == "cred") {
                    Image(model.appname)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(5)
                }
            }.onTapGesture {
                redirectToUPIApp(appScheme: model.appScheme)
            }
    }
    func redirectToUPIApp(appScheme: String) {
        print("App is installed and can be opened")
        let url = URL(string:appScheme)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
