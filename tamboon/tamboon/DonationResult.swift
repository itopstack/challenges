//
//  DonationResult.swift
//  tamboon
//
//  Created by Kittisak Phetrungnapha on 5/3/2564 BE.
//

import Foundation

struct DonationResult: Codable {
    let isSuccess: Bool
    
    private enum CodingKeys: String, CodingKey {
        case isSuccess = "success"
    }
}
