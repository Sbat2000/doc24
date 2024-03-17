//
//  ContentView.swift
//  Doc
//
//  Created by Aleksandr Garipov on 14.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = DoctorPreviewViewModel()
    @State private var searchText = ""
    @State private var selectedSortCriterion: SortCriterion = .price
    @State private var sortDirection: SortDirection = .ascending
    
    var body: some View {
        NavigationView {
            VStack{
                TextField("🔍 Поиск", text: $searchText)
                    .padding(7)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
                    .onChange(of: searchText) { newValue in
                        viewModel.searchText = newValue
                        viewModel.searchDoctors()
                    }
                .cornerRadius(5)
                .frame(maxWidth: .infinity)
                List(viewModel.doctors) { doctor in
                    DoctorPreviewView(doctor: doctor)
                        .background(
                            NavigationLink("", destination: DoctorDetailView(doctor: doctor))
                                .opacity(0)
                        )
                        .listRowBackground(Color.white)
                    
                }
                .navigationBarBackButtonHidden(true)
                .listStyle(.automatic)
                .listRowSpacing(16)
                .onAppear { viewModel.loadUsers() }
                .navigationBarTitle("Доктора")
                .navigationBarTitleDisplayMode(.inline)
            }
            .background(Color(.systemGray6))
        }
    }
}

#Preview {
    ContentView()
}
