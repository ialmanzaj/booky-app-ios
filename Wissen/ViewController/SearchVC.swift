//
//  SearchViewController.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/22/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import UIKit

class SearchVC: BaseVC {
	
	@IBOutlet weak var booksCollections: UICollectionView!
	@IBOutlet weak var searchTextField: UITextField!
	
	var viewModel: HomeViewModelProtocol!
	var adapter: BookCollectionAdapter!
	

	var bookUrl: String?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		registerBookCell(collectionView: booksCollections)
		
		adapter = BookCollectionAdapter(container: view.frame.size, delegate: self )
		booksCollections.dataSource = adapter
		booksCollections.delegate = adapter
		
		
		viewModel.getBooksFromDb()
    }
	
	@IBAction func searchFieldAction(_ sender: UITextField) {
		searchTextField.resignFirstResponder()
		search()
	}
	
	@IBAction func searchAction(_ sender: UIButton) {
		searchTextField.resignFirstResponder()
		search()
	}
	
	func search() {
		 bookUrl = searchTextField.text

//		if !bookUrl.contains(".pdf")  {
//			return
//		}
		
		if bookUrl == nil {
			return
		}
		
		if bookUrl!.isEmpty  {
			return
		}
	

		viewModel.findBook(url: bookUrl!)
	}

}


extension SearchVC : HomeViewModelDelegate{
	func bookExist(_ book: Book?) {
		if book != nil {
			viewModel.launchBook(book: book)
		}else{
			let newBook = Book(url: bookUrl!)
			viewModel.launchBook(book: newBook)
		}
	}
	
	
	func getBooks(books: [Book]?) {
		if books == nil{
			return
		}
		
		adapter.setData(books!)
	}
}


extension SearchVC : BookCollectionAdapterDelegate{
	func onBookSelected(book: Book) {
		viewModel.launchBook(book: book)
	}
}
