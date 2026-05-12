function codex --description 'Launch Codex through Headroom'
    set -l manifest ~/.headroom/deploy/default/manifest.json

    if not test -f $manifest
        headroom-install-service
        or return $status
    end

    if test (count $argv) -gt 0
        command headroom wrap codex --no-context-tool --no-serena -- $argv
    else
        command headroom wrap codex --no-context-tool --no-serena
    end
end
