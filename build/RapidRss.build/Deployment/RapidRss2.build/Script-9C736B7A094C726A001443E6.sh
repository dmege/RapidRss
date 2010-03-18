#!/bin/sh
# set

echo "Removing the old plugin from the Application Support folder."
rm -Rf ~/Library/Application\ Support/RapidWeaver/${PRODUCT_NAME}.rwplugin
if [ -d ~/Library/Application\ Support/RapidWeaver/${PRODUCT_NAME}.rwplugin ]; then
    echo "Error: remove failed."
    exit 1
fi

echo "Copying the plugin to the Application Support folder."
if [ -d "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.rwplugin" ]; then
  cp -R "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.rwplugin" ~/Library/Application\ Support/RapidWeaver
  echo "installed to Applicaton support"
fi

exit 0; 
