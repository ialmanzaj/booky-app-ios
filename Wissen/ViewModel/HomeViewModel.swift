//
//  HomeViewModel.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/23/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate : GenericViewModelDelegate {
	func getBooks(books: [Book]?)
	func bookExist(_ book: Book?)
	func bookRemoved()
	
	func bookResult(_ book: BookElement)
	
}

protocol HomeViewModelProtocol {
	func launchBook(book: Book?)
	func findBook(url: String)
	
	func getBooksFromDb()
	func removeBookFromDb(book: Book)
	
	
	func fetchBook(file: Data)
	
	func saveBook(book: Book)
}

class HomeViewModel: BaseViewModel, HomeViewModelProtocol {
	
	var books: [Book] = []
	var viewDelegate: HomeViewModelDelegate!

	required init(viewDelegate: Any?, navDelegate: AppCoordinatorProtocol) {
		super.init(viewDelegate: viewDelegate, navDelegate: navDelegate)
		self.viewDelegate = viewDelegate as! HomeViewModelDelegate
	}
	
	func findBook(url: String) {
		viewDelegate.bookExist(DBManager.sharedInstance.findBook(url: url))
	}
	
	func removeBookFromDb(book: Book) {
		DBManager.sharedInstance.delete(book, primaryKey: book.ID)
		viewDelegate.bookRemoved()
	}
	
	func launchBook(book: Book?) {
		navDelegate.launchBook(book: book)
	}
	
	func getBooksFromDb(){
		viewDelegate.getBooks(books:
			DBManager.sharedInstance.getDataFromDB(class: Book.self))
	}
	
	func fetchBook(file: Data) {
		converterService.getBook(file: file, type: BookElement.self) { (state) in
			switch state {
			case .onData(let data):
				self.viewDelegate.bookResult( data as! BookElement)
				break
			case .Empty:
				//self.viewDelegate.onEmpty()
				break
			case .Error(let error):
				
				self.viewDelegate.onError(error: error)
				break
			}
		
		}
	}
	
	func saveBook(book: Book) {
		DBManager.sharedInstance.add(book)
	}
	
//	func fetchBook(url: String) {
//		viewDelegate.onLoading()
//		converterService.getBook(bookUrl: url, type: BookElement.self) { (state) in
//			switch state {
//			case .onData(let data):
//				self.viewDelegate.bookResult(data as! BookElement)
//				break
//			case .Empty:
//				self.viewDelegate.onEmpty()
//				break
//			case .Error(let error):
//				self.viewDelegate.onError(error: error)
//				break
//			}
//
//		}
//	}
	
	
}
