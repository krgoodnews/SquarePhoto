//
//  ImgCell.swift
//  SquarePhoto
//
//  Created by Goodnews on 2018. 6. 7..
//  Copyright © 2018년 krgoodnews. All rights reserved.
//

import UIKit

class ImgCell: UICollectionViewCell {
	
	var img: UIImage? = nil {
		didSet {
			imgView.image = img
		}
	}
	
	let imgView: UIImageView = {
		let iv = UIImageView(frame: .zero)
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.contentMode = .scaleAspectFill
		return iv
	}()
	
	fileprivate func setupView() {
		addSubview(imgView)
		

		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imgView]))
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imgView]))


	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}
