//
//  BaseViewModel.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/23/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import Foundation

protocol GenericViewModelDelegate {
	func onLoading()
	func onEmpty()
	func onError(error: BaseService.Error)
}

protocol GenericViewModelProtocol {
	init(viewDelegate: Any?, navDelegate: AppCoordinatorProtocol )
}

protocol BaseViewModelProtocol {
	
}

class BaseViewModel : BaseViewModelProtocol, GenericViewModelProtocol{
	let converterService = ConverterService()
	
	var navDelegate: AppCoordinatorProtocol!
	
	required init(viewDelegate: Any?, navDelegate: AppCoordinatorProtocol) {
		self.navDelegate = navDelegate
	}
	

}
