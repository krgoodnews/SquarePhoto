//
//  ViewController.swift
//  SquarePhoto
//
//  Created by Goodnews on 2018. 6. 5..
//  Copyright © 2018년 krgoodnews. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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

	@IBAction func didTapSelectPhoto(_ sender: UIButton) {
		var img = #imageLiteral(resourceName: "sample01")
		print("originalSize:", img.size)
//		img = img.resizeImage(200, opaque: true)
		imgView.image = img
		
		img = img.squareImage()
		print("squareSize:", img.size)
		imgView01.image = img
		
		// save file
		
//		if let data = UIImagePNGRepresentation(img) {
//			let filename = getDocumentsDirectory().appendingPathComponent("copy.png")
//
//			do {
//				print(filename)
//				try data.write(to: filename)
//			} catch let err {
//				print("writeErr:", err)
//			}
//		}
		UIImageWriteToSavedPhotosAlbum(img, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)

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
	
	
	
	
}

