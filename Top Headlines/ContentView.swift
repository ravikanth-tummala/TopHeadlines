//
//  ContentView.swift
//  Top Headlines
//
//  Created by GeoSpark on 05/08/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = NewsViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                NewlistView(articles: viewModel.articles)
                .onAppear {
                    viewModel.getNews()
                }
                if viewModel.isLoading {
                    ProgressView("Fetching the news") 
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemBackground)))
                        .shadow(radius: 10)
                }
            }
            .navigationTitle("Top Headlines")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
