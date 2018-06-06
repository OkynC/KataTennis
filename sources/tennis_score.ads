
with Ada.Strings.Unbounded;


package Tennis_Score is

   type T_Player is (Player_One, Player_Two);
   type T_Set_Point is mod 5;

   procedure Player_Win_Point (Player : in T_Player);
   function Get_Player_Score (Player : in T_Player) return T_Set_Point;
   function Display_Player_Score (Player : in T_Player) return String;
   procedure Display_Scores;
   function Has_Advantage (Player : in T_Player) return Boolean;

   procedure Reset;

private

   type T_Score_Display is array (T_Set_Point) of Ada.Strings.Unbounded.Unbounded_String;
   K_Tennis_Score_Display : constant T_Score_Display := (0 => Ada.Strings.Unbounded.To_Unbounded_String (" 0"),
                                                         1 => Ada.Strings.Unbounded.To_Unbounded_String ("15"),
                                                         2 => Ada.Strings.Unbounded.To_Unbounded_String ("30"),
                                                         3 => Ada.Strings.Unbounded.To_Unbounded_String ("40"),
                                                         4 => Ada.Strings.Unbounded.To_Unbounded_String ("VICTORY"));

   type T_Score is record
      Points : T_Set_Point := T_Set_Point'First;
      Adv    : Boolean := False;
   end record;
   K_Null_Score : constant T_Score := (Points => T_Set_Point'First,
                                       Adv    => False);
   K_Adv_Score : constant T_Score := (Points => 3,
                                      Adv    => True);
   K_40_Score : constant T_Score := (Points => 3,
                                     Adv    => False);
   K_Victory_Score : constant T_Score := (Points => 4,
                                          Adv    => False);
   type T_Score_Array is array (T_Player) of T_Score;
   G_Score_Counter : T_Score_Array;

end Tennis_Score;
