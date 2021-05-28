//
//  Extensions.swift
//  
//
//  Created by tarunon on 2021/05/03.
//

@_exported import Builder
import Combine

@available(iOS 13.0, *)
@available(macOS 10.15, *)
extension BuildSet.Optional: Publisher where
    C: Publisher {
    public typealias Output = C.Output
    public typealias Failure = C.Failure
    
    public func receive<S>(subscriber: S) where S : Subscriber, C.Failure == S.Failure, C.Output == S.Input {
        switch self {
        case .some(let value):
            value.receive(subscriber: subscriber)
        case .none:
            Empty<C.Output, C.Failure>().receive(subscriber: subscriber)
        }
    }
}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
extension BuildSet.Either: Publisher where
    L: Publisher,
    R: Publisher,
    L.Failure == R.Failure {
    public typealias Output = BuildSet.Either<L.Output, R.Output>
    public typealias Failure = L.Failure
    
    public func receive<S>(subscriber: S) where
        S : Subscriber,
        L.Failure == S.Failure,
        BuildSet.Either<L.Output, R.Output> == S.Input {
        switch self {
        case .left(let value):
            value.map { .left($0) }.receive(subscriber: subscriber)
        case .right(let value):
            value.map { .right($0) }.receive(subscriber: subscriber)
        }
    }
}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
extension BuildSet.Sequence: Publisher where C: Publisher {
    public typealias Output = C.Output
    public typealias Failure = C.Failure
    
    public func receive<S>(subscriber: S) where S : Subscriber, C.Failure == S.Failure, C.Output == S.Input {
        Publishers.MergeMany<C>(self).receive(subscriber: subscriber)
    }
}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
extension Publishers {
    public enum Either<L, R>: Publisher where
        L: Publisher,
        R: Publisher,
        L.Output == R.Output,
        L.Failure == R.Failure {
        public typealias Output = L.Output
        public typealias Failure = L.Failure
    
        case left(L)
        case right(R)
        
        public func receive<S>(subscriber: S) where
            S : Subscriber,
            L.Failure == S.Failure,
            L.Output == S.Input {
            switch self {
            case .left(let value):
                value.receive(subscriber: subscriber)
            case .right(let value):
                value.receive(subscriber: subscriber)
            }
        }
    }
}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
extension Builder where Return: Publisher {
    public static func buildEither<T, F>(first component: T) -> Publishers.Either<T, F> {
        .left(component)
    }
    
    public static func buildEither<T, F>(second component: F) -> Publishers.Either<T, F> {
        .right(component)
    }
    
    public static func buildBlock() -> Empty<Void, Never> {
        .init()
    }
    
    @_disfavoredOverload
    public static func buildBlock<T, E>() -> Empty<T, E> {
        .init()
    }
    
    public static func buildBlock<C0, C1>(
        _ component0: C0,
        _ component1: C1
    ) -> Publishers.Merge<C0, C1> {
        .init(
            component0,
            component1
        )
    }
    
    public static func buildBlock<C0, C1, C2>(
        _ component0: C0,
        _ component1: C1,
        _ component2: C2
    ) -> Publishers.Merge3<C0, C1, C2> {
        .init(
            component0,
            component1,
            component2
        )
    }
    
    public static func buildBlock<C0, C1, C2, C3>(
        _ component0: C0,
        _ component1: C1,
        _ component2: C2,
        _ component3: C3
    ) -> Publishers.Merge4<C0, C1, C2, C3> {
        .init(
            component0,
            component1,
            component2,
            component3
        )
    }
    
    public static func buildBlock<C0, C1, C2, C3, C4>(
        _ component0: C0,
        _ component1: C1,
        _ component2: C2,
        _ component3: C3,
        _ component4: C4
    ) -> Publishers.Merge5<C0, C1, C2, C3, C4> {
        .init(
            component0,
            component1,
            component2,
            component3,
            component4
        )
    }
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5>(
        _ component0: C0,
        _ component1: C1,
        _ component2: C2,
        _ component3: C3,
        _ component4: C4,
        _ component5: C5
    ) -> Publishers.Merge6<C0, C1, C2, C3, C4, C5> {
        .init(
            component0,
            component1,
            component2,
            component3,
            component4,
            component5
        )
    }
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6>(
        _ component0: C0,
        _ component1: C1,
        _ component2: C2,
        _ component3: C3,
        _ component4: C4,
        _ component5: C5,
        _ component6: C6
    ) -> Publishers.Merge7<C0, C1, C2, C3, C4, C5, C6> {
        .init(
            component0,
            component1,
            component2,
            component3,
            component4,
            component5,
            component6
        )
    }
    
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7>(
        _ component0: C0,
        _ component1: C1,
        _ component2: C2,
        _ component3: C3,
        _ component4: C4,
        _ component5: C5,
        _ component6: C6,
        _ component7: C7
    ) -> Publishers.Merge8<C0, C1, C2, C3, C4, C5, C6, C7> {
        .init(
            component0,
            component1,
            component2,
            component3,
            component4,
            component5,
            component6,
            component7
        )
    }
}
