set -gx MISE_INSTALLS_DIR /opt/m

status is-interactive; and begin

   if using mise
      mise activate fish | source
   end

end
