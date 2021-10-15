//
//  ContentView.swift
//  Buyer Guide
//
//  Created by Apple on 2021/10/12.
//

import SwiftUI

struct ContentView: View {
    @State private var select = "iPhone/iPad"
    @State private var pageIndex = 0

    private var appleProductions = ["iPhone/iPad", "Macs", "Music", "Watch/Other"]

    @ObservedObject var vm = ViewModel()

    init() {
        vm.appleProductions = appleProductions
    }

    var body: some View {
        ZStack {
            VStack {
                Picker("", selection: $select) {
                    ForEach(appleProductions, id: \.self) {
                        Text($0)
                    }
                }.onChange(of: select, perform: { value in
                    guard let index = appleProductions.firstIndex(of: value) else {
                        return
                    }
                    pageIndex = index
                })
                    .pickerStyle(SegmentedPickerStyle())
                    .disabled(vm.isLoading)


                if vm.data.count < 1 {
                    Spacer(minLength: 20)
                    ActivityIndicator(isAnimating: .constant(true), style: .medium)
                }

                Spacer(minLength: 20)

                if vm.data.count > 0 {
                    TabView(selection: $pageIndex) {
                        ForEach(0..<appleProductions.count) {
                            index in
                            ScrollView(.vertical, showsIndicators: false, content: {
                                VStack(spacing: 16) {

                                    ForEach(vm.data[index], id: \.name) { item in
                                        ProductionCell(item: item)
                                    }
                                }
                            })
                                .tag(index)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }.onChange(of: pageIndex, perform: { index in
                        select = appleProductions[index]
                    })
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .disabled(vm.isLoading)
                }

            }.padding(.top, 30)
        }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 0.9799087644, green: 0.9728805423, blue: 0.9654065967, alpha: 1)))
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
