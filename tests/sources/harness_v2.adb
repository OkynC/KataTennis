



with Ada.Text_IO;
with Tennis_Score_V2;
with AUnit.Assertions;


procedure Harness_V2 is

   use type Tennis_Score_V2.T_Set_Point;

begin

   Ada.Text_IO.Put_Line ("Start tests");

   -- Test 1 => player1 win
   declare
      Match_1 : Tennis_Score_V2.T_Match;
   begin
      Ada.Text_IO.Put_Line ("----------------------- Test 1");
      for Score in Tennis_Score_V2.T_Set_Point'Range loop
         AUnit.Assertions.Assert (Condition => Match_1.Get_Player_Score (Player => Tennis_Score_V2.Player_One) = Score,
                                  Message   => "Score was not registered for Player1 =>" & Score'Img);
         Match_1.Display_Score;
         Match_1.Player_Win_Point (Player => Tennis_Score_V2.Player_One);
      end loop;
   end;


   -- Test 2 => player2 win 2 pts but player1 win 4 pts
   declare
      Match_2 : Tennis_Score_V2.T_Match;
   begin
      Ada.Text_IO.Put_Line ("----------------------- Test 2");

      -- Start
      Match_2.Display_Score;

      -- P1 Scores
      Match_2.Player_Win_Point (Player => Tennis_Score_V2.Player_One);
      AUnit.Assertions.Assert (Condition => Match_2.Get_Player_Score (Player => Tennis_Score_V2.Player_One) = 1,
                               Message   => "Score was not registered for Player1 => 1");
      AUnit.Assertions.Assert (Condition => Match_2.Get_Player_Score (Player => Tennis_Score_V2.Player_Two) = 0,
                               Message   => "Score was not registered for Player2 => 0");
      Match_2.Display_Score;

      -- P2 scores
      Match_2.Player_Win_Point (Player => Tennis_Score_V2.Player_Two);
      AUnit.Assertions.Assert (Condition => Match_2.Get_Player_Score (Player => Tennis_Score_V2.Player_One) = 1,
                               Message   => "Score was not registered for Player1 => 1b");
      AUnit.Assertions.Assert (Condition => Match_2.Get_Player_Score (Player => Tennis_Score_V2.Player_Two) = 1,
                               Message   => "Score was not registered for Player2 => 1");
      Match_2.Display_Score;

      -- P2 scores again
      Match_2.Player_Win_Point (Player => Tennis_Score_V2.Player_Two);
      AUnit.Assertions.Assert (Condition => Match_2.Get_Player_Score (Player => Tennis_Score_V2.Player_One) = 1,
                               Message   => "Score was not registered for Player1 => 1t");
      AUnit.Assertions.Assert (Condition => Match_2.Get_Player_Score (Player => Tennis_Score_V2.Player_Two) = 2,
                               Message   => "Score was not registered for Player2 => 2");
      Match_2.Display_Score;

      -- P1 scores and scores and win
      Match_2.Player_Win_Point (Player => Tennis_Score_V2.Player_One);
      AUnit.Assertions.Assert (Condition => Match_2.Get_Player_Score (Player => Tennis_Score_V2.Player_One) = 2,
                               Message   => "Score was not registered for Player1 => 2");
      AUnit.Assertions.Assert (Condition => Match_2.Get_Player_Score (Player => Tennis_Score_V2.Player_Two) = 2,
                               Message   => "Score was not registered for Player2 => 2b");
      Match_2.Display_Score;

      Match_2.Player_Win_Point (Player => Tennis_Score_V2.Player_One);
      AUnit.Assertions.Assert (Condition => Match_2.Get_Player_Score (Player => Tennis_Score_V2.Player_One) = 3,
                               Message   => "Score was not registered for Player1 => 3");
      AUnit.Assertions.Assert (Condition => Match_2.Get_Player_Score (Player => Tennis_Score_V2.Player_Two) = 2,
                               Message   => "Score was not registered for Player2 => 2t");
      Match_2.Display_Score;

      Match_2.Player_Win_Point (Player => Tennis_Score_V2.Player_One);
      AUnit.Assertions.Assert (Condition => Match_2.Get_Player_Score (Player => Tennis_Score_V2.Player_One) = 4,
                               Message   => "Score was not registered for Player1 => 4");
      AUnit.Assertions.Assert (Condition => Match_2.Get_Player_Score (Player => Tennis_Score_V2.Player_Two) = 2,
                               Message   => "Score was not registered for Player2 => 2q");
      Match_2.Display_Score;
   end;

   -- Test 3 => player1 and player2 win pt successively and then player1 win the deuce
   declare
      Match_3 : Tennis_Score_V2.T_Match;
   begin
      Ada.Text_IO.Put_Line ("----------------------- Test 3");
      for Score in 1 .. 3 loop
         Match_3.Display_Score;
         Match_3.Player_Win_Point (Player => Tennis_Score_V2.Player_One);
         Match_3.Display_Score;
         Match_3.Player_Win_Point (Player => Tennis_Score_V2.Player_Two);
      end loop;
      Match_3.Display_Score;
      AUnit.Assertions.Assert (Condition => Match_3.Get_Player_Score (Player => Tennis_Score_V2.Player_One) = 3,
                               Message   => "Score was not registered for Player1 => 3");
      AUnit.Assertions.Assert (Condition => Match_3.Get_Player_Score (Player => Tennis_Score_V2.Player_Two) = 3,
                               Message   => "Score was not registered for Player2 => 3");
      Match_3.Player_Win_Point (Player => Tennis_Score_V2.Player_One);
      AUnit.Assertions.Assert (Condition => Match_3.Has_Advantage (Player => Tennis_Score_V2.Player_One),
                               Message   => "Score was not registered for Player1 => Adv");
      Match_3.Display_Score;
      Match_3.Player_Win_Point (Player => Tennis_Score_V2.Player_One);
      AUnit.Assertions.Assert (Condition => Match_3.Get_Player_Score (Player => Tennis_Score_V2.Player_One) = 4,
                               Message   => "Score was not registered for Player1 => 4");
      Match_3.Display_Score;
   end;

   -- Test 4 => player1 and player2 win pt successively and then player1 win adv but player2 break
   declare
      Match_4 : Tennis_Score_V2.T_Match;
   begin
      Ada.Text_IO.Put_Line ("----------------------- Test 4");
      for Score in 1 .. 3 loop
         Match_4.Display_Score;
         Match_4.Player_Win_Point (Player => Tennis_Score_V2.Player_One);
         Match_4.Display_Score;
         Match_4.Player_Win_Point (Player => Tennis_Score_V2.Player_Two);
      end loop;
      -- Deuce
      Match_4.Display_Score;
      AUnit.Assertions.Assert (Condition => Match_4.Get_Player_Score (Player => Tennis_Score_V2.Player_One) = 3,
                               Message   => "Score was not registered for Player1 => 3");
      AUnit.Assertions.Assert (Condition => Match_4.Get_Player_Score (Player => Tennis_Score_V2.Player_Two) = 3,
                               Message   => "Score was not registered for Player2 => 3");
      -- P1 has Adv
      Match_4.Player_Win_Point (Player => Tennis_Score_V2.Player_One);
      AUnit.Assertions.Assert (Condition => Match_4.Has_Advantage (Player => Tennis_Score_V2.Player_One),
                               Message   => "Score was not registered for Player1 => Adv");
      Match_4.Display_Score;
      -- P2 break
      Match_4.Player_Win_Point (Player => Tennis_Score_V2.Player_Two);
      AUnit.Assertions.Assert (Condition => Match_4.Get_Player_Score (Player => Tennis_Score_V2.Player_One) = 3,
                               Message   => "Score was not registered for Player1 => 3");
      AUnit.Assertions.Assert (Condition => Match_4.Get_Player_Score (Player => Tennis_Score_V2.Player_Two) = 3,
                               Message   => "Score was not registered for Player2 => 3");
      AUnit.Assertions.Assert (Condition => not Match_4.Has_Advantage (Player => Tennis_Score_V2.Player_One),
                               Message   => "Score was not registered for Player2 => break");
      AUnit.Assertions.Assert (Condition => not Match_4.Has_Advantage (Player => Tennis_Score_V2.Player_Two),
                               Message   => "Score was not registered for Player2 => break");
      Match_4.Display_Score;
      -- P2 take ADV
      Match_4.Player_Win_Point (Player => Tennis_Score_V2.Player_Two);
      AUnit.Assertions.Assert (Condition => Match_4.Get_Player_Score (Player => Tennis_Score_V2.Player_One) = 3,
                               Message   => "Score was not registered for Player1 => 3");
      AUnit.Assertions.Assert (Condition => Match_4.Get_Player_Score (Player => Tennis_Score_V2.Player_Two) = 3,
                               Message   => "Score was not registered for Player2 => 3");
      AUnit.Assertions.Assert (Condition => not Match_4.Has_Advantage (Player => Tennis_Score_V2.Player_One),
                               Message   => "Score was not registered for Player2 => --");
      AUnit.Assertions.Assert (Condition => Match_4.Has_Advantage (Player => Tennis_Score_V2.Player_Two),
                               Message   => "Score was not registered for Player2 => Adv");
      -- P2 wins
      Match_4.Display_Score;
      Match_4.Player_Win_Point (Player => Tennis_Score_V2.Player_Two);
      AUnit.Assertions.Assert (Condition => Match_4.Get_Player_Score (Player => Tennis_Score_V2.Player_Two) = 4,
                               Message   => "Score was not registered for Player2 => 4");
      Match_4.Display_Score;
   end;

   Ada.Text_IO.Put_Line ("End tests");

end Harness_V2;
