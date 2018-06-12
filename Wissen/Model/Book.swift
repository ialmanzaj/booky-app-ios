//
//  Book.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/25/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//
import Foundation
import RealmSwift

struct Info : Codable {
	let PDFFormatVersion: String?
	let Title: String?
	let Author: String?
	let Keywords: String?
}
struct Metadata : Codable {
	let info: Info?
	
	func toJSON() -> [String:Any] {
		return [
			"info": info ?? "",
		]
	}
}

struct BookElement: Codable {
	let book: String
	let metadata: Metadata?
	let pages: Int?
	
	func toJSON() -> [String:Any] {
		return [
			"book": book,
			"metadata": metadata ?? "",
			"pages" : pages ?? "",
		]
	}
}

extension Object {
	func incrementID<T:Object>(_ value: T) -> Int {
		let realm = try! Realm()
		return (realm.objects(T.self).max(ofProperty: "ID") as Int? ?? 0) + 1
	}
}

class Book : Object, Codable {
	@objc dynamic var ID = 0
	@objc dynamic var name: String = ""
	@objc dynamic var url: String = ""
	@objc dynamic var cover: String = ""
	@objc dynamic var content: String = ""
	@objc dynamic var metadata: String = ""

	convenience init(url: String) {
		self.init()
		self.url = url
	}
	
	convenience init(name: String, url: String?, content: String) {
		self.init()
		self.ID = incrementID(self)
		self.name = name + String(self.ID)
		self.url = url ?? ""
		self.content = content
	}
	
	convenience init(name: String, url: String?, content: String, metadata: String) {
		self.init()
		self.ID = incrementID(self)
		self.name = name + String(self.ID)
		self.url = url ?? ""
		self.content = content
		self.metadata = metadata
	}
	
	override static func primaryKey() -> String? {
		return "ID"
	}
	
}

