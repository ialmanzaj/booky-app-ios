//
//  Coordinator.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/23/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import UIKit

protocol Coordinator {
	var navigationController: UINavigationController! { get set }
	func start()
}

extension Coordinator {
	func segue<T : UIViewController > (
		withIdentifier identifier: String, to controller: T.Type, nav: UINavigationController)  {
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		let view = storyboard.instantiateViewController(withIdentifier: identifier) as! T
		
		nav.show(view, sender: self)
	}
	
	func getViewController<T : UIViewController >(
		withIdentifier identifier: String, to controller: T.Type) -> T {
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		let view = storyboard.instantiateViewController(withIdentifier: identifier) as! T
		
		return view
	}
	
	func convertViewController<T>(view: BaseVC, to controller: T.Type) -> T {
		let newView = view as! T
		return newView
	}
	
//	func segue(withIdentifier identifier: String, item: SideItem, nav: UINavigationController)  {
//		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//		let view = storyboard.instantiateViewController(withIdentifier: identifier) as! ViewToolbarInteractive
//
//		view.toolbarItem = item
//		nav.show(view as! UIViewController, sender: self)
//	}
}
