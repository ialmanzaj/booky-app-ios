//
//  String.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/28/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import Foundation

extension NSAttributedString {
	func condensingWhitespace() -> String {
		return self.string.components(separatedBy: .whitespacesAndNewlines)
			.filter { !$0.isEmpty }
			.joined(separator: " ")
	}
}
