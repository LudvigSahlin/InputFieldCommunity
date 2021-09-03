// Copyright 2021 Ludvig Sahlin
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation
import UIKit


protocol InputFieldCommunityDelegate: AnyObject {}

protocol InputFieldNeighborhoodDelegate: AnyObject {
    func textFieldShouldReturn(_ textField: UITextField, neighborhood: InputFieldNeighborhood) -> Bool
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, neighborhood: InputFieldNeighborhood) -> Bool
}


