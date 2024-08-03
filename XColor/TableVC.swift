import UIKit

class TableVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        fillColors()
        // Do any additional setup after loading the view.
    }

    var Colors: [UIColor] = []
    func fillColors() {
        for _ in 0..<50 {
             Colors.append(UIColor.random())
         }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! DetailVC
        destVC.color = sender as? UIColor
    }
}

extension TableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Colors.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let Cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell") else {
            return UITableViewCell()
        }
        Cell.backgroundColor = Colors[indexPath.row]
        return Cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let color = Colors[indexPath.row]
        performSegue(withIdentifier: "table_to_detail", sender: color)
    }
}
