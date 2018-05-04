//
//  Book.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/25/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//
import Foundation
import RealmSwift

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
	
	override static func primaryKey() -> String? {
		return "ID"
	}
	
}

