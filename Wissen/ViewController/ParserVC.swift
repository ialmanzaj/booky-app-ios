//
//  ViewController.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/22/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//
import UIKit
import SwiftyMarkdown
import SwiftyAttributes

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
		
		if (book.name.isEmpty) {
			viewModel.fetchBook(url: book.url)
		}else {
			bookResult(content: book.content)
		}
		
		
		header.setNavigator(viewController: self)
		
		header.config(title: "", viewController: self)
	


		Utility.logAllAvailableFonts()
	
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		loadingView.frame = CGRect(
			x: 0, y: 0,width: view.frame.width, height: view.frame.height )
	}
	
}

extension ParserVC : ParserViewModelDelegate {
	func onLoading() {
		view.addSubview(loadingView)
	}
	
	func onError(error: BaseService.Error) {
		hideLoading()
		
		print("error \(error)")
	}
	
	func onEmpty() {
		print("onEmpty")
	}
	
	func bookResult(content: String){
		hideLoading()
		if book.name.isEmpty{
			viewModel.saveBook(book:
				Book(name: "Book #", url: book.url, content: content))
		}
		
		
//
		let result = SwiftyMarkdown(string:
			content
				//.replacingOccurrences(of: "\\#+\n\\s*", with: "$1", options: [.regularExpression])
				
			.replacingOccurrences(of: "(\\#+)", with: "\n$1", options: [.regularExpression])
			//.replacingOccurrences(of: "(\\[A-Z]+)", with: "\n$1\n", options: [.regularExpression])
			
		)
		
		//print("\(content)")
		
		result.h1.fontName = "Tiempo-BoldItalic"
		result.italic.fontName = "Tiempo-Italic"
		result.bold.fontName = "Tiempo-Bold"
		result.body.fontName = "Tiempo-"
		
		
		result.h1.fontSize = 25
		result.h2.fontSize = 23
		result.h3.fontSize = 22
		result.h4.fontSize = 20
		result.h5.fontSize = 19
		result.h6.fontSize = 18
		
		result.body.fontSize = 17
		result.code.fontSize = 16
		
	
//		let myStyle = Style("super", {
//			$0.font = FontAttribute(.TimesNewRomanPS_BoldItalicMT, size: 40) // font + size
//			$0.underline = UnderlineAttribute(color: UIColor.blue, style: NSUnderlineStyle.styleSingle) // underline attributes
//			$0.color = UIColor(hex: "#FF4555") // text color
//			$0.align = .center // text alignment
//		})
//
		let lineSpacing: CGFloat = 6.2
		
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = lineSpacing
		paragraphStyle.paragraphSpacing = CGFloat(0.50 * lineSpacing)
		paragraphStyle.alignment = .left
		
		
		textContainer.attributedText =  result
			.attributedString()
			.withAttribute(Attribute.paragraphStyle(paragraphStyle)
		)
	}
	
	func hideLoading() {
		loadingView.removeFromSuperview()
	}
	
	

}

