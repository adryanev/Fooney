//
//  Loadable.swift
//  Fooney
//
//  Created by Adryan Eka Vandra on 20/03/23.
//

public enum Loadable<T> {
    case initial
    case loading
    case loaded(T)
}

extension Loadable: Equatable where T: Equatable {}

public protocol Functor {
    associatedtype A
    associatedtype B: Functor = Self
    
    func map<C>(_ transform: (A) -> (C)) -> B where B.A == C
    func tryMap<C>(_ transform: (A) throws -> C) throws -> B where B.A == C
    
    
}

extension Loadable: Functor {
    public typealias A = T
    
    public func map<C>(_ transform: (T) -> C) -> Loadable<C> {
        switch self {
            case .initial: return .initial
            case .loading: return .loading
            case .loaded(let value): return .loaded(transform(value))
        }
    }

    public func tryMap<C>(_ transform: (T) throws -> C) throws -> Loadable<C> {
        switch self {
            case .initial: return .initial
            case .loading: return .loading
            case .loaded(let value): return .loaded(try transform(value))
        }
    }
}
