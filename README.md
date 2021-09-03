# InputFieldCommunity

This package is used to handle common logic for views with multiple input fields:
- When the return key is tapped, next input field (if any) will become first responder.
- When autofill is detected, the next input field (if any) will become first responder.
- Handles visibility of custom clear button.

 Important:
 - The custom autofill detection is not fully reliable and might break with future releases.
 - UITextView is not handled.
 - All input fields will have their delegate set to their InputFieldNeighborhood. Thus, if you try to set the delegate of a text field in a InputFieldNeighborhood, it will either get overridden or you will break the functionality of the InputFieldNeighborhood.


# Usage:
You only specify the relationship between the different UI components:
    private var community: InputFieldCommunity!

    community = InputFieldCommunity([
        InputFieldNeighborhood(containerView: givenNameContainerView, backgroundView: givenNameBackgroundView, inputField: givenNameTextField, headerLabel: givenNameHeaderLabel, xImageView: givenNameXImageView, xBackgroundView: givenNameXBackgroundView),
        InputFieldNeighborhood(containerView: familyNameContainerView, backgroundView: familyNameBackgroundView, inputField: familyNameTextField, headerLabel: familyNameHeaderLabel, xImageView: familyNameXImageView, xBackgroundView: familyNameXBackgroundView),
        InputFieldNeighborhood(containerView: plateNumberContainerView, backgroundView: plateNumberBackgroundView, inputField: plateNumberTextField, headerLabel: plateNumberHeaderLabel, xImageView: plateNumberXImageView, xBackgroundView: plateNumberXBackgroundView),
    ])


# License

The contents of this repository is licensed under the
[Apache License, version 2.0](http://www.apache.org/licenses/LICENSE-2.0).



# Contact

ludvigsahlin2@gmail.com
