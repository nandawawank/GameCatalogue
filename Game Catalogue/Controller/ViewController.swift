import UIKit

class ViewController: UIViewController {

    var listGame: [Game] = []
    var filteredGame: [Game] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var gameTableView: UITableView!
    @IBOutlet weak var buttonProfile: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = (self as UISearchResultsUpdating)
        definesPresentationContext = true
        
        gameTableView.tableHeaderView = searchController.searchBar
        gameTableView.dataSource = self
        gameTableView.delegate = self
        gameTableView.register(
            UINib(nibName: "GameTableViewCell", bundle: nil),
            forCellReuseIdentifier: "GameCell"
        )
    
        addTapped(parameter: &buttonProfile)
        
        let service = ApiService()
        service.getListGame { result in
            self.listGame = result
            
            DispatchQueue.main.async {
                self.gameTableView.reloadData()
            }
        }
    }

    private func filterGame(for searchText: String){
        filteredGame = listGame.filter { game in
            return game.gameName.lowercased().contains(searchText.lowercased())
        }
        gameTableView.reloadData()
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
    
    func filterContentForSearchText(_ searchText: String, category: Game? = nil) {
      filteredGame = listGame.filter { (game: Game) -> Bool in
        return game.gameName.lowercased().contains(searchText.lowercased())
      }
      
      self.gameTableView.reloadData()
    }

}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults (for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
}

extension ViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredGame.count
        } else {
            return listGame.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let games: Game
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as? GameTableViewCell {
            
            if searchController.isActive && searchController.searchBar.text != "" {
                games = filteredGame[indexPath.row]
            } else {
                games = listGame[indexPath.row]
            }
            
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detail = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "DetailGame") as? DetailViewController {
            
            detail.games = listGame[indexPath.row]
            navigationController?.pushViewController(detail, animated: true)
        }
    }
}

