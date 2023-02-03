//
//  SearchField.swift
//  Cricketly
//
//  Created by Moh. Absar Rahman on 3/2/23.
//

import UIKit

@IBDesignable
class SearchField: UIView {
    
    @IBOutlet private var view: UIView!
    
    @IBOutlet weak var textfield: UITextField!
    
    @IBInspectable var searchBarBackgroundColor: UIColor = .gray
    @IBInspectable var searchIconColor: UIColor = .gray
    
    @IBOutlet private weak var searchImageView: UIImageView!
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 200, height: 70)
    }
    
    fileprivate func setupNib() {
        let bundle = Bundle(for: SearchField.self)
        bundle.loadNibNamed("SearchField", owner: self)
        addSubview(view)
        view.frame = self.bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchImageView.tintColor = searchIconColor
        view.backgroundColor = searchBarBackgroundColor
        view.layer.cornerRadius = 10
    }
}
