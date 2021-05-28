//
//  CombineBuilderTests.swift
//  
//
//  Created by tarunon on 2021/05/03.
//

import XCTest
import Combine
import CombineBuilder

@available(iOS 13.0, *)
@available(macOS 10.15, *)
final class CombineBuilderTests: XCTestCase {    
    func testFlatMapWithOptional() {
        let a = (0..<5).publisher.flatMap(builder { i in
            if i % 2 == 0 {
                ["\(i)"].publisher
            }
        })
        
        var results = [String]()
        _ = a.sink(receiveValue: { value in
            results.append(value)
        })
        
        XCTAssertEqual(results, ["0", "2", "4"])
    }
    
    func testFlatMapWithEither() {
        let a = (0..<5).publisher.flatMap(builder { i in
            if i % 2 == 0 {
                ["\(i)"].publisher
            } else {
                Result<Int, Error>.success(i).publisher
                    .catch { _ in Empty<Int, Never>() }
            }
        })
        
        var results = [BuildSet.Either<String, Int>]()
        _ = a.sink(receiveValue: { value in
            results.append(value)
        })
        
        XCTAssertEqual(results, [
            .left("0"),
            .right(1),
            .left("2"),
            .right(3),
            .left("4"),
        ])
    }
    
    func testFlatMapFoldInEitherSameType() {
        let a = (0..<5).publisher.flatMap(builder { i in
            if i % 2 == 0 {
                [i].publisher
            } else {
                Result<Int, Error>.success(i).publisher
                    .catch { _ in Empty<Int, Never>() }
            }
        })
        
        var results = [Any]()
        _ = a.sink(receiveValue: { value in
            results.append(value)
        })

        XCTAssertEqual(results as? [Int], [0, 1, 2, 3, 4])
    }
    
    func testFlatMapWithSequence() {
        let a = (0..<5).publisher.flatMap(builder { i in
            for j in 0..<i {
                [i + j].publisher
            }
        })
        
        var results = [Int]()
        _ = a.sink(receiveValue: { value in
            results.append(value)
        })
        
        XCTAssertEqual(results, [
            1,
            2,
            3,
            3,
            4,
            5,
            4,
            5,
            6,
            7,
        ])
    }
}

