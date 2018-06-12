//
//  String.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/28/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import UIKit

extension NSAttributedString {
	func condensingWhitespace() -> String {
		return self.string.components(separatedBy: .whitespacesAndNewlines)
			.filter { !$0.isEmpty }
			.joined(separator: " ")
	}
}


extension UIImage {
	public class func gif(asset: String) -> UIImage? {
		if let asset = NSDataAsset(name: asset) {
			return UIImage.gif(data: asset.data)
		}
		return nil
	}
}
