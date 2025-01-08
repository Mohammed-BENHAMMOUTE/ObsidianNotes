1. creation d'un image switcher on utilisant StoryBoard :
Ce code affiche une image et permet de parcourir une liste d'images en appuyant sur un bouton. À chaque clic, l'image change avec une transition fluide.
```swift


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    // Array to store our image names
    let images = ["image1", "image2", "image3"] // Replace with your image names
    var currentImageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set initial image
        imageView.image = UIImage(named: images[currentImageIndex])
    }
    
    @IBAction func changeImageButtonTapped(_ sender: UIButton) {
        // Increment index and loop back to 0 if we reach the end
        currentImageIndex = (currentImageIndex + 1) % images.count
        
        // Update image with animation
        UIView.transition(with: imageView,
                         duration: 0.3,
                         options: .transitionCrossDissolve,
                         animations: {
            self.imageView.image = UIImage(named: self.images[self.currentImageIndex])
        }, completion: nil)
    }
}
```
[[]]![[3pic.png]]![[2pic.png]]![[1pic.png]]




2. Affichage d'alerte:
Ce code crée un bouton au centre de l'écran. Lorsqu'on clique dessus, une alerte s'affiche pour choisir une couleur : rouge, vert ou annuler. Si l'utilisateur choisit rouge ou vert, la couleur de fond de l'écran change en conséquence.

![[22pic.png]]![[23picc.png]]![[22picc.png]]

**3. Scale factor:**
![[source.png]]
for the second scale we can have this :
![[jdck.png]]![[sd.kv.png]]![[spceguild.png]]![[jdck 1.png]]
