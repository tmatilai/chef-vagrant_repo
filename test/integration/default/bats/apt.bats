#!/usr/bin/env bats

# Ensure we don't use proxy for local connections
if [ -n "$no_proxy" ]; then
    export no_proxy="$no_proxy,$(hostname -f)"
else
    export no_proxy="$(hostname -f)"
fi

# Configure the local repository and pinning rules
configure_apt() {
    cat > /etc/apt/preferences.d/vagrant <<-APT_PREF
	Package: vagrant
	Pin: origin "$(hostname -f)"
	Pin-Priority: 678
	APT_PREF

    echo "deb http://$(hostname -f)/ stable main" > /etc/apt/sources.list.d/vagrant.list
}

configure_apt

@test "installs front page" {
    run wget -q -O - "http://$(hostname -f)/"
    [ "$status" -eq 0 ]
    [[ "$output" == *"Apt Repository"* ]]
}

@test "generates valid repository" {
    run apt-get update
    run apt-cache policy vagrant
    [ "$status" -eq 0 ]
    [[ "$output" == *"500 http://$(hostname -f)/ stable/main $(dpkg --print-architecture) Packages"* ]]
}

@test "vagrant is installable" {
    run apt-get -y --allow-unauthenticated install vagrant
    [ "$status" -eq 0 ]
    run vagrant --version
    [ "$status" -eq 0 ]
    [[ "$output" == "Vagrant "* ]]
}
