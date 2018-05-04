//
//  Object.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/26/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import Foundation
import RealmSwift

extension Object {
	func toDictionary() -> Dictionary<String, AnyObject>? {
		let properties = self.objectSchema.properties.map { $0.name }
		let dictionary = self.dictionaryWithValues(forKeys: properties)
		
		let mutabledic = NSMutableDictionary()
		mutabledic.setValuesForKeys(dictionary)
		
		for prop in (self.objectSchema.properties as [Property]?)! {
			// find lists
			if prop.objectClassName != nil  {
				if let nestedObject = self[prop.name] as? Object {
					mutabledic.setValue(nestedObject.toDictionary(), forKey: prop.name)
				} else if let nestedListObject = self[prop.name] as? ListBase {
					var objects = [AnyObject]()
					for index in 0..<nestedListObject._rlmArray.count  {
						if let object = nestedListObject._rlmArray[index] as? Object {
							objects.append(object.toDictionary() as AnyObject)
						}
					}
					mutabledic.setObject(objects, forKey: prop.name as NSCopying)
				}
			}
		}
		return mutabledic as? Dictionary<String, AnyObject>
	}
}
