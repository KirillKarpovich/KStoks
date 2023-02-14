//
//  SearchResultTableViewCell.swift
//  KStocks
//
//  Created by Kirill Karpovich on 14.02.23.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    static let identifier = String(describing: SearchResultTableViewCell.self)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
