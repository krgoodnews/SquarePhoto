//
//  UIImage+.swift
//  SquarePhoto
//
//  Created by Goodnews on 2018. 6. 5..
//  Copyright © 2018년 krgoodnews. All rights reserved.
//

import UIKit

extension UIImage {
	
	
	func squareImage(isOpaque: Bool = false) -> UIImage {
		var newImage: UIImage
		let maxSize:CGFloat = 1080 / UIScreen.main.scale
		
		let size = self.size
		
		let aspectRatio =  size.width / size.height
		
		let widthRatio = (maxSize < size.width) ? (maxSize / size.width) : 1
		let heightRatio = (maxSize < size.height) ? (maxSize / size.height) : 1

		
		var newSize: CGSize
		if aspectRatio > 1 {                            // Landscape image (width > height)
//			newHeight = newWidth
			newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
		} else {                                        // Portrait image (height >= width)
//			newWidth = newHeight
			
			newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
		}
	
		let sideLength = max(newSize.width, newSize.height) // 한 변의 길이
		let squareSize = CGSize(width: sideLength, height: sideLength)
		UIGraphicsBeginImageContextWithOptions(squareSize, isOpaque, 0)
		
		
		let newImgRect = CGRect(x: (squareSize.width - newSize.width) / 2, y: (squareSize.height - newSize.height) / 2, width: newSize.width, height: newSize.height)
		
		// draw background
		UIColor.black.setFill()
		UIRectFill(CGRect(x: 0, y: 0, width: squareSize.width, height: squareSize.height))
		
		// draw image
		self.draw(in: newImgRect)

		
		
		
		newImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return newImage
	}
}
