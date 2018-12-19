#!/bin/sh
pushd ../../

onlyReleaseConfiguration=
buildLipoLib=
while getopts rl opts_var
	do
	case $opts_var in
		r)
		onlyReleaseConfiguration=1
		;;
		l)
		buildLipoLib=1
		;;
	esac
done

function buildLibs(){
   local projectName=$1
   local target=$2
   xcodebuild -project $projectName/$projectName.xcodeproj -target $target onlyReleaseConfiguration=$onlyReleaseConfiguration buildLipoLib=$buildLipoLib;rm -rf $projectName/build;
}


buildLibs lwbasic			FrameworkMaker_Release
buildLibs lwui			    FrameworkMaker_Release
buildLibs lwapi             FrameworkMaker_Release
buildLibs lwlab             lwlabBundle

mkdir ios_libs/ThirdFrameworks

popd
