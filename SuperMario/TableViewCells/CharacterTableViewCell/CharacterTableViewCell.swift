//
//  CharacterTableViewCell.swift
//  SuperMario
//
//  Created by Nazario Mariano on 4/22/20.
//  Copyright © 2020 Nazario Mariano. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher

class CharacterTableViewCell: UITableViewCell, NibReusable, Cell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seriesLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    var characterPreViewAction: ((RowModel) -> Void)?
    var webSearchAction: ((RowModel) -> Void)?
    
    var rowModel: RowModel! {
        didSet {
            self.nameLabel.text = "Name: " + rowModel.name
            self.seriesLabel.text = "Series: " + rowModel.series
            self.processImage()
        }
    }
    
    @IBAction func characterButtonAction(_ sender: Any) {
        self.characterPreViewAction?(rowModel)
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        self.webSearchAction?(rowModel)
    }
    
    func processImage() {
        
        let url = URL(string: self.rowModel.image)!
        
        characterImageView.loadImage(from: url)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
