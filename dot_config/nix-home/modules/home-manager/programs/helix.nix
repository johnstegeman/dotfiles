{ pkgs, ...}: {
  programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
         theme = "Solarized_Osaka";
         editor = {
            true-color = true;
            indent-guides = {
               character = "┊";
               render = true;
               skip-levels = 1;
            };

            statusline = {
               left = [ "mode" "file-name" "spinner" "read-only-indicator" "file-modification-indicator" ];
               right = [ "diagnostics" "selections" "register" "file-type" "file-line-ending" "position" ];
               mode.normal = "NOR";
               mode.insert = "INS";
               mode.select = "SEL";
            };

            cursor-shape = {
               insert = "bar";
               normal = "block";
               select = "underline";
            };
         };

         keys = {
            normal = {

               # movement

               h = "move_char_left";
               a = "move_visual_line_down";
               C-a = "page_cursor_half_down";
               e = "move_char_right";
               o = "move_visual_line_up";
               C-o = "page_cursor_half_up";

               k = "move_next_word_end";
               K = "move_next_long_word_end";

               j = "search_next";
               J = "search_prev";

               A = "join_selections";
               "A-A" = "join_selections_space";

               E = "keep_selections";
               "A-E" = "remove_selections";

               w = "move_next_word_start";
               W = "move_next_long_word_start";
               b = "move_prev_word_start";
               B = "move_prev_long_word_start";
               q = "move_next_word_end";
               Q = "move_next_long_word_end";

               s = "find_till_char";
               S = "till_prev_char";
               f = "find_next_char";
               F = "find_prev_char";

               G = "goto_line";

               "A-." = "repeat_last_motion";

               g = {
                  h = "goto_line_start";
                  e = "goto_line_end";
               };
               
               z = {
                  a = "scroll_down";
                  o = "scroll_up";
               };

               Z = {
                  a = "scroll_down";
                  o = "scroll_up";
               };

               # changes
               
               i = "insert_mode";
               I = "insert_at_line_start";
               n = "append_mode";
               N = "insert_at_line_end";

               u = "open_below";
               O = "open_above";


               space = {
                  w = {
                     h = "jump_view_left";
                     e = "jump_view_right";
                     o = "jump_view_up";
                     a = "jump_view_down";
                  };
               };
            };

            select = {
               h = "move_char_left";
               a = "move_line_down";
               C-a = "page_cursor_half_down";
               e = "move_char_right";
               o = "move_line_up";
               C-O = "page_cursor_half_up";

               i = "insert_mode";
               I = "insert_at_line_start";

               u = "open_below";
               U = "open_above";

               k = "move_next_word_end";
               K = "move_next_long_word_end";

               j = "search_next";
               J = "search_prev";

               A = "join_selections";
               "A-A" = "join_selections_space";

               E = "keep_selections";
               "A-E" = "remove_selections";
            };
         };
      };
  };

home.file = {
   ".config/helix/themes/Solarized_Osaka.toml".source = ../dotfiles/solarized_osaka.toml;
   };
}