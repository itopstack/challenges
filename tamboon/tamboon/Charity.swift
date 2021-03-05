//
//  Charity.swift
//  tamboon
//
//  Created by Kittisak Phetrungnapha on 5/3/2564 BE.
//

import Foundation

struct Charity: Codable {
    let id: Int
    let name: String
    let logoURL: URL
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoURL = "logo_url"
    }
}
