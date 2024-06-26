//
//  Created by Steven Boynes on 2/9/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

/**
 A struct representing a Request.

 [JSON-RPC 2.0](https://www.jsonrpc.org/specification)
 
*/
public struct Request {
    public let jsonRPCVersion: JSONRPCVersion
    public let method: String
    public var parameters: Parameters?
    public var identifier: Identifier?
    
    public init(method: String, parameters: Parameters? = nil, identifier: Identifier?) {
        self.jsonRPCVersion = .jsonRPC2
        self.method = method
        self.parameters = parameters
        self.identifier = identifier
    }
    
    /// Initialize a Request from a JSON string representation
    ///
    public init(string: String) throws {
        guard let data = string.data(using: .utf8) else {
            throw JSONRPC2Error(code: -32700, message: "Parse error", errorInfo: nil)
        }
        guard let request = try? JSONDecoder().decode(Request.self, from: data) else {
            throw JSONRPC2Error(code: -32600, message: "Invalid Request", errorInfo: nil)
        }
        self.init(method: request.method, parameters: request.parameters, identifier: request.identifier!)
    }
}

extension Request: Codable {
    enum CodingKeys: String, CodingKey {
        case jsonRPCVersion = "jsonrpc"
        case method = "method"
        case params = "params"
        case identifier = "id"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        jsonRPCVersion = try container.decode(String.self, forKey: .jsonRPCVersion)
        guard jsonRPCVersion == .jsonRPC2 else {
            throw JSONRPC2Error(code: -32600, message: "Invalid Request", errorInfo: nil)
        }
        method = try container.decode(String.self, forKey: .method)
        identifier = try container.decodeIfPresent(Identifier.self, forKey: .identifier)
        parameters = try container.decodeIfPresent(Request.Parameters.self, forKey: .params)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(jsonRPCVersion, forKey: .jsonRPCVersion)
        try container.encode(method, forKey: .method)
        try container.encodeIfPresent(identifier, forKey: .identifier)
        try container.encodeIfPresent(parameters, forKey: .params)
    }
}
