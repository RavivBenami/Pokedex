//
//  Pokemon.swift
//  Pokedex
//
//  Created by Raviv Benami on 30/08/2017.
//  Copyright © 2017 Raviv Benami. All rights reserved.
//

import Foundation

class Pokemon{
private var _name:String!
private var _pokedexId:Int!
private var _description: String!
private var _type: String!
private var _defense: String!
private var _height: String!
private var _weight: String!
private var _attack: String!
private var _nextEvolutionTxt: String!
private var _nextEvoName:String!
private var _pokemonUrl: String!
private var _nextEvoId:String!
private var _nextEvoLvl:String!
    var nextEvoName:String {
        if _nextEvoName == nil {
            _nextEvoName = ""
        }
        return _nextEvoName
    }
        var nextEvoId:String {
            if _nextEvoId == nil {
                _nextEvoId = ""
            }
            return _nextEvoId
    }
            var nextEvolvl:String {
                if _nextEvoLvl == nil {
                    _nextEvoLvl = ""
                }
                  return _nextEvoLvl
    }
    
var attack:String {
if _attack == nil {
_attack = ""
}
return _attack
}
var weight:String {
if _weight == nil {
_weight = ""
}
return _weight
}
var height:String {
if _height == nil {
_height = ""
}
return _height
}
var defense:String {
if _defense == nil {
_defense = ""
}
return _defense
}
var type:String {
if _type == nil {
_type = ""
}
return _type
}
var nextEvoText:String {
if _nextEvolutionTxt == nil {
_nextEvolutionTxt = ""
}
return _nextEvolutionTxt
}
var description:String {
if _description == nil {
_description = "ad"
}
return _description
}
var name: String{
return _name
}
var pokedexId : Int{
return _pokedexId
}

init(name :String, pokedexId: Int) {
self._name = name
self._pokedexId = pokedexId
self._pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
}
func downloadPokemonDetails(completed: @escaping DownloadComplete){
let url = URL(string: _pokemonUrl)
let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
if error != nil
{
print(error!,"-----------------------------------------")
}
else {
if let content = data
{
do
{
let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableLeaves) as AnyObject
 if let dict = myJson as? Dictionary<String,AnyObject>{
    if let weight = dict["weight"] as? String{
        self._weight = weight
    }
    if let height = dict["height"] as? String{
        self._height = height
    }
    if let attack = dict["attack"] as? Int{
        self._attack = "\(attack)"
    }
    if let defense = dict["defense"] as? Int{
        self._defense = "\(defense)"
    }
    if let types = dict["types"] as? [Dictionary<String,String>] , types.count > 0
    {
        if let firstType = types[0]["name"]
        {
            self._type = firstType.capitalized
        }
        else{
            self._type = ""
        }
        if types.count > 1 {
            for x in 1..<types.count {
                if let name = types[x]["name"]{
                    self._type! += "/\(name.capitalized)"
                }
                
            }
        }
        if let descArr = dict["descriptions"] as? [Dictionary<String,String>], descArr.count > 0 {
            if let urlString = descArr[0]["resource_uri"] {
                let url1 = URL(string: "\(URL_BASE)\(urlString)")
                let task1 = URLSession.shared.dataTask(with: url1!) {(data, response, error) in
                        if let content = data
                        {
                            do
                            {
                                let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableLeaves) as AnyObject
                                if let descDict = myJson as? Dictionary<String,AnyObject>{
                                    if let description1 = descDict["description"] as? String{
                                        self._description = description1
                                    }
                                }
                                completed()
                            }
                            catch{}
                                }
                }
                task1.resume()
              }
            
            }
        
        
    }
    if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>] , evolutions.count > 0
    {
        if let nextEvo = evolutions[0]["to"] as? String {
            if nextEvo.range(of: "mega") == nil
            {
                self._nextEvoName = nextEvo
                if let uri = evolutions[0]["resource_uri"] as? String {
                    let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                    let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                    self._nextEvoId = nextEvoId
                    if let lvlExist = evolutions[0]["level"]
                    {
                        if let lvl = lvlExist as? Int{
                            self._nextEvoLvl = "\(lvl)"
                        }
                    }
                    else{
                        self._nextEvoLvl = ""
                    }
                }
            }
        }
    }
    print(self._nextEvoLvl)
    print(self._nextEvoId)
    print(self._nextEvoName)
    print(self._type)
    print(self._weight)
    print(self._height)
    print(self._attack)
    print(self._defense)
    print(self._description)
}

}
catch {

}

}
}
}
task.resume()
}

}
