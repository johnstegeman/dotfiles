function cmap --wraps='chezmoi apply -v --no-pager -R=always' --description 'alias cmap chezmoi apply -v --no-pager -R=always'
  chezmoi apply -v --no-pager -R=always $argv
        
end
