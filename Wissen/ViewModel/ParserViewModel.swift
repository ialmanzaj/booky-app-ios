//
//  ParserViewModel.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/23/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//
import Foundation

protocol ParserViewModelDelegate : GenericViewModelDelegate {
	func bookResult(content: String)
}

protocol ParserViewModelProtocol {
	func saveBook(book: Book)
	func fetchBook(url: String)
}

class ParserViewModel: BaseViewModel, ParserViewModelProtocol {
	
	var viewDelegate: ParserViewModelDelegate!
	
	required init(viewDelegate: Any?, navDelegate: AppCoordinatorProtocol) {
		super.init(viewDelegate: viewDelegate, navDelegate: navDelegate)
		self.viewDelegate = viewDelegate as! ParserViewModelDelegate
	}
	
	func saveBook(book: Book) {
		DBManager.sharedInstance.add(book)
	}
	
	func fetchBook(url: String) {
		viewDelegate.onLoading()
		converterService.getBook(bookUrl: url) { (state) in
			switch state {
				case .onData(let data):
					self.viewDelegate.bookResult(content: data as! String)
					break
				case .Empty:
					self.viewDelegate.onEmpty()
					break
				case .Error(let error):
					self.viewDelegate.onError(error: error)
					break
			}
	
		}
	}
	
	
}
