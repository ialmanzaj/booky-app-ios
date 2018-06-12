//
//  SearchViewController.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/22/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import UIKit
import MobileCoreServices
import SwiftGifOrigin

class SearchVC: BaseVC {
	
	@IBOutlet var emptyScreen: UIView!
	@IBOutlet var loadingScreen: UIView!
	
	@IBOutlet weak var loadingImg: UIImageView!
	
	@IBOutlet weak var booksCollections: UICollectionView!
	//@IBOutlet weak var searchTextField: UITextField!
	@IBOutlet weak var progressBar: UIProgressView!

	
	var viewModel: HomeViewModelProtocol!
	var adapter: BookCollectionAdapter!
	
	private var bookUrl: String?
	private var books: [Book]?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		let folderURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)
		if let unwrappedFolderURL = folderURL {
			print("cloud access is available")
		}
		else {
			//cloud access is not available.
			print("cloud access is not available.")
		}
		
		registerBookCell(collectionView: booksCollections)
		
		adapter = BookCollectionAdapter(container: view.frame.size, delegate: self )
		booksCollections.dataSource = adapter
		booksCollections.delegate = adapter
		adapter.collectionView = booksCollections
		
		
		loadingImg.image =  UIImage.gif(asset: "book")
		viewModel.getBooksFromDb()
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		emptyScreen?.frame = CGRect(
			x: booksCollections.frame.origin.x,
			y: booksCollections.frame.origin.y,
			width: booksCollections.frame.width,
			height: booksCollections.frame.height)
		
		loadingScreen.frame = CGRect(
			x: booksCollections.frame.origin.x,
			y: booksCollections.frame.origin.y,
			width: booksCollections.frame.width,
			height: booksCollections.frame.height)
	}
	
//	@IBAction func searchFieldAction(_ sender: UITextField) {
//		searchTextField.resignFirstResponder()
//		search()
//	}
//
//	@IBAction func searchAction(_ sender: UIButton) {
//		searchTextField.resignFirstResponder()
//		search()
//	}
//
	@IBAction func remove(_ sender: UIButton) {
		if let books = books {
			let last_position = adapter.count() - 1
			adapter.remove(last_position)
			viewModel.removeBookFromDb(book: books[last_position])
		}
		viewModel.getBooksFromDb()
	}
	
//	func search() {
//		 bookUrl = searchTextField.text
//
//		if bookUrl == nil {
//			return
//		}
//
//		if bookUrl!.isEmpty  {
//			return
//		}
//
//		viewModel.findBook(url: bookUrl!)
//	}
	
	@IBAction func importAction(_ sender: UITextField) {
		let importMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
		importMenu.delegate = self
		importMenu.modalPresentationStyle = .formSheet
		self.present(importMenu, animated: true, completion: nil)
	}
	
}

extension SearchVC : HomeViewModelDelegate {
	func getBooks(books: [Book]?) {
		if books == nil{

			view.addSubview(emptyScreen!)
			return
		}
		//print("no esta vacio ")
		emptyScreen.removeFromSuperview()
		loadingScreen.removeFromSuperview()
		
		self.books = books
		adapter.setData(books!)
	}
	
	func bookResult(_ book: BookElement) {
		Toast.showPositiveMessage(message: "Exito 👍")
		//progressBar.isHidden = true
	
		viewModel.saveBook(book: Book(
			name: book.metadata?.info?.Title ?? "Book #" ,
			url: bookUrl,
			content: book.book,
			metadata: "\(book.metadata?.toJSON())")
		)
		
		viewModel.getBooksFromDb()
		//viewModel.launchBook(book: Book(name: "", url: bookUrl, content: book.book))
	}
	
	func onLoading() {
		//progressBar.isHidden = false
		//progressBar.setProgress(Float(), animated: true)
	}
	
	func onEmpty() {
		
	}
	
	func onError(error: BaseService.Error) {
		loadingScreen.removeFromSuperview()
		Toast.showNegativeMessage(message: "Ha ocurrido un error😕")
	}
	
	func bookRemoved() {
		booksCollections.reloadData()
	}
	
	func bookExist(_ book: Book?) {
		if book != nil {
			viewModel.launchBook(book: book)
		}
//		else{
//			viewModel.fetchBook(url: bookUrl!)
//		}
	}
	
	
	
}

extension SearchVC : BookCollectionAdapterDelegate {
	func onBookSelected(book: Book) {
		viewModel.launchBook(book: book)
	}
}

extension SearchVC : UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate {
	func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
		//print("import result: \(urls)")
		
		if let data = try? Data(contentsOf: urls[0]){
			//print("data :\(data)")
			viewModel.fetchBook(file: data)
			view.addSubview(loadingScreen)
		}
	}
	
	
	func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
		documentPicker.delegate = self
		present(documentPicker, animated: true, completion: nil)
	}
	
	
}
