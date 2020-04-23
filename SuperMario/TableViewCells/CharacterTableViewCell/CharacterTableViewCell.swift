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

/// This is the table view cell used to display the thumbnail, name of game and series
class CharacterTableViewCell: UITableViewCell, NibReusable, Cell {
    
    /// Displays the character name
    @IBOutlet weak var nameLabel: UILabel!
    
    /// Displays the series name
    @IBOutlet weak var seriesLabel: UILabel!
    
    /// Displays the series image
    @IBOutlet weak var characterImageView: UIImageView!
    
    /// The block that references the action when the thumbnail is pressed
    var characterPreViewAction: ((RowModel) -> Void)?
    
    /// The block that references the action when the information section is pressed
    var webSearchAction: ((RowModel) -> Void)?
    
    /// The currently assigned view model
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
    
    fileprivate func processImage() {
        
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
