//
//  BaseService.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/23/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import Foundation

class BaseService: NSObject {

	typealias FetchCompletation = ((_ state: State) -> Void)
	
	enum State {
		case onData(Any)
		case Empty
		case Error(Error)
	}
	
	enum Error {
		case ModelError
		case AuthError(String)
	}

}
