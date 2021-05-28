@resultBuilder
public struct Builder<LeastCommon, Return> {
    @_disfavoredOverload
    public static func buildBlock<C>(_ component: C) -> C {
        component
    }
    
    public static func buildEither(first component: LeastCommon) -> LeastCommon {
        component
    }
    
    public static func buildEither(second component: LeastCommon) -> LeastCommon {
        component
    }
    
    @_disfavoredOverload
    public static func buildEither<T, F>(first component: T) -> BuildSet.Either<T, F> {
        .left(component)
    }
    
    @_disfavoredOverload
    public static func buildEither<T, F>(second component: F) -> BuildSet.Either<T, F> {
        .right(component)
    }
    
    public static func buildOptional<C>(_ component: C?) -> C? {
        component
    }
    
    @_disfavoredOverload
    public static func buildOptional<C>(_ component: C?) -> BuildSet.Optional<C> {
        component.map { .some($0) } ?? .none
    }
    
    public static func buildArray<C>(_ components: [C]) -> [C] {
        components
    }
    
    @_disfavoredOverload
    public static func buildArray<C>(_ components: [C]) -> BuildSet.Sequence<C> {
        .init(values: components)
    }
    
    @_disfavoredOverload
    public static func buildExpression<C>(_ expression: C) -> C {
        expression
    }
    
    @_disfavoredOverload
    public static func buildFinalResult(_ component: Return) -> Return {
        component
    }
}

@_disfavoredOverload
public func build<Return>(@Builder<Return, Return> _ f: @escaping () -> Return) -> Return {
    f()
}

public func build<LeastCommon, Return>(_ leastCommonType: LeastCommon.Type = LeastCommon.self, @Builder<LeastCommon, Return> _ f: @escaping () -> Return) -> Return {
    f()
}

@_disfavoredOverload
public func builder<Argument, Return>(@Builder<Return, Return> _ f: @escaping (Argument) -> Return) -> (Argument) -> Return {
    f
}

public func builder<LeastCommon, Argument, Return>(_ leastCommonType: LeastCommon.Type = LeastCommon.self, @Builder<LeastCommon, Return> _ f: @escaping (Argument) -> Return) -> (Argument) -> Return {
    f
}
