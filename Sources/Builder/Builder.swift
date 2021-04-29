

@resultBuilder
public struct Builder {
    public static func buildBlock<C>(_ components: C) -> C {
        components
    }
    
    public static func buildEither<C>(first component: C) -> C {
        component
    }
    
    public static func buildEither<C>(second component: C) -> C {
        component
    }
    
    
    public static func buildOptional<C>(_ component: C?) -> C? {
        component
    }
    
    public static func buildArray<C>(_ components: [C]) -> [C] {
        components
    }
}

public func build<C>(@Builder _ f: @escaping () -> C) -> C {
    f()
}

public func build<A, C>(@Builder _ f: @escaping (A) -> C) -> (A) -> C {
    f
}
