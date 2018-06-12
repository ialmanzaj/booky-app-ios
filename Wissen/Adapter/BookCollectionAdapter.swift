//
//  BookCollectionAdapter.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/25/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import UIKit

protocol BookCollectionAdapterDelegate {
	func onBookSelected(book: Book)
}
class BookCollectionAdapter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
	
	typealias FetchData = ((_ data: Any) -> Any)

	fileprivate let sectionInsets = UIEdgeInsets(top: 0, left:0, bottom: 0, right: 0)
	fileprivate let itemsPerRow: CGFloat = 4
	
	var refresher: UIRefreshControl!
	
	private var delegate: BookCollectionAdapterDelegate!
	private var container: CGSize
	private var books: [Book] = []
	var collectionView: UICollectionView!
	var data: FetchData!
	
	
	init(container size:  CGSize, delegate: BookCollectionAdapterDelegate) {
		self.container = size
		self.delegate = delegate
		refresher = UIRefreshControl()
	}
	
	
	func addRefresher(){
		collectionView.addSubview(refresher)
		refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
		refresher.tintColor = UIColor(red: 1.00, green: 0.21, blue: 0.55, alpha: 1.0)
		refresher.addTarget(collectionView, action: #selector(refresh), for: .valueChanged)
	}
	
	@objc func refresh(){
		collectionView.reloadData()
		refresher.endRefreshing()
	}
	
	func setData(_ books: [Book]) {
		self.books = books
		collectionView.reloadData()
	}
	
	func add(_ book: Book) {
		self.books.append(book)
	}
	

	func count() -> Int{
		return self.books.count
	}
	
	func remove(_ position: Int) {
		do {
			try? self.books.remove(at: position)
		}catch{
			print("no disponible")
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		delegate.onBookSelected(book: books[indexPath.row])
	}
	
	func collectionView(_ collectionView: UICollectionView,
						numberOfItemsInSection section: Int) -> Int {
		return books.count
	}
	
	func collectionView(_ collectionView: UICollectionView,
						cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "book_cell", for: indexPath ) as! BookCollectionViewCell
		
		let book = books[indexPath.row]
		
		cell.bookName.text = book.name
		
		return cell
	}
	
}

extension BookCollectionAdapter : UICollectionViewDelegateFlowLayout  {
	//	//1
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		//2
		//let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
		let availableWidth = container.width
		let widthPerItem = availableWidth / itemsPerRow
		
		let heightPerItem = widthPerItem / 2
		
		//print("availableWidth: \(availableWidth)")
		//print("widthPerItem: \(widthPerItem)")
		let size = CGSize(width: widthPerItem, height: heightPerItem )
		//print("size \(size)")
		//print("height: \(heightPerItem)")
		return size
	}
	
	//3
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						insetForSectionAt section: Int) -> UIEdgeInsets {
		//print("sectionInsets \(sectionInsets)")
		return sectionInsets
	}
	
	// 4
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		//print("left \(sectionInsets.left)")
		return sectionInsets.left
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return sectionInsets.left
	}
	
}
