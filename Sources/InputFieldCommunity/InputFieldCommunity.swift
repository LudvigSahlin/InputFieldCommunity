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

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, neighborhood: InputFieldNeighborhood) -> Bool {
        // If more than one character is added at once it likely means the user is either pasting or using autofill. Either way, go to next textField.
        if string.count > 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.goToNeighborhoodAfter(neighborhood)
            }
        }
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
