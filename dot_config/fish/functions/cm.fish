function cm --description 'wrapper for chezmoi: ap or ed'
  
   if using chezmoi

      switch $argv[1]
         case ap; chezmoi apply -v --no-pager -R=always
         case ed; code $(chezmoi source-path)
         case cd; cd $(chezmoi source-path)
      end

   end 

end