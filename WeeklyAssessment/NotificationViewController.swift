//
//  NotificationViewController.swift
//  WeeklyAssessment
//
//  Created by Mddaniyal on 3/22/25.
//

import UIKit

class NotificationViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NotificationCollectionViewCellDelegate, EditCellViewControllerDelegate {

    
    
    @IBOutlet weak var myColleetionView: UICollectionView!

    var dataSource: [User] = [
        User(name: "John Doe",
             email: "john@example.com",
             address: "New York, USA",
             description: "A highly skilled software engineer with expertise in building scalable applications and optimizing system performance.",
             imageName: "img"),
        
        User(name: "Emma Smith",
             email: "emma@example.com",
             address: "London, UK",
             description: "A passionate data scientist who specializes in machine learning and AI-driven analytics, helping businesses make data-driven decisions.",
             imageName: "img2"),
        
        User(name: "Mike Johnson",
             email: "mike@example.com",
             address: "Berlin, Germany",
             description: "An experienced product manager known for leading cross-functional teams to deliver innovative tech solutions in agile environments.",
             imageName: "img"),
        
        User(name: "Sara Lee",
             email: "sara@example.com",
             address: "Paris, France",
             description: "A creative UI/UX designer with a strong background in crafting user-friendly interfaces and enhancing user experiences for web and mobile applications.",
             imageName: "img3"),
        
        User(name: "Liam Brown",
             email: "liam@example.com",
             address: "Toronto, Canada",
             description: "A dedicated DevOps engineer with expertise in CI/CD pipelines, cloud infrastructure, and automating deployment processes.",
             imageName: "img4"),
        
        User(name: "Olivia Wilson",
             email: "olivia@example.com",
             address: "Sydney, Australia",
             description: "A backend developer skilled in building robust and secure APIs, database management, and server-side application development.",
             imageName: "img5"),
        
        User(name: "Olivia Wilson",
             email: "olivia@example.com",
             address: "Sydney, Australia",
             description: "A backend developer skilled in building robust and secure APIs, database management, and server-side application development.",
             imageName: "img6"),
        
        User(name: "Olivia Wilson",
             email: "olivia@example.com",
             address: "Sydney, Australia",
             description: "A backend developer skilled in building robust and secure APIs, database management, and server-side application development.",
             imageName: "img7"),
        
        User(name: "Olivia Wilson",
             email: "olivia@example.com",
             address: "Sydney, Australia",
             description: "A backend developer skilled in building robust and secure APIs, database management, and server-side application development.",
             imageName: "img8")
    ]

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        myColleetionView.dataSource = self
        myColleetionView.delegate = self
        let nib = UINib(nibName: "NotificationCollectionViewCell", bundle: nil)
        myColleetionView.register(nib, forCellWithReuseIdentifier: "NotificationCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        let cellWidth = (view.frame.width / 2) - 10
        layout.itemSize = CGSize(width: cellWidth, height: 300)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
        myColleetionView.collectionViewLayout = layout
     }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let user = dataSource[indexPath.row]
        
        let cell = myColleetionView.dequeueReusableCell(withReuseIdentifier: "NotificationCollectionViewCell", for: indexPath) as? NotificationCollectionViewCell
        
        cell?.name.text = user.name
        cell?.email.text = user.email
        cell?.address.text = user.address
        cell?.descp.text = user.description
        cell?.img.image = UIImage(named: user.imageName)
        cell?.descp.numberOfLines = 0
        cell?.descp.lineBreakMode = .byWordWrapping
        cell?.delegate = self
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let spacing: CGFloat = 10
        let totalSpacing = spacing * (2 - 1)

        let cellWidth = (collectionView.frame.width - totalSpacing) / 2
        return CGSize(width: cellWidth, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func didTapOpenImage(with image: UIImage?) {
       
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        imageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissImageView(_:)))
        imageView.addGestureRecognizer(tap)
        
        self.view.addSubview(imageView)
    }
    
    @objc func dismissImageView(_ sender: UITapGestureRecognizer) {
        
        sender.view?.removeFromSuperview()
    }
    
    // Edit the cell
    func didTapEditCell(_ cell: NotificationCollectionViewCell) {
        guard let indexPath = myColleetionView.indexPath(for: cell) else { return }
        
        let user = dataSource[indexPath.row]
        if let storyboard = storyboard?.instantiateViewController(withIdentifier: "EditCellViewController") as? EditCellViewController {
            
            storyboard.image = user.imageName
            storyboard.name = user.name
            storyboard.email = user.email
            storyboard.address = user.address
            storyboard.descripon = user.description
            
            storyboard.userIndex = indexPath.row
            storyboard.delegate = self
            
            storyboard.modalPresentationStyle = .fullScreen

            self.present(storyboard, animated: true)
        }
    }
    
    func UpdateUser(_ updatedUser: User, at index: Int) {
        
        dataSource[index] = updatedUser
        myColleetionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }
}

