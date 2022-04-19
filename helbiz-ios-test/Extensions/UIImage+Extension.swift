//
//  UIImage+Extension.swift
//

import UIKit

extension UIImage {
    
    func resizedTo(sizeInKB: Double) -> UIImage? {
        guard let imageData = self.jpegData(compressionQuality: 1) else { return nil }
        
        var resizingImage = self
        var imageSizeKB = Double(imageData.count) / 1024.0
        
        while imageSizeKB > sizeInKB {
            guard let resizedImage = resizingImage.resized(withPercentage: 0.9),
                  let imageData = resizedImage.pngData()
            else { return nil }
            
            resizingImage = resizedImage
            imageSizeKB = Double(imageData.count) / 1024.0
        }
        
        return resizingImage
    }

    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    
    func rotateImage() -> UIImage {
        let width: CGFloat = CGFloat(cgImage!.width)
        let height: CGFloat = CGFloat(cgImage!.height)
        
        var transform: CGAffineTransform = .identity
        var bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let scaleRatio: CGFloat = bounds.size.width / width
        let imageSize = CGSize(width: cgImage!.width, height: cgImage!.height)
        var boundHeight: CGFloat = 0.0
        let orient: UIImage.Orientation = imageOrientation
        
        switch orient {
        case .up:
            transform = CGAffineTransform.identity
        case .upMirrored:
            transform = CGAffineTransform(translationX: imageSize.width, y: 0.0)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
            
        case .down:
            transform = CGAffineTransform(translationX: imageSize.width, y: imageSize.height)
            transform = transform.rotated(by: .pi)
            
        case .downMirrored:
            transform = CGAffineTransform(translationX: 0.0, y: imageSize.height)
            transform = transform.scaledBy(x: 1.0, y: -1.0)
            
        case .left:
            boundHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = boundHeight
            transform = CGAffineTransform(translationX: 0.0, y: imageSize.width)
            transform = transform.rotated(by: 3.0 * .pi / 2.0)
            
        case .leftMirrored:
            boundHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = boundHeight
            transform = CGAffineTransform(translationX: imageSize.height, y: imageSize.width)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
            transform = transform.rotated(by: 3.0 * .pi / 2.0)
            
        case .right:
            boundHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = boundHeight
            transform = CGAffineTransform(translationX: imageSize.height, y: 0.0)
            transform = transform.rotated(by: .pi / 2.0)
            
        case .rightMirrored:
            boundHeight = bounds.size.height
            bounds.size.height = bounds.size.width
            bounds.size.width = boundHeight
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            transform = transform.rotated(by: .pi / 2.0)
            
        @unknown default:
            transform = CGAffineTransform.identity
        }
        
        UIGraphicsBeginImageContext(bounds.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        if orient == .right || orient == .left {
            context?.scaleBy(x: -scaleRatio, y: scaleRatio)
            context?.translateBy(x: -height, y: 0)
        } else {
            context?.scaleBy(x: scaleRatio, y: -scaleRatio)
            context?.translateBy(x: 0, y: -height)
        }
        context?.concatenate(transform)
        UIGraphicsGetCurrentContext()?.draw(cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
        let imageCopy: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageCopy!
        
    }
    
}
