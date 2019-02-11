<?php

namespace Deployer;

host('my_ip_address')
    ->port(22)
    ->set('deploy_path', '~/my-docker')
    ->user('root')
    ->set('branch', 'master')
    ->stage('production')
    ->identityFile('~/.ssh/id_rsa');

set('repository', 'git@github.com:ekandreas/my-docker.git');

task('deploy', function () {
    $hostname = Task\Context::get()->getHost()->getHostname();

    $commands = [
        "cd {{deploy_path}} && git reset --hard && git fetch",
        "cd {{deploy_path}} && sed -i 's/local.my-docker.se/{$hostname}/g' docker-compose.yaml",
        "cd {{deploy_path}} && docker-compose restart web",
        "cd {{deploy_path}} && docker-compose restart redis",
    ];

    foreach ($commands as $command) {
        writeln($command);
        run($command);
    }
});
