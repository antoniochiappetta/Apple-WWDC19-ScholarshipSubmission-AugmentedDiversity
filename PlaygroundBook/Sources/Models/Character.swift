//
//  Character.swift
//  Book_Sources
//
//  Created by Antonio Chiappetta on 24/03/2019.
//

import Foundation
import UIKit
import SpriteKit

open class Character {
    
    // MARK: - Properties
    
    open var country: Country?
    open var dish: Dish
    open var place: Place
    open var skill: Skill
    open var clothes: Clothes
    open var skin: Skin
    open var hair: Hair
    
    // MARK: - initialization
    
    public init (country: Country) {
        self.country = country
        self.dish = Dish(country: country)
        self.place = Place(country: country)
        self.skill = Skill(country: country)
        self.clothes = country
        self.skin = country
        self.hair = country
    }
    
    public init (dish: Dish, place: Place, skill: Skill, clothes: Clothes, skin: Skin, hair: Hair) {
        self.country = nil
        self.dish = dish
        self.place = place
        self.skill = skill
        self.clothes = clothes
        self.skin = skin
        self.hair = hair
    }
    
    // MARK: - GET Images
    
    public var characterImage: UIImage {
        return UIImage(named: "\(self.country!.rawValue)_character_1.png")!
    }
    
    public var characterTextures: [SKTexture] {
        let textureStart = SKTexture(imageNamed: "\(self.country!.rawValue)_character_1.png")
        let textureEnd = SKTexture(imageNamed: "\(self.country!.rawValue)_character_2.png")
        return [textureStart, textureEnd]
    }
    
    public var dishImage: UIImage {
        return UIImage(named: "\(self.dish.getCountry())_dish.png")!
    }
    
    public var placeImage: UIImage {
        return UIImage(named: "\(self.place.getCountry())_place.png")!
    }
    
    public var skillImage: UIImage {
        return UIImage(named: "\(self.skill.getCountry())_skill.png")!
    }
    
    public var clothesImage: UIImage {
        return UIImage(named: "\(self.clothes.rawValue)_clothes.png")!
    }
    
    public var skinImage: UIImage {
        return UIImage(named: "\(self.skin.rawValue)_skin_1.png")!
    }
    
    /** Use this in place of the image to provide hand animation */
    public var skinTextures: [SKTexture] {
        let textureStart = SKTexture(imageNamed: "\(self.skin.rawValue)_skin_1.png")
        let textureEnd = SKTexture(imageNamed: "\(self.skin.rawValue)_skin_2.png")
        return [textureStart, textureEnd]
    }
    
    public var hairImage: UIImage {
        return UIImage(named: "\(self.hair.rawValue)_skill.png")!
    }
    
}
