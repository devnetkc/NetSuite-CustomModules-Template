#!/bin/bash

# This script modifies certain features in a NetSuite manifest file that are marked as "required" but are not essential for most deployments.
# Please review and adjust these changes as necessary to fit your specific deployment needs.

# Replace "required" with "not required" for the MULTIBOOK feature in the manifest file.
sed 's/required="true">MULTIBOOK/required="false">MULTIBOOK/' ./src/manifest.xml >./src/manifest2.xml

# Replace "required" with "not required" for the SUBSCRIPTIONBILLING feature in the manifest file.
sed 's/required="true">SUBSCRIPTIONBILLING/required="false">SUBSCRIPTIONBILLING/' ./src/manifest2.xml >./src/manifest3.xml

# Replace "required" with "not required" for the BILLINGACCOUNTS feature in the manifest file.
sed 's/required="true">BILLINGACCOUNTS/required="false">BILLINGACCOUNTS/' ./src/manifest3.xml >./src/manifest.xml

# Clean up intermediate files created during the process to better support all Unix systems, including macOS.
rm -f ./src/manifest2.xml
rm -f ./src/manifest3.xml
