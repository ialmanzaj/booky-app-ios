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
	
	let URL_CONVERT = "\(API_URL)/"
	
	func getBook<T: Decodable>(file: Data,
							   type: T.Type, completation:  @escaping FetchCompletation){
	
		let headers: HTTPHeaders = [
			/* "Authorization": "your_access_token",  in case you need authorization header */
			"Content-type": "multipart/form-data"
		]
		
		//print("file \(file)")
	
		Alamofire.upload(multipartFormData: { multipartFormData in
			
			multipartFormData.append(file,
									 withName: "book",
									 fileName: "book.pdf",
									 mimeType: "application/pdf"
			)
			
		
			//print("\n \n Multi part Content-Type \(multipartFormData.contentType)")
			//print("\n \n Multi part Content-Length \(multipartFormData.contentLength)")
			//print("Multi part Content-Boundary \(multipartFormData.boundary)")
			
			
		}, to: URL_CONVERT, method: .post, headers: headers) { result in
			
			switch result {
				case .success(let upload, _, _):
					upload.uploadProgress(closure: { (progress) in
						print("Upload Progress: \(progress.fractionCompleted)")
					})
					upload.responseJSON { response in
						if let error = response.error {
							print("Error in upload: \(error.localizedDescription)")
							completation(State.Error(Error.ModelError))
							return
						}
					
						let data = response.data
						print("Succesfully uploaded \(data)")
	
						let book = Parser.convert(from: data, to: T.self)
						
						if book == nil {
							completation(State.Error(BaseService.Error.ModelError))
							return
						}
						
						completation(State.onData(book))
					}
				case .failure(let error):
					print("failure \(error)")
					//print("debugDescription \(response.result)")
					completation(State.Error(Error.ModelError))
				}
			
		}
		
	}
		
	func getBook<T: Decodable>(bookUrl url: String,
							   type: T.Type, completation:  @escaping FetchCompletation){
		let parameters: Parameters = [
			"url": url,
		]
		Alamofire.request(
			URL_CONVERT,
			method: .post,
			parameters: parameters,
			headers: nil
			).responseData { response in
				
				// Return early on failure
				guard response.response?.statusCode == 200 else {
					print("failure \(String(describing: response.response?.statusCode))")
					//print("debugDescription \(response.result)")
					completation(State.Error(Error.ModelError))
					return
				}
				
				let data = response.data
				
//				do {
//					let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
//					print("json \(json)")
//				} catch let error as NSError {
//					print("Failed to load: \(error.localizedDescription)")
//				}
				let obj = Parser.convert(from: data, to: T.self)
				
				if obj == nil {
					completation(State.Error(BaseService.Error.ModelError))
					return
				}
				
				completation(State.onData(obj))
		}
	}
	
	
}
