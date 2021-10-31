//
//  EmptyTableViewCell.swift
//  GameFi
//
//  Created by harden on 2021/10/29.
//

import Foundation
import UIKit

let emptyTableViewCellIdentifier:String = "EmptyTableViewCell"
class EmptyTableViewCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
}
