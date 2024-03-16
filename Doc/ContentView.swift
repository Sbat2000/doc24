//
//  ContentView.swift
//  Doc
//
//  Created by Aleksandr Garipov on 14.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = DoctorPreviewViewModel()
    
    var body: some View {
        List(viewModel.doctors) { doctor in
            DoctorPreviewView(doctor: doctor)
            //.listRowInsets(EdgeInsets())
        }
        .listStyle(.automatic)
        .listRowSpacing(16)
        .onAppear {viewModel.loadUsers()}
    }
}

#Preview {
    ContentView()
}
