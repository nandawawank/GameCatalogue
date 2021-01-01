import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var photoGame: UIImageView!
    @IBOutlet weak var nameGame: UILabel!
    @IBOutlet weak var slugGame: UILabel!
    @IBOutlet weak var ratingGame: UILabel!
    @IBOutlet weak var tableRating: UITableView!
    
    var games: Game?
    var ratings: [Ratings] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableRating.dataSource = self
        tableRating.register(
            UINib(nibName: "RatingTableViewCell", bundle: nil),
            forCellReuseIdentifier: "RatingCell"
        )
        
        let data = try! Data(contentsOf: ((URL(string: games!.gamePhoto)))!)
        
        photoGame.image = UIImage(data: data)
        nameGame.text = games?.gameName
        ratingGame.text = String(games!.ratingGame)
        slugGame.text = games?.slugName
        
        ratings = games!.ratingsGame
        tableRating.reloadData()
        
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ratings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath) as? RatingTableViewCell {
            
            let rating = ratings[indexPath.row]
            
            cell.title.text = rating.title
            cell.precent.text = String(rating.percent)
            cell.count.text = String(rating.count)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}

