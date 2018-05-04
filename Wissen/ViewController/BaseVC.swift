//
//  BaseVC.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/23/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import UIKit

protocol GenericViewDelegateProtocol {
	func bindViewModel(viewModel: Any?)
}

class BaseVC :  UIViewController {
	
	func registerBookCell(collectionView: UICollectionView) {
		collectionView.register(
			UINib.init(
				nibName: "BookCollectionViewCell",
				bundle: Bundle.main),
			forCellWithReuseIdentifier: "book_cell")
	}
	

}


extension UIViewController  {
	func showAlert(title: String?, message: String, actionMessage: String = "Ok"){
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction.init(title: actionMessage, style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
}
