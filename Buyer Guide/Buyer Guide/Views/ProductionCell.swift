//
//  ProductionCell.swift
//  Buyer Guide
//
//  Created by Apple on 2021/10/12.
//

import Kingfisher
import SwiftUI

enum Status: String {
    case green
    case neutral
    case red
    case yellow

    var text: String {
        switch self {
        case .green:
            return "BUY NOW"
        case .neutral:
            return "NEUTRAL"
        case .red:
            return "DON'T BUY"
        case .yellow:
            return "CAUTION"
        }
    }

    var color: Color {
        switch self {
        case .green:
            return Color(#colorLiteral(red: 0.4, green: 0.737254902, blue: 0, alpha: 1))
        case .neutral:
            return Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        case .red:
            return Color(#colorLiteral(red: 0.6666666667, green: 0.05098039216, blue: 0.137254902, alpha: 1))
        case .yellow:
            return Color(#colorLiteral(red: 1, green: 0.7568627451, blue: 0.1450980392, alpha: 1))
        }
    }
}

struct ProductionCell: View {
    var item: ProductionItemElement

    var body: some View {
        HStack(alignment: .center) {
            KFImage.url(URL(string: item.image))
                .placeholder {
                    Image("placeholder").resizable().aspectRatio(contentMode: .fit)
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)

            Text(item.name)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .padding(.leading, 10)

            Spacer()

            HStack {
//                Text("2021-01-01").foregroundColor(Color.gray)
//                    .font(.system(size: 16))
//                    .offset(y: 15.0)

                VStack {}
                    .frame(width: 6, height: 6)
                    .background(Status(rawValue: item.status)?.color ?? Color.green)
                    .cornerRadius(100)
                    .padding(.trailing, 3)

                Text(Status(rawValue: item.status)?.text ?? "")
                    .foregroundColor(Status(rawValue: item.status)?.color ?? Color.green)
                    .font(.system(size: 16))
            }.frame(width: 110, alignment: .leading)
        }
        .padding(10)
        .frame(height: 70)
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct ProductionCell_Previews: PreviewProvider {
    static let item = ProductionItemElement(type: "pane-ios", name: "iPhone 13 Pro", status: "green", image: "https://images.macrumors.com/images-new/buyers-products/iphone_13_pro_buyers_343.png")
    static var previews: some View {
        ProductionCell(item: item).previewLayout(.sizeThatFits)
    }
}
