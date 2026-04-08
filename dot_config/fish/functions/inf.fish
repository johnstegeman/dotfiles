function inf --description 'ssh helper for infinigraph cluster'
  if not using gcloud
    echo "Error: gcloud is not installed" >&2
    return 1
  end

  switch $argv[1]
    case gs
       gcloud compute ssh --zone "us-central1-f" "inf-graph" --project "infinigraph-blockchain"
    case p1
       gcloud compute ssh --zone "us-central1-f" "inf-prop1" --project "infinigraph-blockchain"
    case p2
       gcloud compute ssh --zone "us-central1-f" "inf-prop2" --project "infinigraph-blockchain"
    case p3
       gcloud compute ssh --zone "us-central1-f" "inf-prop3" --project "infinigraph-blockchain"
    case p4
       gcloud compute ssh --zone "us-central1-f" "inf-prop4" --project "infinigraph-blockchain"
    case p5
       gcloud compute ssh --zone "us-central1-f" "inf-prop5" --project "infinigraph-blockchain"
  end
end
