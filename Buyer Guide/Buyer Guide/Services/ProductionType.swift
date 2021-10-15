//
//  Http.swift
//  Buyer Guide
//
//  Created by Apple on 2021/10/12.
//

import Combine
import Foundation
import SwiftSoup

var cannellable = Set<AnyCancellable>()

struct Production {
    static func fetchData() -> AnyPublisher<String, URLError> {

        let url: String = "https://buyersguide.macrumors.com/"
        let result = URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .map { response -> String in
            let data = response.data
            let htmlContent = String(data: data, encoding: .utf8)

            return htmlContent ?? ""
        }.eraseToAnyPublisher()

        return result
    }

    static func getCategoryProduction(_ type: String, data: String) -> ProductionItem {

        guard let doc: Document = try? SwiftSoup.parse(data) else {
            return []
        }

        guard let items: Elements = try? doc.select("#\(type) ul li") else {
            return []
        }

        var data: ProductionItem = []

        if items.count > 0 {
            for(_, item) in items.enumerated() {
                guard let name = try? item.select("a").text(),
                    let image = try? item.select("img").attr("src"),
                    let status = try? item.className() else {
                    return []
                }

                let production = ProductionItemElement(type: type, name: name, status: status, image: image)
                data.append(production)
            }

            return data
        }

        return []
    }
}
