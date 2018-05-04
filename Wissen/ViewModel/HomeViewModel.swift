//
//  HomeViewModel.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/23/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate {
	func getBooks(books: [Book]?)
	func bookExist(_ book: Book?)
}

protocol HomeViewModelProtocol {
	func launchBook(book: Book?)
	func findBook(url: String)
	
	func getBooksFromDb()
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
	
	func launchBook(book: Book?) {
		navDelegate.launchBook(book: book)
	}
	
	func getBooksFromDb(){
		if let books = DBManager.sharedInstance.getDataFromDB(class: Book.self){
			viewDelegate.getBooks(books: books)
		}
	}
	
	
}
