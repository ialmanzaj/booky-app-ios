//
//  Encoder.swift
//  Wissen
//
//  Created by Isaac Almanza on 06/11/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import Foundation


extension JSONEncoder {
	func encodeJSONObject<T: Encodable>(_ value: T, options opt: JSONSerialization.ReadingOptions = []) throws -> Any {
		let data = try encode(value)
		return try JSONSerialization.jsonObject(with: data, options: opt)
	}
}

extension JSONDecoder {
	func decode<T: Decodable>(_ type: T.Type, withJSONObject object: Any, options opt: JSONSerialization.WritingOptions = []) throws -> T {
		let data = try JSONSerialization.data(withJSONObject: object, options: opt)
		return try decode(T.self, from: data)
	}
}
