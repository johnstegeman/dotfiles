mssh() {
ssh  `multipass info $1 --format json | jq -r  ".info.fabric.ipv4[0]"`
 }

mcreate() {
    multipass launch -c 8 -m 16G -d 15G -n $1 --cloud-init ~/config/neo_init.yaml --mount ~/mounts:/mnt/software
}
