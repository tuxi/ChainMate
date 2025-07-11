//
//  BalloonMarker.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/11.
//

import DGCharts
import UIKit

// 长按 marker 显示价格的标记
class BalloonMarker: MarkerImage {
    private var color: UIColor
    private var font: UIFont
    private var textColor: UIColor
    private var insets: UIEdgeInsets
    private var minimumSize = CGSize()

    private var label: String = ""

    init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets) {
        self.color = color
        self.font = font
        self.textColor = textColor
        self.insets = insets
        super.init()
    }

    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        let price = String(format: "$%.2f", entry.y)
        label = price
    }

    override func draw(context: CGContext, point: CGPoint) {
        let labelSize = label.size(withAttributes: [.font: font])
        let rect = CGRect(origin: CGPoint(x: point.x - labelSize.width / 2 - insets.left,
                                          y: point.y - labelSize.height - insets.top - 10),
                          size: CGSize(width: labelSize.width + insets.left + insets.right,
                                       height: labelSize.height + insets.top + insets.bottom))

        context.setFillColor(color.cgColor)
        context.fill(rect)

        label.draw(in: rect, withAttributes: [
            .font: font,
            .foregroundColor: textColor
        ])
    }
}

