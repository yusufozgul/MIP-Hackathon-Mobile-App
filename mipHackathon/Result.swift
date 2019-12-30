//
//  Result.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation

public enum ApiResult<Value>
{
    case succes(Value)
    case error(errorType: ApiErrorTypes)
}

public enum ApiErrorTypes: String
{
    case serverError = "SERVER_ERROR"
    case internetError = "NETWORK_ERROR"
    case dataParseError = "DATA_PARSE_ERROR"
    case emptyDataError = "EMPTY_ERROR"
    case otherError = "OTHER_ERROR"
}
