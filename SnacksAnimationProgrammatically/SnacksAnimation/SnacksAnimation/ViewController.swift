//
//  ViewController.swift
//  SnacksAnimation
//
//  Created by Macbook Pro on 2021-05-20.
//

import UIKit

class ViewController: UIViewController {

  var navBarViewHeightConstraint: NSLayoutConstraint!
  var navBarView = UIView()
  var tableView = UITableView()
  var snacks = ["burger", "fries", "chicken", "egg", "steak"]
  var selectedSnacks = [String]()
  var isNavbarOpen = false
  
  let snacksLabel: UILabel = {
    let lbl = UILabel()
    lbl.text = "Snacks"
    lbl.textAlignment = .center
    lbl.font = .boldSystemFont(ofSize: 25)
    return lbl
  }()
  
  let addSnacksLabel: UILabel = {
    let lbl = UILabel()
    lbl.text = "Add Snacks"
    lbl.textAlignment = .center
    lbl.font = .boldSystemFont(ofSize: 25)
    lbl.isHidden = true
    return lbl
  }()
  
  let hSnackBarStackView: UIStackView = {
    let sv = UIStackView()
    sv.axis = .horizontal
    sv.alignment = .center
    sv.distribution = .fillEqually
    sv.spacing = 20
    sv.isHidden = true
    return sv
  }()
  
  let vNavbarStackView: UIStackView = {
    let sv = UIStackView()
    sv.axis = .vertical
    sv.alignment = .fill
    sv.distribution = .fill
    sv.spacing = 5
    sv.translatesAutoresizingMaskIntoConstraints = false
    return sv
  }()
  
  let addButton: UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    button.setTitle("＋", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
    button.addTarget(self, action: #selector(openSnacks(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  fileprivate func setupNavbar() {
    navBarViewHeightConstraint = NSLayoutConstraint(
      item: navBarView,
      attribute: .height,
      relatedBy: .equal,
      toItem: nil,
      attribute: .notAnAttribute,
      multiplier: 1,
      constant: 88)
    navBarView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    
    view.addSubview(navBarView)
    navBarView.addConstraint(navBarViewHeightConstraint)
    navBarView.translatesAutoresizingMaskIntoConstraints = false
    navBarView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1).isActive = true
    navBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    
    for (i, snack) in snacks.enumerated() {
      let btn = UIButton()
      btn.setImage(UIImage(named: snack), for: .normal)
      btn.imageView?.contentMode = .scaleAspectFit
      btn.addTarget(self, action: #selector(snackSelected(_:)), for: .touchUpInside)
      btn.tag = i
      hSnackBarStackView.addArrangedSubview(btn)
    }
    
    vNavbarStackView.addArrangedSubview(snacksLabel)
    vNavbarStackView.addArrangedSubview(addSnacksLabel)
    vNavbarStackView.addArrangedSubview(hSnackBarStackView)
    
    navBarView.addSubview(vNavbarStackView)
    vNavbarStackView.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: -10).isActive = true
    vNavbarStackView.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor, constant: 10).isActive = true
    vNavbarStackView.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor, constant: -10).isActive = true
    
    view.addSubview(addButton)
    addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive = true
    
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.separatorInset = UIEdgeInsets.zero
    tableView.topAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: 0).isActive = true
    tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupNavbar()
    tableView.register(SnackTableViewCell.self, forCellReuseIdentifier: SnackTableViewCell.identifier)
    tableView.delegate = self
    tableView.dataSource = self
  }

  @objc func snackSelected(_ sender: UIButton) {
    UIView.animate(withDuration: 0.15) {
      sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
    } completion: { (_) in
      UIView.animate(withDuration: 0.15) {
        sender.transform = .identity
      }
    }
    
    let snack = snacks[sender.tag]
    selectedSnacks.insert(snack, at: 0)
    tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
  }
  
  @objc func openSnacks(_ sender: UIButton) {
    if isNavbarOpen {
      UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 2, options: .curveEaseInOut) {
        self.addButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        self.navBarViewHeightConstraint.constant = 88
        self.hSnackBarStackView.isHidden.toggle()
        self.addSnacksLabel.isHidden.toggle()
        self.view.layoutIfNeeded()
      }
    } else {
      UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 2, options: .curveEaseInOut) {
        self.addButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        self.navBarViewHeightConstraint.constant = 200
        self.hSnackBarStackView.isHidden.toggle()
        self.addSnacksLabel.isHidden.toggle()
        self.view.layoutIfNeeded()
      }
    }
    
    isNavbarOpen.toggle()
    snacksLabel.isHidden.toggle()
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return selectedSnacks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SnackTableViewCell.identifier, for: indexPath) as! SnackTableViewCell
    cell.snackLabel.text = selectedSnacks[indexPath.row]
    return cell
  }
  
  
}
