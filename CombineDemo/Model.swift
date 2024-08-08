//
//  Model.swift
//  CombineDemo
//
//  Created by Hyper Thread Solutions Pvt Ltd on 29/07/24.
//

import Foundation

struct Post: Decodable, Identifiable {
    let id: Int
    let title: String
    let body: String
}
