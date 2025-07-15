//
//  UPIView.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 04/03/24.
//

import SwiftUI

struct UPIView: View {
    var viewModel: UPIAppListViewModel

    var body: some View {
        VStack{
                
                    Text("Pay Now")
                        .bold()
                        .padding(.all)
                        HStack {
                            ForEach(viewModel.installedAppList,id:\.self) { app in
                                UPIIndividualAppView(model: app)
                                    .padding(10)
                            }
                        }
                }
    }
}
