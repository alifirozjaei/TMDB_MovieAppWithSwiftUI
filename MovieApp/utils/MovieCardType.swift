//
//  MovieCardType.swift
//  MovieApp
//
//  Created by 1 on 12/4/1402 AP.
//

import Foundation

enum MovieCardType {
    case poster
    case grid
}

extension MovieCardType {
    var widthPercent: Double {
        switch self {
        case .grid:
            return 0.3
        case .poster:
            return 0.45
        }
    }
    
    var heightPercent: Double {
        switch self {
        case .grid:
            return 0.20
        case .poster:
            return 0.3
        }
    }
}
