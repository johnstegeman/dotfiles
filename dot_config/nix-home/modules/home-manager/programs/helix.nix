{ pkgs, ...}: {
  programs.helix = {
      enable = true;
      settings = {
         theme = "Solarized_Osaka";
         editor = {
            true-color = true;
         };

         keys = {
            normal = {

               # movement

               n = "move_char_left";
               e = "move_visual_line_down";
               C-e = "page_cursor_half_down";
               i = "move_char_right";
               u = "move_visual_line_up";
               C-u = "page_cursor_half_up";

               k = "move_next_word_end";
               K = "move_next_long_word_end";

               j = "search_next";
               J = "search_prev";

               E = "join_selections";
               "A-E" = "join_selections_space";

               I = "keep_selections";
               "A-I" = "remove_selections";

               w = "move_next_word_start";
               W = "move_next_long_word_start";
               b = "move_prev_word_start";
               B = "move_prev_long_word_start";
               q = "move_next_word_end";
               Q = "move_next_long_word_end";

               t = "find_till_char";
               T = "till_prev_char";
               f = "find_next_char";
               F = "find_prev_char";

               G = "goto_line";

               "A-." = "repeat_last_motion";

               g = {
                  n = "goto_line_start";
                  i = "goto_line_end";
               };
               
               z = {
                  e = "scroll_down";
                  u = "scroll_up";
               };

               Z = {
                  e = "scroll_down";
                  u = "scroll_up";
               };

               # changes
               
               h = "insert_mode";
               H = "insert_at_line_start";
               a = "append_mode";
               A = "insert_at_line_end";

               o = "open_below";
               O = "open_above";


               space = {
                  w = {
                     n = "jump_view_left";
                     i = "jump_view_right";
                     u = "jump_view_up";
                     e = "jump_view_down";
                  };
               };
            };

            select = {
               n = "move_char_left";
               e = "move_line_down";
               C-e = "page_cursor_half_down";
               i = "move_char_right";
               u = "move_line_up";
               C-u = "page_cursor_half_up";

               h = "insert_mode";
               H = "insert_at_line_start";

               o = "open_below";
               O = "open_above";

               k = "move_next_word_end";
               K = "move_next_long_word_end";

               j = "search_next";
               J = "search_prev";

               E = "join_selections";
               "A-E" = "join_selections_space";

               I = "keep_selections";
               "A-I" = "remove_selections";
            };
         };
      };
  };

home.file = {
   ".config/helix/themes/Solarized_Osaka.toml".source = ../dotfiles/solarized_osaka.toml;
   };
}