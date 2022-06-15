//
//  Extensions.swift
//  Netflix Clone
//
//  Created by HAMZA on 14/6/2022.
//

import Foundation


extension String {
    func capitalizeFirstLettre() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
