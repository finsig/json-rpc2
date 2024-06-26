//
//  Created by Steven Boynes on 2/9/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import JSONRPC2

class IdentifierTests: XCTestCase {
    
    func testDecodeStringIdentifierValue() throws {
        let string = ""
        let data = try! JSONSerialization.data(withJSONObject: string, options: .fragmentsAllowed)
        let decoded = try! JSONDecoder().decode(Identifier.self, from: data)
        
        XCTAssertTrue( decoded.value is String )
    }
    
    func testDecodeIntegerIdentifierValue() throws {
        let integer = Int.zero
        let data = try! JSONSerialization.data(withJSONObject: integer, options: .fragmentsAllowed)
        let decoded = try! JSONDecoder().decode(Identifier.self, from: data)
        
        XCTAssertTrue( decoded.value is Int )
    }
    
    func testDecodeNullIdentifierValue() throws {
        let null = NSNull()
        let data = try! JSONSerialization.data(withJSONObject: null, options: .fragmentsAllowed)
        let decoded = try! JSONDecoder().decode(Identifier.self, from: data)
        
        XCTAssertTrue( decoded.value is NSNull )
    }
    
    func testEquatableStringIdentifierValue() throws {
        let identifier1 = Identifier.string("polkadot")
        let identifier2 = Identifier.string("polkadot")
        
        XCTAssertEqual( identifier1, identifier2 )
    }
    
    func testEquatableIntegerIdentifierValue() throws {
        let identifier1 = Identifier.int(1)
        let identifier2 = Identifier.int(1)
        
        XCTAssertEqual( identifier1, identifier2 )
    }
    
    func testEquatableNullIdentifierValue() throws {
        let identifier1 = Identifier.nsNull(NSNull())
        let identifier2 = Identifier.nsNull(NSNull())
        
        XCTAssertEqual( identifier1, identifier2 )
    }
}
