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
import SwiftRichString

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
		
		loadingView.frame = CGRect(
			x: 0, y: 0,width: view.frame.width, height: view.frame.height )
	}
	
}

extension ParserVC : ParserViewModelDelegate {
	
	func bookResult(_ bookElement: BookElement){
		
		let content = bookElement.book
		
		let result = SwiftyMarkdown(string:
			content
				//.replacingOccurrences(of: "\\n{2,}", with: "$1\n", options: [.regularExpression])
				.replacingOccurrences(of: "\\#+\n\\s*", with: "$1", options: [.regularExpression])
				.replacingOccurrences(of: "(\\#+)", with: "\n$1", options: [.regularExpression])
			//.replacingOccurrences(of: "(\\[A-Z]+)", with: "\n$1\n", options: [.regularExpression])
		)

		result.h1.fontName = "Helvetica-BoldOblique"
		result.italic.fontName = "Helvetica-Oblique"
		result.bold.fontName = "Helvetica-Bold"
		result.body.fontName = "Helvetica"

		result.h1.fontSize = 27
		result.h2.fontSize = 25
		result.h3.fontSize = 24
		result.h4.fontSize = 23
		result.h5.fontSize = 22
		result.h6.fontSize = 21

		result.body.fontSize = 18
		result.code.fontSize = 17


//		let normal = Style.default {
//			let lineSpacing: CGFloat = 6.2
//			$0.lineSpacing = Float(lineSpacing)
//			$0.paragraphSpacing = Float(CGFloat(0.25 * lineSpacing))
//			$0.align = .left // text alignment
//			$0.lineBreak = .byCharWrapping
//		}
//
		let lineSpacing: CGFloat = 6.2

		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = lineSpacing
		paragraphStyle.paragraphSpacing = CGFloat(0.50 * lineSpacing)
		paragraphStyle.alignment = .left
		paragraphStyle.lineBreakMode = .byWordWrapping


		let book_final = result.attributedString().withAttribute(Attribute.paragraphStyle(paragraphStyle))
		
		
		textContainer.attributedText = book_final

	}

}

