#!/usr/bin/env bats

@test "installs front page" {
    run wget -q -O - "http://$(hostname -f)/"
    [ "$status" -eq 0 ]
    [[ "$output" == *"Apt Repository"* ]]
}

@test "generates valid repository" {
    echo "deb http://$(hostname -f)/ stable main" > /etc/apt/sources.list.d/vagrant.list
    apt-get update
    run apt-cache policy vagrant
    [ "$status" -eq 0 ]
    [[ "$output" == *"500 http://$(hostname -f)/ stable/main $(dpkg --print-architecture) Packages"* ]]
}
