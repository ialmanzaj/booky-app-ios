//
//  DecodableItem.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/26/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import Foundation

struct DecodableItem<T: Decodable> : Decodable {
	let base : T?
	
	init(from decode: Decoder) throws {
		let container = try decode.singleValueContainer()
		self.base = try? container.decode(T.self)
	}
}
