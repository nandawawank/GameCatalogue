//
//  ViewController.swift
//  Game Catalogue
//
//  Created by Nanda Wawan Kurniawan on 23/12/20.
//  Copyright © 2020 Dicoding Indoneisa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameTableView: UITableView!
    @IBOutlet weak var buttonProfile: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        gameTableView.dataSource = self
        gameTableView.delegate = self
        gameTableView.register(
            UINib(nibName: "GameTableViewCell", bundle: nil),
            forCellReuseIdentifier: "GameCell"
        )
    
        addTapped(parameter: &buttonProfile)
    }


    func addTapped(parameter: inout UIButton) {
        
        parameter.isUserInteractionEnabled = true
        parameter.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.objectTapped)))
    }
    
    @objc func objectTapped(gesture: UIGestureRecognizer) {
        guard let controller = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "ProfileView")
        as? ProfileViewController else { return }
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGame!.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as? GameTableViewCell {
            
            let games = listGame![indexPath.row]
            
            let data = try! Data(contentsOf: ((URL(string: games.gamePhoto)))!)
                
            cell.gameName.text = games.gameName
            cell.gamePhoto.image = UIImage(data: data)
            cell.gameRating.text = String(games.ratingGame)
            cell.gameReleased.text = games.releasedDate
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}

