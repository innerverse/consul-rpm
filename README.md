# RPM Spec for Consul

### This is a fork from the original with all pull requests applied and warnings fixed.

Tries to follow the [packaging guidelines](https://fedoraproject.org/wiki/Packaging:Guidelines) from Fedora.

* Binary: `/usr/bin/consul`
* Config: `/etc/consul.d/`
* Sysconfig: `/etc/sysconfig/consul`

# Build (automated)

* Ensure that `rpmdevtools` and `mock` are available:
    ```
    sudo yum install rpmdevtools mock
    ```

* Run `autobuild.sh`:
    ```
    cd ${repo}/
    chmod u+x autobuild.sh
    ./autobuild.sh
    ```

# Build (manual)

To build the RPM (non-root user):

* Check out this repo
* Install rpmdevtools and mock 
    ```
    sudo yum install rpmdevtools mock
    ```

* Set up your rpmbuild directory tree
    ```
    rpmdev-setuptree
    ```

* Link the spec file and sources from the repository into your rpmbuild/SOURCES directory
    ```
    ln -s ${repo}/SPECS/consul.spec rpmbuild/SPECS/
    ln -s ${repo}/SOURCES/* rpmbuild/SOURCES/
    ```

* Download remote source files
    ```
    spectool -g -R rpmbuild/SPECS/consul.spec
    ```

* Build the RPM
    ```
    rpmbuild -ba rpmbuild/SPECS/consul.spec
    ```

* (Optional) Build for another Fedora release
    ```
    sudo mock -r fedora-19-x86_64 --resultdir rpmbuild/RPMS/x86_64/ rpmbuild/SRPMS/consul-0.2.0-1.fc20.src.rpm 
    ```

# Run

* Install the RPM.
* Put config files in `/etc/consul.d/`.
* Change command line arguments to consul in `/etc/sysconfig/consul`.
  * Add `-bootstrap` **only** if this is the first server and instance.
* Start the service and tail the logs `systemctl start consul.service` and `journalctl -f`.
  * To enable at reboot `systemctl enable consul.service`.

# More info

See the [consul.io](http://www.consul.io) website.
