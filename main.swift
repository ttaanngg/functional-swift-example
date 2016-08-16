indirect enum List<A> {
    case Cons(a:A, b:List<A>)
    case None

    static func apply(arrays: Array<A>) -> List<A> {
        if arrays.isEmpty {
            return None
        }
        return Cons(a: arrays.first!, b: apply(Array(arrays.dropFirst())))
    }

    func length() -> Int {
        switch self {
        case .Cons(_, let b):
            return b.length() + 1
        case .None:
            return 0
        }
    }

    func map<B>(f: A -> B) -> List<B> {
        switch self {
        case .Cons(let h, let t):
            return List<B>.Cons(a: f(h), b: t.map(f))
        case .None:
            return .None
        }
    }

    func filter(f: A -> Bool) -> List<A> {
        switch self {
        case .Cons(let h, let t):
            if f(h) {
                return .Cons(a: h, b: t.filter(f))
            } else {
                return t.filter(f)
            }
        case .None:
            return None
        }
    }
}

let list = List.apply([21, 3, 12, 312])
print(list)
print(list.length())
print(list.map({ $0 + 1 }))
list.map({ print($0, terminator: " ") })
