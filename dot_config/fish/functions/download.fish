function download
    set -f tar_ball neo4j-enterprise-$argv[1]-unix.tar.gz
    if test ! -e ./$tar_ball
        curl -O -C - "http://dist.neo4j.org/$tar_ball"
    end
end
