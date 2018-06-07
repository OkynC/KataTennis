
with Ada.Strings.Unbounded;


package Tennis_Score_V2 is

   type T_Player is (None, Player_One, Player_Two);
   type T_Set_Point is mod 5;

   type T_Match is tagged limited private;

   procedure Player_Win_Point (Match  : in out T_Match;
                               Player : in     T_Player);

   procedure Display_Score (Match : in T_Match);

   function Get_Player_Score (Match  : in T_Match;
                              Player : in T_Player) return T_Set_Point;
   function Display_Player_Score (Match  : in T_Match;
                                  Player : in T_Player) return String;
   function Has_Advantage (Match  : in T_Match;
                           Player : in T_Player) return Boolean;

private

   type T_Score_Display is array (T_Set_Point) of Ada.Strings.Unbounded.Unbounded_String;
   K_Tennis_Score_Display : constant T_Score_Display := (0 => Ada.Strings.Unbounded.To_Unbounded_String (" 0"),
                                                         1 => Ada.Strings.Unbounded.To_Unbounded_String ("15"),
                                                         2 => Ada.Strings.Unbounded.To_Unbounded_String ("30"),
                                                         3 => Ada.Strings.Unbounded.To_Unbounded_String ("40"),
                                                         4 => Ada.Strings.Unbounded.To_Unbounded_String ("VICTORY"));

   type T_Score_Array is array (T_Player) of T_Set_Point;

   type T_Match is tagged limited record
      Score_Array : T_Score_Array := (others => T_Set_Point'First);
      Who_Has_Adv : T_Player := None;
   end record;

end Tennis_Score_V2;
