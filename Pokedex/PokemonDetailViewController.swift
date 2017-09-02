//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Raviv Benami on 31/08/2017.
//  Copyright © 2017 Raviv Benami. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var seg: UISegmentedControl!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenceLvl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var curruntEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    var pokemon:Pokemon!
    
    override func viewDidLoad() {
        let img: UIImage = UIImage(named: "\(pokemon.pokedexId)")!
        mainImg.image = img
        curruntEvoImg.image = img
        pokedexLbl.text = "\(pokemon.pokedexId)"
        nameLbl.text = pokemon.name.capitalized
        
        pokemon.downloadPokemonDetails {
            print("did arrive here")
            self.updateUI()

        }
    }
    func updateUI() {
        attackLbl.text = pokemon.attack
        defenceLvl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        detailLbl.text = pokemon.description
        
        if pokemon.nextEvoId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.isHidden = true
        }
        else{
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvoId)
            let str = "Next Evolution: \(pokemon.nextEvoName) - LVL \(pokemon.nextEvolvl)"
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }


}
