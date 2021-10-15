//
//  ViewModel.swift
//  Buyer Guide
//
//  Created by Apple on 2021/10/12.
//

import Combine
import Foundation

class ViewModel: ObservableObject {

    @Published var data: [ProductionItem] = []
    @Published var selectCategory: String = ""
    @Published var appleProductions = []
    @Published var isLoading = true

    private var htmlContent: String = ""
    var cannellable = Set<AnyCancellable>()

    init() {

//        $selectCategory
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] value in
//
//            guard let type = ProductionCategory(rawValue: value)?.type else {
//                return
//            }
//
//            guard let data = self?.htmlContent else {
//                return
//            }
//
//
//
//        }.store(in: &cannellable)

        fetchData()
    }

    func fetchData() {
        self.isLoading = true

        Production.fetchData()
            .receive(on: DispatchQueue.main)
            .sink { completion in

        } receiveValue: { [weak self] content in

            self?.htmlContent = content

            guard let data = self?.htmlContent else {
                return
            }

            guard let appleProductions = self?.appleProductions else {
                return
            }

            for item in appleProductions {

                guard let type = ProductionCategory(rawValue: item as!String)?.type else {
                    return
                }

                let result = Production.getCategoryProduction(type, data: data)

                guard let self = self else {
                    return
                }

                self.data.append(result)
                self.isLoading = false
            }

        }.store(in: &cannellable)
    }
}
