//
//  File.swift
//  
//
//  Created by tarunon on 2021/05/03.
//

public enum BuildSet {
    public enum Optional<C> {
        case some(C)
        case none
    }
    
    public enum Either<L, R> {
        case left(L)
        case right(R)
    }
    
    public struct Sequence<C>: Swift.Sequence {
        var values: [C]
        public func makeIterator() -> Array<C>.Iterator {
            values.makeIterator()
        }
    }
}

extension BuildSet.Optional: Equatable where C: Equatable {}
extension BuildSet.Either: Equatable where L: Equatable, R: Equatable {}
extension BuildSet.Sequence: Equatable where C: Equatable {}
