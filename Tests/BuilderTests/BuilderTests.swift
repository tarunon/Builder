    import XCTest
    @testable import Builder

    final class BuilderTests: XCTestCase {
        func testBuildStatement() {
            let a = build { 1 }
            print(type(of: a))
            
            let b = build {
                if a % 2 == 0 {
                    1
                }
            }
            
            print(type(of: b))
            
            let c = build {
                if a % 2 == 0 {
                    1
                } else {
                    2
                }
            }
            
            print(type(of: c))
            
            let d = build {
                for i in 0..<10 {
                    i
                }
            }
            
            print(type(of: d))
        }
        
        func testBuildInFlatMap() {
            let a = (0..<30).map(build {
                if $0 % 2 == 0 {
                    "a"
                } else {
                    "b"
                }
            })
            
            print(a)
        }
        }
    }
