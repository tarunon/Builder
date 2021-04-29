//
//  Either.swift
//  
//
//  Created by tarunon on 2021/04/29.
//

public enum Either<L, R> {
    case left(L)
    case right(R)
}
