//
//  SwiftiCloudTest.swift
//  Wissen
//
//  Created by Isaac Almanza on 05/16/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

//import UIKit
//enum DocumentReadError: ErrorType {
//	case InvalidInput
//}
//
//enum DocumentWriteError: ErrorType {
//	case NoContentToSave
//}
//
//class SwiftCloudTestDocument: UIDocument {
//	var documentContents:String?
//	override init(fileURL url: URL) {
//		super.init(fileURL: url as URL)
//	}
//	
//	override func loadFromContents(contents: AnyObject, ofType typeName: String?) throws {
//		if let castedContents = contents as? NSData {
//			documentContents = NSString(data: castedContents, encoding: NSUTF8StringEncoding) as? String
//		}else {
//			documentContents = nil
//			throw DocumentReadError.InvalidInput
//		}
//	}
//	
//	override func contentsForType(typeName: String) throws -> AnyObject {
//		if documentContents == nil {
//			throw DocumentWriteError.NoContentToSave
//		}
//		return 	documentContents!.dataUsingEncoding(NSUTF8StringEncoding)!
//	}
//}
