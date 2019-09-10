//
//  AppCoordinatorProtocol.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/23/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
	init(parent: AuthCoordinatorProtocol, nav: UINavigationController)
	//func changeTab(index: Int)
	func launchBook(book: Book?)
	func showAuth()
	
}
