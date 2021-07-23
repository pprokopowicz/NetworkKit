#!/bin/bash

set -x
set -e

NAME="Networking"

# Build the scheme for all platforms that we plan to support
for PLATFORM in "iOS" "iOS Simulator" "OS X" "tvOS" "tvOS Simulator" "watchOS" "watchOS Simulator"; do

    case $PLATFORM in
    "iOS")
    RELEASE_FOLDER="Release-iphoneos"
    ;;
    "iOS Simulator")
    RELEASE_FOLDER="Release-iphonesimulator"
    ;;
    "OS X")
    RELEASE_FOLDER="Release"
    ;;
    "tvOS")
    RELEASE_FOLDER="Release-appletvos"
    ;;
    "tvOS Simulator")
    RELEASE_FOLDER="Release-appletvsimulator"
    ;;
    "watchOS")
    RELEASE_FOLDER="Release-watchos"
    ;;
    "watchOS Simulator")
    RELEASE_FOLDER="Release-watchsimulator"
    ;;
    esac

    ARCHIVE_PATH=$RELEASE_FOLDER

    xcodebuild archive -workspace . -scheme $NAME \
            -destination "generic/platform=$PLATFORM" \
            -archivePath $ARCHIVE_PATH \
            -derivedDataPath ".build" \
            SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

    FRAMEWORK_PATH="$ARCHIVE_PATH.xcarchive/Products/usr/local/lib/$NAME.framework"
    MODULES_PATH="$FRAMEWORK_PATH/Modules"
    mkdir -p $MODULES_PATH

    BUILD_PRODUCTS_PATH=".build/Build/Intermediates.noindex/ArchiveIntermediates/$NAME/BuildProductsPath"
    RELEASE_PATH="$BUILD_PRODUCTS_PATH/$RELEASE_FOLDER"
    SWIFT_MODULE_PATH="$RELEASE_PATH/$NAME.swiftmodule"
    RESOURCES_BUNDLE_PATH="$RELEASE_PATH/${NAME}_${NAME}.bundle"

    cp -r $SWIFT_MODULE_PATH $MODULES_PATH
done

rm -r framework

xcodebuild -create-xcframework \
-framework Release-iphoneos.xcarchive/Products/usr/local/lib/$NAME.framework \
-framework Release-iphonesimulator.xcarchive/Products/usr/local/lib/$NAME.framework \
-framework Release.xcarchive/Products/usr/local/lib/$NAME.framework \
-framework Release-appletvos.xcarchive/Products/usr/local/lib/$NAME.framework \
-framework Release-appletvsimulator.xcarchive/Products/usr/local/lib/$NAME.framework \
-framework Release-watchos.xcarchive/Products/usr/local/lib/$NAME.framework \
-framework Release-watchsimulator.xcarchive/Products/usr/local/lib/$NAME.framework \
-output "framework/$NAME.xcframework"

rm -r Release-iphoneos.xcarchive
rm -r Release-iphonesimulator.xcarchive
rm -r Release.xcarchive
rm -r Release-appletvos.xcarchive
rm -r Release-appletvsimulator.xcarchive
rm -r Release-watchos.xcarchive
rm -r Release-watchsimulator.xcarchive