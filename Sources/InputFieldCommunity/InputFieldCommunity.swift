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

public class InputFieldCommunity: InputFieldNeighborhoodDelegate {

    let community: [InputFieldNeighborhood]

    public init(_ community: [InputFieldNeighborhood]) {
        self.community = community
        for neighborhood in community {
            neighborhood.delegate = self
        }
    }

    //MARK: - InputFieldNeighborhoodDelegate -
    func textFieldShouldReturn(_ textField: UITextField, neighborhood: InputFieldNeighborhood) -> Bool {
        goToNeighborhoodAfter(neighborhood)
        return true
    }

    private var lastTime = Date()
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, neighborhood: InputFieldNeighborhood) -> Bool {
        // If this function is called twice in a short interval, it is likelly the cause of an autofill.
        // Thus wait for the autofill to complete, then go to the next neighborhood.
        if Date().timeIntervalSince(lastTime) < 0.01 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.goToNeighborhoodAfter(neighborhood)
            }
        }
        lastTime = Date()
        return true
    }

    //MARK: - Public functions -
    func validate() -> Bool {
        return community.map { $0.validate() }.allSatisfy { $0 }
    }

    //MARK: - Private functions -
    private func goToNeighborhoodAfter(_ neighborhood: InputFieldNeighborhood) {
        guard let nextNeighborhood = getNeighborhoodAfter(neighborhood) else {
            neighborhood.textField?.resignFirstResponder()
            neighborhood.textView?.resignFirstResponder()
            return
        }
        nextNeighborhood.inputField.becomeFirstResponder()
    }
    private func getNeighborhoodAfter(_ neighborhood: InputFieldNeighborhood) -> InputFieldNeighborhood? {
        let nextIndex = community.firstIndex(of: neighborhood)!.advanced(by: 1)
        if nextIndex == community.endIndex { return nil }
        return community[nextIndex]
    }
}
