status is-interactive; and begin

   if using mise
      set -gx MISE_INSTALLS_DIR /opt/m
      mise activate fish | source
   end

end
