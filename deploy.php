<?php
namespace Deployer;

host('my_linode_ip_address')
    ->port(22)
    ->set('deploy_path', '~/my-docker')
    ->user('root')
    ->set('branch', 'master')
    ->stage('production')
    ->identityFile('~/.ssh/id_rsa');

set('repository', 'git@github.com:ekandreas/my-docker.git');

task('deploy', function() {
    run("cd {{deploy_path}} && git fetch");
    run("cd {{deploy_path}} && docker-compose restart");
});
