import UIKit

class DetailVC: UIViewController {
    @IBOutlet weak var ColorHash: UILabel!
    
    var color : UIColor?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color ?? .systemBackground
        navigationController?.navigationBar.tintColor = view.backgroundColor?.contrastColor()
        ColorHash.text = view.backgroundColor?.toHex() ?? "#7F7F7F"
        ColorHash.textColor = color?.contrastColor()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(copyLabelText))
        ColorHash.isUserInteractionEnabled = true
        ColorHash.addGestureRecognizer(tapGesture)
    }
    
    @objc func copyLabelText() {
        guard let text = ColorHash.text else { return }
        UIPasteboard.general.string = text
        
        let alert = UIAlertController(title: "Copied!", message: "Color hash copied to clipboard.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
