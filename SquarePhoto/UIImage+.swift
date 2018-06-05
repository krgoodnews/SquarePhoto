//
//  UIImage+.swift
//  SquarePhoto
//
//  Created by Goodnews on 2018. 6. 5..
//  Copyright © 2018년 krgoodnews. All rights reserved.
//

import UIKit

extension UIImage {
	func resizeImage(_ dimension: CGFloat, opaque: Bool, contentMode: UIViewContentMode = .scaleAspectFit) -> UIImage {
		var width: CGFloat
		var height: CGFloat
		var newImage: UIImage
		
		let size = self.size
		let aspectRatio =  size.width/size.height
		
		switch contentMode {
		case .scaleAspectFit:
			if aspectRatio > 1 {                            // Landscape image
				width = dimension
				height = dimension / aspectRatio
			} else {                                        // Portrait image
				height = dimension
				width = dimension * aspectRatio
			}
			
		default:
			fatalError("UIIMage.resizeToFit(): FATAL: Unimplemented ContentMode")
		}
		
		if #available(iOS 10.0, *) {
			let renderFormat = UIGraphicsImageRendererFormat.default()
			renderFormat.opaque = opaque
			let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: renderFormat)
			newImage = renderer.image {
				(context) in
				self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
			}
		} else {
			UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), opaque, 0)
			self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
			newImage = UIGraphicsGetImageFromCurrentImageContext()!
			UIGraphicsEndImageContext()
		}
		
		return newImage
	}
	
	func squareImage(isOpaque: Bool = false) -> UIImage {
		var newImage: UIImage
		
		let size = self.size
		var newWidth = size.width
		var newHeight = size.height
		
		let aspectRatio =  newWidth / newHeight
		
		
		
		if aspectRatio > 1 {                            // Landscape image
			newHeight = newWidth
		} else {                                        // Portrait image
			newWidth = newHeight
		}
	
		
		UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: newHeight), isOpaque, 0)
		
		

		let newImgRect = CGRect(x: (newWidth - size.width) / 2, y: (newHeight - size.height) / 2, width: size.width, height: size.height)
		
		// draw background
		UIColor.black.setFill()
		UIRectFill(CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
		
		// draw image
		self.draw(in: newImgRect)

		
		
		
		newImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return newImage
	}
}
