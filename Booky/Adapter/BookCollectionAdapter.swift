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
class BookCollectionAdapter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
	
	typealias FetchData = ((_ data: Any) -> Any)

	fileprivate let sectionInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
	fileprivate let itemsPerRow: CGFloat = 5
	
	var refresher: UIRefreshControl!
	
	private var delegate: BookCollectionAdapterDelegate!
	private var container: CGSize
	private var books: [Book] = []
	var collectionView: UICollectionView!
	var data: FetchData!
	
	fileprivate var longPressGesture: UILongPressGestureRecognizer!

	init(container size:  CGSize, delegate: BookCollectionAdapterDelegate) {
		self.container = size
		self.delegate = delegate
		refresher = UIRefreshControl()
	}
	
	@objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
		switch(gesture.state) {
		case .began:
			guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
				break
			}
			collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
		case .changed:
			collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
		case .ended:
			collectionView.endInteractiveMovement()
		default:
			collectionView.cancelInteractiveMovement()
		}
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
		self.books.remove(at: position)

	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		delegate.onBookSelected(book: books[indexPath.row])
	}
	
	func collectionView(_ collectionView: UICollectionView,
						numberOfItemsInSection section: Int) -> Int {
		return books.count
	}
	
	func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		print("Starting Index: \(sourceIndexPath.item)")
		print("Ending Index: \(destinationIndexPath.item)")
	}

	
	func collectionView(_ collectionView: UICollectionView,
						cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "book_cell", for: indexPath ) as! BookCollectionViewCell
		
		cell.contentView.layer.cornerRadius = 2.0
		cell.contentView.layer.borderWidth = 1.0
		cell.contentView.layer.borderColor = UIColor.clear.cgColor
		cell.contentView.layer.masksToBounds = true
		
		cell.layer.shadowColor = UIColor.lightGray.cgColor
		cell.layer.shadowOffset = CGSize(width:0, height: 2.0)
		cell.layer.shadowRadius = 3.0
		cell.layer.shadowOpacity = 1.0
		cell.layer.masksToBounds = false
		cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
		
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
		
		let heightPerItem = widthPerItem * 1.48
		
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
