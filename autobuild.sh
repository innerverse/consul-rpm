#!/usr/bin/env bash
# This script automatically builds copies over the systemd unit files, spec files and builds the rpm.

RPM_BUILD_DIR="$HOME/rpmbuild"

if [ ! -d "RPM_BUILD_DIR" ]; then
    echo "$HOME/rpmbuild doesn't exist, creating"
    mkdir -p $HOME/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
    cp ./SPECS/consul.spec $HOME/rpmbuild/SPECS/
    cp ./SOURCES/consul.* $HOME/rpmbuild/SOURCES/
fi

spectool -g -R $HOME/rpmbuild/SPECS/consul.spec
rpmbuild -ba $HOME/rpmbuild/SPECS/consul.spec
