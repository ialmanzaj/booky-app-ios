//
//  BookCollectionViewCell.swift
//  Wissen
//
//  Created by Isaac Almanza on 04/25/18.
//  Copyright © 2018 Isaac Almanza. All rights reserved.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var bookName: UILabel!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupCell()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupCell()
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	//MARK:- Setup Cell
	func setupCell() {
		roundCorner()
		gradientBackgroundColor()
		//setCellShadow()
	
	
	}
	
	//MARK:- Methods
	func cellRandomBackgroundColors() -> [UIColor] {
		//Colors
		
		let orangeRed = [#colorLiteral(red: 0.9338900447, green: 0.4315618277, blue: 0.2564975619, alpha: 1),#colorLiteral(red: 0.8518816233, green: 0.1738803983, blue: 0.01849062555, alpha: 1)]
		let orange = [#colorLiteral(red: 0.9953531623, green: 0.54947716, blue: 0.1281470656, alpha: 1),#colorLiteral(red: 0.9409626126, green: 0.7209432721, blue: 0.1315650344, alpha: 1)]
		let green = [#colorLiteral(red: 0.3796315193, green: 0.7958304286, blue: 0.2592983842, alpha: 1),#colorLiteral(red: 0.2060100436, green: 0.6006633639, blue: 0.09944178909, alpha: 1)]
		let greenBlue = [#colorLiteral(red: 0.2761503458, green: 0.824685812, blue: 0.7065336704, alpha: 1),#colorLiteral(red: 0, green: 0.6422213912, blue: 0.568986237, alpha: 1)]
		let skyBlue = [#colorLiteral(red: 0.3045541644, green: 0.6749247313, blue: 0.9517192245, alpha: 1),#colorLiteral(red: 0.008423916064, green: 0.4699558616, blue: 0.882807076, alpha: 1)]
		let blue = [#colorLiteral(red: 0.1774400771, green: 0.466574192, blue: 0.8732826114, alpha: 1),#colorLiteral(red: 0.00491155684, green: 0.287129879, blue: 0.7411141396, alpha: 1)]
		let bluePurple = [#colorLiteral(red: 0.4613699913, green: 0.3118675947, blue: 0.8906354308, alpha: 1),#colorLiteral(red: 0.3018293083, green: 0.1458326578, blue: 0.7334778905, alpha: 1)]
		
		let colorsTable: [Int: [UIColor]] = [0: orangeRed, 1: orange, 2: green, 3: greenBlue, 4: skyBlue, 5: blue, 6: bluePurple, ]
		
		let randomColors = colorsTable.values.randomElement()
		return randomColors!
	}
	
	func gradientBackgroundColor() {
		let colors = cellRandomBackgroundColors()
		self.contentView.setGradientBackgroundColor(colorOne: colors[0], colorTow: colors[1])
	}
	
	func roundCorner() {
		self.contentView.layer.cornerRadius = 12.0
		self.contentView.layer.masksToBounds = true
		self.contentView.layer.borderWidth = 1.0
		self.contentView.layer.borderColor = UIColor.clear.cgColor
	}


}

extension UIView {
	func setGradientBackgroundColor(colorOne: UIColor, colorTow: UIColor) {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = bounds
		gradientLayer.colors = [colorOne.cgColor, colorTow.cgColor]
		gradientLayer.locations = [0.0, 1.0]
		gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
		gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
		
		layer.insertSublayer(gradientLayer, at: 0)
	}
}
