//
//  UIImage + Util.swift
//  Voyatek
//
//  Created by DIGITAL VENTURES on 08/12/2024.
//

import UIKit

extension UIImage {
    func dominantColor() -> UIColor? {
        let size = CGSize(width: 50, height: 50)
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        let smallImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = smallImage?.cgImage else { return nil }
        let width = cgImage.width
        let height = cgImage.height
        let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: cgImage.bytesPerRow, space: cgImage.colorSpace!, bitmapInfo: cgImage.bitmapInfo.rawValue)

        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        guard let pixelBuffer = context?.data else { return nil }

        var colorCounts: [UIColor: Int] = [:]

        for y in 0..<height {
            for x in 0..<width {
                let pixelIndex = ((width * y) + x) * 4
                let r = pixelBuffer.load(fromByteOffset: pixelIndex, as: UInt8.self)
                let g = pixelBuffer.load(fromByteOffset: pixelIndex + 1, as: UInt8.self)
                let b = pixelBuffer.load(fromByteOffset: pixelIndex + 2, as: UInt8.self)
                let a = pixelBuffer.load(fromByteOffset: pixelIndex + 3, as: UInt8.self)

                let color = UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)

                colorCounts[color, default: 0] += 1
            }
        }
        let dominantColor = colorCounts.max { $0.value < $1.value }?.key
        return dominantColor
    }
}
