
with Ada.Text_IO;
with Ada.Characters.Latin_1;


package body Tennis_Score_V2 is

   ----------------------
   -- Player_Win_Point --
   ----------------------

   procedure Player_Win_Point (Match  : in out T_Match;
                               Player : in     T_Player) is
   begin
      Ada.Text_IO.Put ("Player " & Player'Img & " scores");

      -- Take Adv
      if Match.Score_Array (Player_One) = 3
        and then Match.Score_Array (Player_Two) = 3
      then

         -- Take Adv
         case Match.Who_Has_Adv is
            when None =>
               Ada.Text_IO.Put_Line (" and take ADVANTAGE !");
               Match.Who_Has_Adv := Player;

            when Player_One =>
               if Player = Player_One then
                  -- Had Adv => Win
                  Ada.Text_IO.Put_Line (" and wins !");
                  Match.Who_Has_Adv := None;
                  Match.Score_Array (Player_One) := 4;

               else
                  -- Break
                  Ada.Text_IO.Put_Line (" and BREAK !");
                  Match.Who_Has_Adv := None;
               end if;

            when Player_Two =>
               if Player = Player_Two then
                  -- Had Adv => Win
                  Ada.Text_IO.Put_Line (" and wins !");
                  Match.Who_Has_Adv := None;
                  Match.Score_Array (Player_Two) := 4;

               else
                  -- Break
                  Ada.Text_IO.Put_Line (" and BREAK !");
                  Match.Who_Has_Adv := None;
               end if;
         end case;

         -- Nominal case
      else
         Ada.Text_IO.New_Line;
         Match.Score_Array (Player) := Match.Score_Array (Player) + 1;
      end if;
   end Player_Win_Point;

   --------------------------
   -- Display_Player_Score --
   --------------------------

   function Display_Player_Score (Match  : in T_Match;
                                  Player : in T_Player) return String is
   begin
      return Ada.Strings.Unbounded.To_String (K_Tennis_Score_Display (Match.Score_Array (Player)));
   end Display_Player_Score;

   -------------------
   -- Display_Score --
   -------------------

   procedure Display_Score (Match : in T_Match) is
   begin
      case Match.Who_Has_Adv is
         when Player_One =>
            Ada.Text_IO.Put_Line ("Score is : Player1 => Adv" &
                                    Ada.Characters.Latin_1.LF &
                                    "           Player2 => ");

         when Player_Two =>
            Ada.Text_IO.Put_Line ("Score is : Player1 => " &
                                    Ada.Characters.Latin_1.LF &
                                    "           Player2 => Adv");

         when None =>
            if Match.Score_Array (Player_One) = Match.Score_Array (Player_Two) then
               if Match.Score_Array (Player_One) = 3 then
                  Ada.Text_IO.Put_Line ("Score is : Player1 & Player2 => deuce");

               elsif Match.Score_Array (Player_One) /= 0 then
                  Ada.Text_IO.Put_Line ("Score is : Player1 => " & Display_Player_Score (Match, Player_One) &
                                          Ada.Characters.Latin_1.LF &
                                          "           Player2 =>  A");

               else
                  Ada.Text_IO.Put_Line ("Score is : Player1 => " & Display_Player_Score (Match, Player_One) &
                                          Ada.Characters.Latin_1.LF &
                                          "           Player2 => " & Display_Player_Score (Match, Player_Two));
               end if;

            elsif Match.Score_Array (Player_One) = 4 then
               Ada.Text_IO.Put_Line ("Player1 Wins !");

            elsif Match.Score_Array (Player_Two) = 4 then
               Ada.Text_IO.Put_Line ("Player2 Wins !");

            else
               Ada.Text_IO.Put_Line ("Score is : Player1 => " & Display_Player_Score (Match, Player_One) &
                                       Ada.Characters.Latin_1.LF &
                                       "           Player2 => " & Display_Player_Score (Match, Player_Two));
            end if;
      end case;
   end Display_Score;

   ----------------------
   -- Get_Player_Score --
   ----------------------

   function Get_Player_Score (Match  : in T_Match;
                              Player : in T_Player) return T_Set_Point is
   begin
      return Match.Score_Array (Player);
   end Get_Player_Score;

   -------------------
   -- Has_Advantage --
   -------------------

   function Has_Advantage (Match  : in T_Match;
                           Player : in T_Player) return Boolean is
   begin
      return Match.Who_Has_Adv = Player;
   end Has_Advantage;

end Tennis_Score_V2;
