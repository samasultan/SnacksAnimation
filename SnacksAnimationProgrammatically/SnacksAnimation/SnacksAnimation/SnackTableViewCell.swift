//
//  SnackTableViewCell.swift
//  SnacksAnimation
//
//  Created by Macbook Pro on 2021-01-14.
//

import UIKit

class SnackTableViewCell: UITableViewCell {
  
  static let identifier = "cellId"
  var snackLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(snackLabel)
    snackLabel.font = UIFont.systemFont(ofSize: 25)
    snackLabel.translatesAutoresizingMaskIntoConstraints = false
    snackLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
    snackLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    snackLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
    snackLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
