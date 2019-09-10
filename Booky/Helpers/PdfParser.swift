//
//  PdfParser.swift
//  Wissen
//
//  Created by Isaac Almanza on 5/7/19.
//  Copyright © 2019 Isaac Almanza. All rights reserved.
//

import Foundation
import SwiftyMarkdown
import SwiftyAttributes
import SwiftRichString

class PDFParser {
	static func getbookParsed(content: String) -> NSAttributedString {
		let result = SwiftyMarkdown(string:
			content
				//.replacingOccurrences(of: "\\n{2,}", with: "$1\n", options: [.regularExpression])
				.replacingOccurrences(of: "\\#+\n\\s*", with: "$1", options: [.regularExpression])
				.replacingOccurrences(of: "(\\#+)", with: "\n$1", options: [.regularExpression])
			//.replacingOccurrences(of: "(\\[A-Z]+)", with: "\n$1\n", options: [.regularExpression])
		)
		
		Utility.logAllAvailableFonts()
		
		result.h1.fontName = "Futura-CondensedExtraBold"
		result.italic.fontName = "Futura-MediumItalic"
		result.bold.fontName = "Futura-Bold"
		result.body.fontName = "Futura-Medium"
		
		result.h1.fontSize = 27
		result.h2.fontSize = 25
		result.h3.fontSize = 24
		result.h4.fontSize = 23
		result.h5.fontSize = 22
		result.h6.fontSize = 21
		
		result.body.fontSize = 17
		result.code.fontSize = 16
		
		
		//		let normal = Style.default {
		//			let lineSpacing: CGFloat = 6.2
		//			$0.lineSpacing = Float(lineSpacing)
		//			$0.paragraphSpacing = Float(CGFloat(0.25 * lineSpacing))
		//			$0.align = .left // text alignment
		//			$0.lineBreak = .byCharWrapping
		//		}
		//
		let lineSpacing: CGFloat = 4.5
		
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = lineSpacing
		paragraphStyle.paragraphSpacing = CGFloat(0.60 * lineSpacing)
		paragraphStyle.alignment = .left
		paragraphStyle.lineBreakMode = .byWordWrapping
		
		
		let book_final = result.attributedString().withAttribute(Attribute.paragraphStyle(paragraphStyle))
		return book_final
	}
}
