//
//  Parser.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/26/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import Foundation


class Parser {
	
	private enum DecodeError: String, Error {
		case emptyObject = "Cannot get array or dictionary"
		case unknownError = "Something failed during decoding"
	}
	
	static func convert<T : Decodable>(from dict: Any, to resultClass: T.Type) -> T? {
		//print("convert from dict")
		do {

			//print("object \(object)")
			
			guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
				throw DecodeError.unknownError
			}
			
			//print("data \(data)")
			
			
			guard let result = try? JSONDecoder().decode(resultClass, from: data) else {
				throw DecodeError.unknownError
			}
			
			//sprint("\n result \(result)")
			return result
			
		} catch {
			print("Decoding Error: \(error)")
			return nil
		}
	}
	
	static func convert<T : Decodable>(fromData data: Data?, to resultClass: T.Type) -> T? {
		//print("convert from data")
		do {
			
			guard let data = data else {
				throw DecodeError.emptyObject
			}
			
			guard let result = try? JSONDecoder().decode(resultClass, from: data) else {
				throw DecodeError.unknownError
			}
			
			//print("\n result \(result)")
			
			return result
			
		} catch {
			print("Error converting JSON to data \(error)")
		}
		
		return nil
	}
}
