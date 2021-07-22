//
//  Protocols.swift
//  
//
//  Created by Ludvig Hemma on 2021-07-21.
//

import Foundation
import UIKit


protocol InputFieldCommunityDelegate: AnyObject {}

protocol InputFieldNeighborhoodDelegate: AnyObject {
    func textFieldShouldReturn(_ textField: UITextField, neighborhood: InputFieldNeighborhood) -> Bool
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, neighborhood: InputFieldNeighborhood) -> Bool
}


