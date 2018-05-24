//
//  ViewController.swift
//  StretchySnacks
//
//  Created by Tyler Boudreau on 2018-05-24.
//  Copyright © 2018 Tyler Boudreau. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    //MARK: PROPERTIES
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var navBarViewHeightConstraint: NSLayoutConstraint!
    
    var animator: UIViewPropertyAnimator!
    var navBarHeight: CGFloat = 66
    var tableViewArray = [String]()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isHidden = true
        return stackView
    }()
    
    let navBarTitle: UILabel = {
        let title = UILabel()
        title.text = "Snacks"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    var foodArray = [#imageLiteral(resourceName: "Pizza"),#imageLiteral(resourceName: "Tart"),#imageLiteral(resourceName: "Ramen"),#imageLiteral(resourceName: "Popsicle"),#imageLiteral(resourceName: "Oreo")]
    var foodNames = ["Pizza","Pop Tart","Ramen","Popsicle","Oreos"]
    //MARK: VIEW
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var index = 0
        
        for image in foodArray{
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imagetapped))
            let imageView = UIImageView.init(image: image)
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFit
            stackView.addArrangedSubview(imageView)
            imageView.tag = index
            imageView.addGestureRecognizer(tapGesture)
            index += 1
        }
        navBarView.addSubview(stackView)
        navBarView.addSubview(navBarTitle)
        // note constraints must be setup AFTER adding subview
        setupStackView()
        setupTitle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:TABLEVIEW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewArray.count
    } // end
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = tableViewArray[indexPath.row]
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as? TableViewCell else {
            let cell = myTableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
            return cell
        }
        cell.myLabel.text = food
        
        return cell
        
    } // end
    
    //MARK: ACTIONS
    
    @IBAction func plusButton(_ sender: Any) {
        print("Button Tapped")
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
            
            if self.navBarHeight == 200{
                self.navBarHeight = 66
                self.plusButton.transform = CGAffineTransform(rotationAngle: CGFloat(0.0))
                self.navBarViewHeightConstraint.constant = self.navBarHeight
                self.stackView.isHidden = true
                
            }else if self.navBarHeight == 66{
                self.navBarHeight = 200
                self.plusButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi/1.25)
                self.navBarViewHeightConstraint.constant = self.navBarHeight
                self.stackView.isHidden = false
            }
            self.view.layoutIfNeeded()
        }, completion: nil)
    } // end
    
    @objc func imagetapped(sender: UITapGestureRecognizer){
        guard let index = sender.view?.tag else {return}
        
        let food = foodNames[index]
        tableViewArray.append(food)
        
        myTableView.reloadData()
    }
    
    
    // MARK: CONSTRAINTS
    
    func setupStackView(){
        
        stackView.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: -10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor, constant: -10).isActive = true
        stackView.heightAnchor.constraint(equalTo: navBarView.heightAnchor, multiplier: 0.5).isActive = true
        
    }// end
    
    
    func setupTitle(){
        navBarTitle.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor).isActive = true
        navBarTitle.centerXAnchor.constraint(equalTo: navBarView.centerXAnchor).isActive = true
    }
}

