//
//  ParserViewModel.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/23/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//
import Foundation

protocol ParserViewModelDelegate  {
}

protocol ParserViewModelProtocol {
}

class ParserViewModel: BaseViewModel, ParserViewModelProtocol {
	var viewDelegate: ParserViewModelDelegate!
	
	required init(viewDelegate: Any?, navDelegate: AppCoordinatorProtocol) {
		super.init(viewDelegate: viewDelegate, navDelegate: navDelegate)
		self.viewDelegate = viewDelegate as! ParserViewModelDelegate
	}
	
	
}
