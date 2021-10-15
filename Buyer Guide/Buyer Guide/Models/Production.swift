//
//  Production.swift
//  Buyer Guide
//
//  Created by Apple on 2021/10/12.
//

import Foundation

struct ProductionItemElement: Codable,Hashable {
    let type, name, status, image: String
}

typealias ProductionItem = [ProductionItemElement]


enum ProductionCategory: String {
    case iOS = "iPhone/iPad"
    case mac = "Macs"
    case music = "Music"
    case other = "Watch/Other"
    
    var type:String {
        switch self {
        case .iOS:
            return "pane-ios"
        case .mac:
            return "pane-mac"
        case .music:
            return "pane-music"
        case .other:
            return "pane-other"
        }
    }
}
