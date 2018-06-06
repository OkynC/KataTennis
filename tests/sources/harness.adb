
with Ada.Text_IO;
with Tennis_Score;
with AUnit.Assertions;
with Ada.Characters.Latin_1;


procedure Harness is

   use type Tennis_Score.T_Set_Point;
begin

   Ada.Text_IO.Put_Line ("Start tests");

   -- Test 1 => player1 win
   Ada.Text_IO.Put_Line ("----------------------- Test 1");
   for Score in Tennis_Score.T_Set_Point'Range loop
      AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_One) = Score,
                               Message   => "Score was not registered for Player1 =>" & Score'Img);
      Tennis_Score.Display_Scores;
      Tennis_Score.Player_Win_Point (Player => Tennis_Score.Player_One);
   end loop;
   Tennis_Score.Reset;


   -- Test 2 => player2 win 2 pts but player1 win 4 pts
   Ada.Text_IO.Put_Line ("----------------------- Test 2");
   -- Start
   Ada.Text_IO.Put_Line ("Score is : Player1 => " & Tennis_Score.Display_Player_Score (Player => Tennis_Score.Player_One) &
                           Ada.Characters.Latin_1.LF &
                           "           Player2 => " & Tennis_Score.Display_Player_Score (Player => Tennis_Score.Player_Two));
   -- P1 Scores
   Tennis_Score.Player_Win_Point (Player => Tennis_Score.Player_One);
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_One) = 1,
                            Message   => "Score was not registered for Player1 => 1");
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_Two) = 0,
                            Message   => "Score was not registered for Player2 => 0");
   Tennis_Score.Display_Scores;

   -- P2 scores
   Tennis_Score.Player_Win_Point (Player => Tennis_Score.Player_Two);
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_One) = 1,
                            Message   => "Score was not registered for Player1 => 1b");
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_Two) = 1,
                            Message   => "Score was not registered for Player2 => 1");
   Tennis_Score.Display_Scores;

   -- P2 scores again
   Tennis_Score.Player_Win_Point (Player => Tennis_Score.Player_Two);
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_One) = 1,
                            Message   => "Score was not registered for Player1 => 1t");
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_Two) = 2,
                            Message   => "Score was not registered for Player2 => 2");
   Tennis_Score.Display_Scores;

   -- P1 scores and scores and win
   Tennis_Score.Player_Win_Point (Player => Tennis_Score.Player_One);
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_One) = 2,
                            Message   => "Score was not registered for Player1 => 2");
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_Two) = 2,
                            Message   => "Score was not registered for Player2 => 2b");
   Tennis_Score.Display_Scores;

   Tennis_Score.Player_Win_Point (Player => Tennis_Score.Player_One);
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_One) = 3,
                            Message   => "Score was not registered for Player1 => 3");
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_Two) = 2,
                            Message   => "Score was not registered for Player2 => 2t");
   Tennis_Score.Display_Scores;

   Tennis_Score.Player_Win_Point (Player => Tennis_Score.Player_One);
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_One) = 4,
                            Message   => "Score was not registered for Player1 => 4");
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_Two) = 2,
                            Message   => "Score was not registered for Player2 => 2q");
   Tennis_Score.Display_Scores;
   Tennis_Score.Reset;

   -- Test 3 => player1 and player2 win pt successively and then player1 win the deuce
   Ada.Text_IO.Put_Line ("----------------------- Test 3");
   for Score in 1 .. 3 loop
      Tennis_Score.Display_Scores;
      Tennis_Score.Player_Win_Point (Player => Tennis_Score.Player_One);
      Tennis_Score.Display_Scores;
      Tennis_Score.Player_Win_Point (Player => Tennis_Score.Player_Two);
   end loop;
   Tennis_Score.Display_Scores;
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_One) = 3,
                            Message   => "Score was not registered for Player1 => 3");
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_Two) = 3,
                            Message   => "Score was not registered for Player2 => 3");
   Tennis_Score.Player_Win_Point (Player => Tennis_Score.Player_One);
   AUnit.Assertions.Assert (Condition => Tennis_Score.Has_Advantage (Player => Tennis_Score.Player_One),
                            Message   => "Score was not registered for Player1 => Adv");
   Tennis_Score.Display_Scores;
   Tennis_Score.Player_Win_Point (Player => Tennis_Score.Player_One);
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_One) = 4,
                            Message   => "Score was not registered for Player1 => 4");
   Tennis_Score.Display_Scores;
   Tennis_Score.Reset;

   -- Test 4 => player1 and player2 win pt successively and then player1 win adv but player2 break
   Ada.Text_IO.Put_Line ("----------------------- Test 4");
   for Score in 1 .. 3 loop
      Tennis_Score.Display_Scores;
      Tennis_Score.Player_Win_Point (Player => Tennis_Score.Player_One);
      Tennis_Score.Display_Scores;
      Tennis_Score.Player_Win_Point (Player => Tennis_Score.Player_Two);
   end loop;
   -- Deuce
   Tennis_Score.Display_Scores;
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_One) = 3,
                            Message   => "Score was not registered for Player1 => 3");
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_Two) = 3,
                            Message   => "Score was not registered for Player2 => 3");
   -- P1 has Adv
   Tennis_Score.Player_Win_Point (Player => Tennis_Score.Player_One);
   AUnit.Assertions.Assert (Condition => Tennis_Score.Has_Advantage (Player => Tennis_Score.Player_One),
                            Message   => "Score was not registered for Player1 => Adv");
   Tennis_Score.Display_Scores;
   -- P2 break
   Tennis_Score.Player_Win_Point (Player => Tennis_Score.Player_Two);
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_One) = 3,
                            Message   => "Score was not registered for Player1 => 3");
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_Two) = 3,
                            Message   => "Score was not registered for Player2 => 3");
   AUnit.Assertions.Assert (Condition => not Tennis_Score.Has_Advantage (Player => Tennis_Score.Player_One),
                            Message   => "Score was not registered for Player2 => break");
   AUnit.Assertions.Assert (Condition => not Tennis_Score.Has_Advantage (Player => Tennis_Score.Player_Two),
                            Message   => "Score was not registered for Player2 => break");
   Tennis_Score.Display_Scores;
   -- P2 take ADV
   Tennis_Score.Player_Win_Point (Player => Tennis_Score.Player_Two);
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_One) = 3,
                            Message   => "Score was not registered for Player1 => 3");
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_Two) = 3,
                            Message   => "Score was not registered for Player2 => 3");
   AUnit.Assertions.Assert (Condition => not Tennis_Score.Has_Advantage (Player => Tennis_Score.Player_One),
                            Message   => "Score was not registered for Player2 => --");
   AUnit.Assertions.Assert (Condition => Tennis_Score.Has_Advantage (Player => Tennis_Score.Player_Two),
                            Message   => "Score was not registered for Player2 => Adv");
   -- P2 wins
   Tennis_Score.Display_Scores;
   Tennis_Score.Player_Win_Point (Player => Tennis_Score.Player_Two);
   AUnit.Assertions.Assert (Condition => Tennis_Score.Get_Player_Score (Player => Tennis_Score.Player_Two) = 4,
                            Message   => "Score was not registered for Player2 => 4");
   Tennis_Score.Display_Scores;
   Tennis_Score.Reset;

   Ada.Text_IO.Put_Line ("End tests");

end Harness;
