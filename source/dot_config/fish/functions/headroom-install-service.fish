function headroom-install-service --description 'Install the default Headroom persistent service'
    if not using headroom
        echo "Error: headroom is not installed" >&2
        return 1
    end

    set -l manifest ~/.headroom/deploy/default/manifest.json

    if test -f $manifest
        echo "Headroom persistent service is already installed."
        return 0
    end

    command headroom install apply \
        --preset persistent-service \
        --profile default \
        --port 8787 \
        --scope provider \
        --providers manual \
        --memory
end
