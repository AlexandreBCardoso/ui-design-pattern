//
//  PersonFollowingTableViewCell.swift
//  ExemploMVVM
//
//  Created by Alexandre Cardoso on 20/04/21.
//

import UIKit

protocol PersonFollowingTableViewCellDelegate: AnyObject {
	func personFollowingTableViewCell(_ cell: PersonFollowingTableViewCell,
												 didTapWith viewModel: PersonFollowingTableViewCellViewModel)
}

class PersonFollowingTableViewCell: UITableViewCell {
	
	static let identifier: String = "PersonFollowingTableViewCell"
	
	weak var delegate: PersonFollowingTableViewCellDelegate?
	
	private var viewModel: PersonFollowingTableViewCellViewModel?
	
	private let userImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.clipsToBounds = true
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.textColor = .label
		return label
	}()
	
	private let userNameLabel: UILabel = {
		let label = UILabel()
		label.textColor = .secondaryLabel
		return label
	}()
	
	private let button: UIButton = {
		let button = UIButton()
		return button
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		contentView.addSubview(userNameLabel)
		contentView.addSubview(nameLabel)
		contentView.addSubview(userImageView)
		contentView.addSubview(button)
		contentView.clipsToBounds = true
		button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		let imageWidth = contentView.frame.size.height - 10
		userImageView.frame = CGRect(x: 5, y: 5,
											  width: imageWidth,
											  height: imageWidth)
		
		nameLabel.frame = CGRect(x: imageWidth + 10, y: 0,
										 width: contentView.frame.size.width - imageWidth,
										 height: contentView.frame.size.height / 2)
		
		userNameLabel.frame = CGRect(x: imageWidth + 10, y: contentView.frame.size.height / 2,
											  width: contentView.frame.size.width - imageWidth,
											  height: contentView.frame.size.height / 2)
		
		button.frame = CGRect(x: contentView.frame.size.width - 120, y: 10,
									 width: 110,
									 height: contentView.frame.size.height - 20)
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		nameLabel.text = nil
		userNameLabel.text = nil
		userImageView.image = nil
		button.backgroundColor = nil
		button.layer.borderWidth = 0
		button.setTitle(nil, for: .normal)
	}
	
	func configure(with viewModel: PersonFollowingTableViewCellViewModel) {
		self.viewModel = viewModel
		self.nameLabel.text = viewModel.name
		self.userNameLabel.text = viewModel.username
		self.userImageView.image = viewModel.image
		
		if viewModel.currentlyFollowing {
			button.setTitle("Unfollow", for: .normal)
			button.setTitleColor(.black, for: .normal)
			button.layer.borderWidth = 1
			button.layer.borderColor = UIColor.black.cgColor
		} else {
			button.setTitle("Follow", for: .normal)
			button.setTitleColor(.white, for: .normal)
			button.backgroundColor = .link
		}
	}
	
	@objc
	func didTapButton() {
		if let viewModel = viewModel {
			var newViewModel = viewModel
			newViewModel.currentlyFollowing = !viewModel.currentlyFollowing
			self.delegate?.personFollowingTableViewCell(self, didTapWith: newViewModel)
			
			prepareForReuse()
			configure(with: newViewModel)
		}
	}
		
}
