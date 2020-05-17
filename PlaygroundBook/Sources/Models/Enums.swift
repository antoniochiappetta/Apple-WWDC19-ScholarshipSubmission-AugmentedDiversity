public enum Country: String {
    case China, Egypt, Italy, Mexico
}

public typealias Clothes = Country
public typealias Skin = Country
public typealias Hair = Country

public enum Dish: String {
    case Gyoza = "Gyoza", KushariTea = "Kushari Tea", Pizza = "Napoli's Pizza", Tacos = "Tacos"
    
    init(country: Country) {
        switch country {
        case .China:
            self = .Gyoza
        case .Egypt:
            self = .KushariTea
        case .Italy:
            self = .Pizza
        case .Mexico:
            self = .Tacos
        }
    }
    
    func getCountry() -> Country {
        switch self {
        case .Gyoza:
            return .China
        case .KushariTea:
            return .Egypt
        case .Pizza:
            return .Italy
        case .Tacos:
            return .Mexico
        }
    }
}

public enum Place: String {
    case ChineseWall = "Chinese Wall", Pyramids = "Pyramids", Colosseum = "Roma's Colosseum!", MayaTemples = "Maya Temples"
    
    init(country: Country) {
        switch country {
        case .China:
            self = .ChineseWall
        case .Egypt:
            self = .Pyramids
        case .Italy:
            self = .Colosseum
        case .Mexico:
            self = .MayaTemples
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
        case .MayaTemples:
            return .Mexico
        }
    }
}

public enum Skill: String {
    case MartialArts = "Martial arts", Camels = "Ride camels", Football = "Play football", Corrida = "Corrida"
    
    init(country: Country) {
        switch country {
        case .China:
            self = .MartialArts
        case .Egypt:
            self = .Camels
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
        case .Camels:
            return .Egypt
        case .Football:
            return .Italy
        case .Corrida:
            return .Mexico
        }
    }
}
