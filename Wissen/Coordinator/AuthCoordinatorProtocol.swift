//
//  AuthCoordinatorProtocol.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/23/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import UIKit

protocol AuthCoordinatorProtocol: Coordinator {
	init(nav: UINavigationController)
	func goHome()
	//func showAuthentication()
}

class AuthCoordinator: AuthCoordinatorProtocol {
	
	internal var navigationController: UINavigationController!
	
	var appCoordinator: AppCoordinator!
	
	required init(nav: UINavigationController) {
		self.navigationController = nav
		self.appCoordinator = AppCoordinator(parent: self, nav: navigationController)
		self.confNavController(nav: nav)
	}
	
	fileprivate func confNavController(nav: UINavigationController) {
		nav.isNavigationBarHidden = true
	}
	
	func start() {
		goHome()
		//showAuthentication()
		
//		if (currentUser == nil || person == nil) {
//			showAuthentication()
//		}else{
//
//		}
	}
	
	func showAuthentication()  {
		let loginView = getViewController(withIdentifier: "onBoardingVC",to: OnboardingVC.self)
		//let loginViewModel = LoginViewModel(viewDelegate: loginView, navDelegate: self)
		//loginView.viewModel = loginViewModel
		
		navigationController.pushViewController(loginView, animated: false)
	}
	
	func goHome()  {
		appCoordinator.start()
	}
}

