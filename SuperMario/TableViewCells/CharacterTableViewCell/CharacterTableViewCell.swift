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
    
    var rowModel: RowModel! {
        didSet {
            self.seriesLabel.text = rowModel.series
            self.nameLabel.text = rowModel.name
            self.processImage()
        }
    }
    
    @IBAction func characterButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        
    }
    
    func processImage() {
        let url = URL(string: self.rowModel.image)
        
        let processor = DownsamplingImageProcessor(size: characterImageView.bounds.size)
                    
        characterImageView.kf.indicatorType = .activity
        characterImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "mario"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
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
