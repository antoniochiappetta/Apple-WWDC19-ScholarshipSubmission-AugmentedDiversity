//
//  Countries.swift
//  Book_Sources
//
//  Created by Antonio Chiappetta on 22/03/2019.
//

public enum Country: String {
    case China, Egypt, Italy, Mexico
}

public enum Dish: String {
    case Ramen, The, Pizza = "Napoli's Pizza!", Tacos
    
    init(country: Country) {
        switch country {
        case .China:
            self = .Ramen
        case .Egypt:
            self = .The
        case .Italy:
            self = .Pizza
        case .Mexico:
            self = .Tacos
        }
    }
    
    func getCountry() -> Country {
        switch self {
        case .Ramen:
            return .China
        case .The:
            return .Egypt
        case .Pizza:
            return .Italy
        case .Tacos:
            return .Mexico
        }
    }
}

public enum Place: String {
    case ChineseWall, Pyramids, Colosseum = "Roma's Colosseum!", MayaTemple
    
    init(country: Country) {
        switch country {
        case .China:
            self = .ChineseWall
        case .Egypt:
            self = .Pyramids
        case .Italy:
            self = .Colosseum
        case .Mexico:
            self = .MayaTemple
        }
    }
    
    func getCountry() -> Country {
        switch self {
        case .ChineseWall:
            return .China
        case .Pyramids:
            return .Egypt
        case .Colosseum:
            return .Italy
        case .MayaTemple:
            return .Mexico
        }
    }
}

public enum Skill: String {
    case MartialArts, Hieroglyphs, Football = "Football!", Corrida
    
    init(country: Country) {
        switch country {
        case .China:
            self = .MartialArts
        case .Egypt:
            self = .Hieroglyphs
        case .Italy:
            self = .Football
        case .Mexico:
            self = .Corrida
        }
    }
    
    func getCountry() -> Country {
        switch self {
        case .MartialArts:
            return .China
        case .Hieroglyphs:
            return .Egypt
        case .Football:
            return .Italy
        case .Corrida:
            return .Mexico
        }
    }
}
