//
//  TopBarNav.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/30/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import UIKit

class TopBarNav: CustomView {
	
	@IBOutlet var headerView: UIView!
	@IBOutlet weak var headerTitle: UILabel!
	@IBOutlet weak var backButton: UIButton!
	
	var navController: UINavigationController?
	
	override var viewName: String {
		return "TopBarNav"
	}
	
	// Config Custom Header
	func config(title:String, viewController: UIViewController){
		headerTitle.text = title
		navController = viewController.navigationController
	}
	
	/* Set title to Header
	func setTitle(_ title:String) {
	headerTitle.text = title.titleStyle()
	}*/
	
	// Set Navigator
	func setNavigator(viewController: UIViewController) {
		navController = viewController.navigationController
	}
	
	//Hidden Back Button in Tab Bar Views
	func hideBack() {
		backButton.isHidden = true
	}
	
	@IBAction func goBack(_ sender: UIButton) {
	navController?.popViewController(animated: true)
	}


}
