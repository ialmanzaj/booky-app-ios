//
//  ViewController.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/22/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//
import UIKit
import Mixpanel

class ParserVC: BaseVC {
	
	@IBOutlet weak var header: TopBarNav!
	
	let PADDING = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
	
	@IBOutlet weak var textContainer: UITextView!
	@IBOutlet weak var loadingView: UIView!
	
	var viewModel : ParserViewModelProtocol!
	var book: Book!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		textContainer.textContainerInset = PADDING
		
		bookResult(BookElement(book: book.content, metadata: nil, pages: nil))
		
		header.setNavigator(viewController: self)
		header.config(title: "", viewController: self)

		Utility.logAllAvailableFonts()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		loadingView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height )
	}
	
}


extension ParserVC : ParserViewModelDelegate {
	func bookResult(_ bookElement: BookElement){
		Mixpanel.mainInstance().track(event: "Book opened")

		textContainer.attributedText = PDFParser.getbookParsed(content: bookElement.book)
	}

}

