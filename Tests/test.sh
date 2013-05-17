#!/usr/bin/env bash

# This script builds and runs the unit tests and produces output in a format that is compatible with Jenkins.

base=`dirname $0`
pushd "$base/.." > /dev/null
build="$PWD/test-build"
ocunit2junit="$base/OCUnit2JUnit/bin/ocunit2junit"
popd > /dev/null

sym="$build/sym"
obj="$build/obj"

testout="$build/output.log"
testerr="$build/error.log"

rm -rf "$build"
mkdir -p "$build"

testMac()
{
	arch=$1
	
	echo "Testing Mac $1"
	xcodebuild -workspace "KSFTPDirectoryParser.xcworkspace" -scheme "KSFTPDirectoryParser Mac" -sdk "macosx" -config "Debug" -arch "$arch" test OBJROOT="$obj" SYMROOT="$sym" > "$testout" 2> "$testerr"
	if [ $? != 0 ]; then
		echo "Mac build failed"
		cat "$testerr"
	else
		cd "$build"
        rm -rf test-reports
		"../$ocunit2junit" < "$testout"
        mv test-reports mac-reports-$1
		cd ..
	fi
}

testIOS()
{
	# have to build the project/target, not the workspace/scheme, since xcodebuild doesn't support
	# running unit tests on the ios simulator via workspace/scheme, for some bizarre reason
	echo "Testing iOS"
	xcodebuild -project "KSFTPDirectoryParser.xcodeproj" -target "UnitTests iOS" -sdk "iphonesimulator" -arch i386 -config "Debug" build OBJROOT="$obj" SYMROOT="$sym" TEST_AFTER_BUILD=YES > "$testout" 2> "$testerr"
	if [ $? != 0 ]; then
		echo "iOS build failed"
		cat "$testerr"
	else
		cd "$build"
        rm -rf test-reports
		"../$ocunit2junit" < "$testout"
        mv test-reports ios-reports
		cd ..
	fi
}


testMac i386
testMac x86_64
testIOS

cd "$build"
mkdir test-reports
mv mac-reports-i386 test-reports/
mv mac-reports-x86_64 test-reports/
mv ios-reports test-reports/


