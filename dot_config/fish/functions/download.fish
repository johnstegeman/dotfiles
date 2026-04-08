function download
  if test (count $argv) -eq 0
    echo "Error: download requires a version number" >&2
    return 1
  end

  if not using curl
    echo "Error: curl is not installed" >&2
    return 1
  end

  set -f tar_ball neo4j-enterprise-$argv[1]-unix.tar.gz
  if test ! -e ./$tar_ball
    curl -O -C - "http://dist.neo4j.org/$tar_ball"
  else
    echo "File $tar_ball already exists"
  end
end
