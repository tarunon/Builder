import XCTest
import Builder

final class BuilderTypesTests: XCTestCase {
    func testBuildStatement() {
        let a = build { 1 }
        
        XCTAssertTrue(a is Int)
        
        let b = build {
            if a % 2 == 0 {
                1
            }
        }
        
        XCTAssertTrue(b is Int?)

        let c = build {
            if a % 2 == 0 {
                1
            } else {
                2
            }
        }
        
        XCTAssertTrue(c is Int)

        let d = build {
            for i in 0..<10 {
                i
            }
        }
        
        XCTAssertTrue(d is [Int])
    }
    
    func testBuildInFlatMap() {
        let a = (0..<30).map(builder {
            if $0 % 2 == 0 {
                "a"
            } else {
                "b"
            }
        })
        
        XCTAssertTrue(a is [String])
    }
    
    func testAcceptEither() {
        let flag = true
        let a = build {
            if flag {
                1
            } else {
                "test"
            }
        }
        
        XCTAssertTrue(a is BuildSet.Either<Int, String>)
    }
    
    func testAcceptLeastCommonType() {
        let a = [1, 2, 3].map(builder {
            if $0 % 2 == 0 {
                Basil()
            } else {
                Tomato()
            }
        })
        
        XCTAssertTrue(a is [BuildSet.Either<Basil, Tomato>])
        
        let b: [Plant] = [1, 2, 3].map(builder {
            if $0 % 2 == 0 {
                Basil()
            } else {
                Tomato()
            }
        })
        
        XCTAssertTrue(b is [Plant])
        
        let c = [1, 2, 3].map(builder {
            if $0 % 2 == 0 {
                Cat()
            } else {
                Dog()
            }
        })
        
        XCTAssertTrue(c is [Animal])
    }
    
//    func testOptimizeLCTEitherIf() {
//        let a = (0..<30).map(builder(String.self) { n in
//            if n % 15 == 0 {
//                "fizzbuzz"
//            } else if n % 3 == 0 {
//                "fizz"
//            } else if n % 5 == 0 {
//                "buzz"
//            } else {
//                n
//            }
//        })
//
//        XCTAssertTrue(a is [BuildSet.Either<String, BuildSet.Either<String, Int>>])
//    }
    
// Note: In Swift5.5, this function cannot compile no longer.
//    func testOptimizeLCTEitherSwitch() {
//        let a = (0..<30).map(builder { n in
//            switch (n % 3, n % 5) {
//            case (0, 0):
//                "fizzbuzz"
//            case (0, _):
//                "fizz"
//            case (_, 0):
//                "buzz"
//            default:
//                n
//            }
//        })
//
//        XCTAssertTrue(a is [BuildSet.Either<String, BuildSet.Either<String, Int>>])
//    }
}
