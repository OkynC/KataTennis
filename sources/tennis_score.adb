
with Ada.Text_IO;
with Ada.Characters.Latin_1;


package body Tennis_Score is

   procedure Player_Win_Point (Player : in T_Player)
   is
      Other_Player : constant T_Player := (if Player = Player_One then Player_Two else Player_One);
   begin
      Ada.Text_IO.Put ("Player " & Player'Img & " scores");
      -- Take Adv
      if G_Score_Counter (Player_One) = K_40_Score
        and then G_Score_Counter (Player_Two) = K_40_Score
      then
         Ada.Text_IO.Put_Line (" and take ADVANTAGE !");
         G_Score_Counter (Player) := K_Adv_Score;

         -- Had Adv => Win
      elsif G_Score_Counter (Player) = K_Adv_Score then
         Ada.Text_IO.Put_Line (" and wins !");
         G_Score_Counter (Player) := K_Victory_Score;

         -- Break
      elsif G_Score_Counter (Player) = K_40_Score
        and then G_Score_Counter (Other_Player) = K_Adv_Score then
         Ada.Text_IO.Put_Line (" and BREAK !");
         G_Score_Counter (Other_Player) := K_40_Score;

         -- Nominal case
      else
         Ada.Text_IO.New_Line;
         G_Score_Counter (Player).Points := G_Score_Counter (Player).Points + 1;
      end if;
   end Player_Win_Point;

   function Get_Player_Score (Player : in T_Player) return T_Set_Point is
   begin
      return G_Score_Counter (Player).Points;
   end Get_Player_Score;

   function Display_Player_Score (Player : in T_Player) return String is
   begin
      return Ada.Strings.Unbounded.To_String (K_Tennis_Score_Display (G_Score_Counter (Player).Points));
   end Display_Player_Score;

   procedure Display_Scores is
   begin
      if G_Score_Counter (Player_One) = K_Adv_Score
        and then G_Score_Counter (Player_Two) = K_40_Score
      then
         Ada.Text_IO.Put_Line ("Score is : Player1 => Adv" &
                                 Ada.Characters.Latin_1.LF &
                                 "           Player2 => ");

      elsif G_Score_Counter (Player_One) = K_40_Score
        and then G_Score_Counter (Player_Two) = K_Adv_Score
      then
         Ada.Text_IO.Put_Line ("Score is : Player1 => " &
                                 Ada.Characters.Latin_1.LF &
                                 "           Player2 => Adv");

      elsif G_Score_Counter (Player_One) = K_40_Score
        and then G_Score_Counter (Player_Two) = K_40_Score
      then
         Ada.Text_IO.Put_Line ("Score is : Player1 & Player2 => deuce");

      elsif G_Score_Counter (Player_One) = K_Victory_Score then
         Ada.Text_IO.Put_Line ("Player1 Wins !");

      elsif G_Score_Counter (Player_Two) = K_Victory_Score then
         Ada.Text_IO.Put_Line ("Player2 Wins !");

      else
         Ada.Text_IO.Put_Line ("Score is : Player1 => " & Display_Player_Score (Player => Player_One) &
                                 Ada.Characters.Latin_1.LF &
                                 "           Player2 => " & Display_Player_Score (Player => Player_Two));
      end if;
   end Display_Scores;

   function Has_Advantage (Player : in T_Player) return Boolean is
   begin
      return G_Score_Counter (Player).Adv;
   end Has_Advantage;

   procedure Reset is
   begin
      G_Score_Counter (Player_One) := K_Null_Score;
      G_Score_Counter (Player_Two) := K_Null_Score;
   end Reset;

end Tennis_Score;
