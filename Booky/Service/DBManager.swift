//
//  DBManager.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/25/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//
import UIKit
import RealmSwift

class DBManager {
	
	private var database:Realm
	static let sharedInstance = DBManager()
	
	private init() {
		database = try! Realm()
	}
	
	func findBook(url: String) -> Book? {
		if let results = getDataFromDB(class: Book.self){
			let books = results.filter({ $0.url == url })
			if (books.count > 0){
				return books[0]
			}
			
		}
		return nil
	}
	
	func getDataFromDB<T: Decodable>(class: T.Type) -> [T]? {
		let results = database.objects(T.self as! Object.Type)
		if (results.count == 0){
			return nil
		}
		
		var list : [T] = []
		
		for index in 0...results.count - 1 {
			if let obj = Parser.convert(from: results[index].toDictionary()!, to: T.self) {
				list.append(obj)
			}
		}
	
		return list
	}
	
	func add<T : Object>(_ value: T)   {
		try! database.write {
			database.add(value, update: false)
		}
	}
	
	func update<T : Object>(_ value: T)   {
		try! database.write {
			database.add(value, update: true)
		}
	}
	
	func deleteAllFromDatabase()  {
		try!   database.write {
			database.deleteAll()
		}
	}
	
	func delete<T : Object>(_ value: T, primaryKey: Int)   {
		try!   database.write {
			let obj = database.object(ofType: T.self, forPrimaryKey: primaryKey)
			database.delete(obj!)
		}
	}
}
