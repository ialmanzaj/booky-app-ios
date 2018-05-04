//
//  PdfService.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/22/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import Foundation
import Alamofire

class ConverterService : BaseService {
	
	func getBook(bookUrl url: String, completation:  @escaping FetchCompletation){
		let parameters: Parameters = [
			"url": url,
		]
		Alamofire.request(
			API_URL,
			method: .post,
			parameters: parameters,
			headers: nil
			).responseData { response in
				
				// Return early on failure
				guard response.response?.statusCode == 200 else {
					print("failure \(response.response?.statusCode)")
					print("debugDescription \(response.result)")
					completation(State.Error(Error.ModelError))
					return
				}

		
				let book = String(data: response.data!, encoding: .utf8)
				
				//print("book \(book)")
			
				completation(State.onData(book!))
		}
	}
	
}
