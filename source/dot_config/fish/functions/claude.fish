function claude --description 'Launch Claude through Headroom'
    set -l manifest ~/.headroom/deploy/default/manifest.json

    if not test -f $manifest
        headroom-install-service
        or return $status
    end

    if test (count $argv) -gt 0
        command headroom wrap claude -- $argv
    else
        command headroom wrap claude
    end
end
