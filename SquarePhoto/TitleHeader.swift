//
//  TitleHeader.swift
//  SquarePhoto
//
//  Created by Goodnews on 2018. 6. 7..
//  Copyright © 2018년 krgoodnews. All rights reserved.
//

import UIKit

class TitleHeader: UICollectionReusableView {
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private func setupView() {
		addSubview(titleLabel)
		
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": titleLabel]))
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": titleLabel]))
		
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
