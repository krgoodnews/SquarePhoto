//
//  ViewController.swift
//  SquarePhoto
//
//  Created by Goodnews on 2018. 6. 5..
//  Copyright © 2018년 krgoodnews. All rights reserved.
//

import UIKit
import ImagePicker

class ViewController: UIViewController, ImagePickerDelegate {
	
	

	@IBOutlet weak var imgView: UIImageView!
	@IBOutlet weak var imgView01: UIImageView!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

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
	
	@IBAction func didTapSelectPhoto(_ sender: UIButton) {
		
		// present imagePickerVC
		
		let imagePickerController = ImagePickerController()
		imagePickerController.delegate = self
		present(imagePickerController, animated: true, completion: nil)

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
	}
	
	
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
	
}

