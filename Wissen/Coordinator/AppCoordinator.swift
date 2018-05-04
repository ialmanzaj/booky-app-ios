//
//  AppCoordinator.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/23/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//
import UIKit

class AppCoordinator : AppCoordinatorProtocol{

	
	
	internal var navigationController: UINavigationController!
	var parentCoordinator: AuthCoordinatorProtocol!
	
	//private var controllerTransition = ControllerTransition()
	
	//child coordinators
	
	required init(parent: AuthCoordinatorProtocol, nav: UINavigationController) {
		self.navigationController = nav
		self.parentCoordinator = parent
	
	}
	
	func goHome() {
		
	}
	
	func launchBook(book: Book?) {
		let view = getViewController(withIdentifier:"parserVC", to: ParserVC.self)
		let parserViewModel = ParserViewModel(viewDelegate: view, navDelegate: self)
		
		view.viewModel = parserViewModel
		view.book = book
		
		navigationController.show(view, sender: self)
	}
	
	func start() {
		let view = getViewController(withIdentifier:"searchVC", to: SearchVC.self)
		let homeViewModel = HomeViewModel(viewDelegate: view, navDelegate: self)
		
		view.viewModel = homeViewModel
		
		navigationController.show(view, sender: self)
	}
	
//	func showAuth(){
//		//parentCoordinator.showAuthentication()
//	}
	
}
