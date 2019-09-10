//
//  CustomView.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/30/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import UIKit

class CustomView: UIView {
	
	private var view: UIView!
	
	var viewName: String  {
		return "viewName"
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		//print("view \(name)")
		loadXib(viewName: viewName)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		loadXib(viewName: viewName)
		//print("viewName \(name)")
		//self.loadXib(viewName: viewName)
	}
	
	func loadXib(viewName: String)  {
		//print("viewName \(viewName)")
		let nib = UINib.init(nibName: viewName, bundle: Bundle.main)
		
		let myView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
		
		myView.frame = self.bounds
		myView.autoresizingMask = [
			.flexibleWidth,
			.flexibleHeight
		]
		
		self.view = myView
		self.addSubview(view)
	}
	
	
}
