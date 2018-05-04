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
	func goHome()
	func launchBook(book: Book?)
	//func showAuth()
	
	//launch childs
//	func launchDetailView(notice: Notice)
//	func launchChat(conversation: Conversation)
//	func launchCreateReservation()
//	func launchCreateVisit()
//
//	func launchReservation(area: Reservation)
//	func launchVisitDetail(visit: Visit)
//
//	func launchContacts()
}
