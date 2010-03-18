#!/usr/bin/perl

if (-e "RWPluginUtilities.framework") {
	# nothing to do since the framework already exists
} else {
	# download and install it
	exec `make -f GetRWPluginSDK.makefile install`;
}
