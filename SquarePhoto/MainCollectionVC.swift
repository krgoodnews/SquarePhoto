//
//  MainCollectionVC.swift
//  SquarePhoto
//
//  Created by Goodnews on 2018. 6. 7..
//  Copyright © 2018년 krgoodnews. All rights reserved.
//

import UIKit
import ImagePicker

private let cellID = "imgCellID"

class MainCollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, ImagePickerDelegate {
	
	var images = [UIImage]() {
		didSet {
			DispatchQueue.main.async {
				self.collectionView?.reloadData()
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
	}
	
	fileprivate func setupViews() {
		setupBar()
		collectionView?.backgroundColor = .white
		collectionView?.register(ImgCell.self, forCellWithReuseIdentifier: cellID)
	}
	
	fileprivate func setupBar() {
		let selectPhotoButton = UIBarButtonItem(title: "Select Photo", style: .plain, target: self, action: #selector(didTapSelectPhoto))
		self.navigationItem.rightBarButtonItem = selectPhotoButton
	}
	
	@objc private func didTapSelectPhoto() {
		// present imagePickerVC
		
		let imagePickerController = ImagePickerController()
		imagePickerController.delegate = self
		present(imagePickerController, animated: true, completion: nil)

	}
	
	// MARK: - UICollectionView
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return images.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImgCell
		
		cell.img = images[indexPath.row]

		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let cWidth = (view.frame.width / 3) - 1
		
		return CGSize(width: cWidth, height: cWidth)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 1
	}
	
	// MARK: - ImagePickerDelegate Methods
	
	func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
		print("wrapperDidPress")
	}
	
	func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
		print("doneButtonDidPress")
		imagePicker.dismiss(animated: true, completion: {
			self.alertMakeSquare(images: images)
		})
		
		
	}
	
	private func alertMakeSquare(images: [UIImage]) {
		let alert = UIAlertController(title: "선택하신 \(images.count)장의 사진을 정사각형으로 변환하시겠습니까?", message: nil, preferredStyle: .alert)
		
		let makeAction = UIAlertAction(title: "Sure", style: .destructive) { (_) in
			
			self.images = []
			for img in images {
				self.saveSquaredPhoto(img)
			}
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
		
		alert.addAction(makeAction)
		alert.addAction(cancelAction)
		
		present(alert, animated: true, completion: nil)
	}
	
	func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
		print("cancelButtonDidPress")
		imagePicker.dismiss(animated: true, completion: nil)
	}
	
	// MARK: - Photo Methods
	fileprivate func saveSquaredPhoto(_ img: UIImage) {
		var img = img
		print("originalSize:", img.size)
		//		img = img.resizeImage(200, opaque: true)
		
		
		img = img.squareImage()
		print("squareSize:", img.size)
		
		//		DispatchQueue.main.async {
		DispatchQueue.global(qos: .background).async {
			UIImageWriteToSavedPhotosAlbum(img, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
		}
		
	}
	
	@objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
		if let error = error {
			// we got back an error!
			let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "OK", style: .default))
			present(ac, animated: true)
		} else {
			let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "OK", style: .default))
			present(ac, animated: true)
		}
		self.images.append(image)
	}
	
}
