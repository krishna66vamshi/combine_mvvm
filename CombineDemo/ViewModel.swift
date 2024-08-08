//
//  ViewModel.swift
//  CombineDemo
//
//  Created by Hyper Thread Solutions Pvt Ltd on 29/07/24.
//

import Foundation

import SwiftUI
import Combine

class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching posts: \(error)")
                }
            }, receiveValue: { [weak self] posts in
                self?.posts = posts
            })
            .store(in: &cancellables)
    }
}
