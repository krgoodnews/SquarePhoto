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
		iv.contentMode = .scaleAspectFit
		return iv
	}()
	
	fileprivate func setupView() {
		backgroundColor = .blue
		
		addSubview(imgView)
		
		imgView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		imgView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
		imgView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
		imgView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}
