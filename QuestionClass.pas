unit QuestionClass;

interface

uses System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms, Math, Character;

type TQuestion = Class
  private
    QTopic : String[30];
    QSubTopic : String[30];
    QQuestion : String;
    QCorrectAnswer : String;
    function ExpandBinomial (Binomial : String) : String;
    function GenerateAlgebraicFraction : String;
    function AddAlgebraicFractions (Equation1, Equation2 : String) : String;
    function GenerateVector : String;
    function GetMagnitudeOfVector (Vector : String) : String;
    function VectorScalarProduct (VectorA, VectorB : String) : String;
    function VectorAngleBetween (VectorA, VectorB : String) : String;
    function VectorThirdConnector (VectorA, VectorB : String) : String;
    function DifferentiateAToTheX (Equation : String) : String;
    function DifferentiateEToTheX (Equation : String) : String;
    function IntegrationEToTheX (Equation : String) : String;
    function IntegrationReciprocal (Equation : String) : String;
    function GenerateEquation(Constant, Linear, Quadratic, Cubic, Fraction, Trig, AdvancedTrig, Log, E, AToTheX : Boolean) : String;
    procedure GenerateParametricToCartesianQuestion;
    procedure GenerateIterationQuestion;
  public
    constructor Create(TheTopic: string; TheSubTopic: string);
    function GetTopic : String;
    function GetSubTopic : String;
    procedure SetTopic (NewTopic : String);
    procedure SetSubTopic (NewSubTopic : String);
    procedure SetQuestion (NewQuestion : String);
    procedure SetCorrectAnswer (NewCorrectAnswer : String);
    property Topic : String read GetTopic write SetTopic;
    property SubTopic : String read GetSubTopic write SetSubTopic;
    property Question : String read QQuestion write SetQuestion;
    property CorrectAnswer : String read QCorrectAnswer write SetCorrectAnswer;
End;

function ValueOfFunction (FunctionString : String; XValue : Real) : Real;
procedure ShowMathsText (Text : String; X, Y, GapWidth : Integer; Canvas : TCanvas);
procedure ClearCanvas (Form : TForm);

implementation

function ValueOfFunction(FunctionString : String; XValue : Real) : Real;
var WorkingValue : Real; Count, ConstantCount, Coeff, Power : Integer; Constant : String;
begin
  // Initialise
  WorkingValue := 0;

  // Go through all of the function to find unknown parameters
  for Count := 1 to Length(FunctionString) do
  begin
    // x is found - find power, coefficient and calculate with value of x
    if LowerCase(FunctionString[Count]) = 'x' then
    begin
      try
        Coeff := StrToInt(FunctionString[Count - 1]);
        if FunctionString[Count - 2] = '-' then Coeff := -Coeff;
      except
        Coeff := 1;
      end;

      Power := 0;
      try
        if FunctionString[Count + 1] = '^' then
        begin
          if FunctionString[Count + 2] = '{' then Power := StrToInt(FunctionString[Count + 3])
          else Power := StrToInt(FunctionString[Count + 2]);
        end;
      except
        Power := 1;
      end;

      if Power = 3 then WorkingValue := WorkingValue + (Coeff * XValue * XValue * XValue)
      else if Power = 2 then WorkingValue := WorkingValue + (Coeff * XValue * XValue)
      else if Power = 1 then WorkingValue := WorkingValue + (Coeff * XValue);
    end
    // + is found, the next term will be positive
    else if FunctionString[Count] = '+' then
    begin
      ConstantCount := Count + 1;
      Constant := '';
      // Get x coefficient and power and calculate term value
      repeat
        if LowerCase(FunctionString[ConstantCount]) = 'x' then Constant := ''
        else Constant := Constant + FunctionString[ConstantCount];
        ConstantCount := ConstantCount + 1;
      until (Not(LowerCase(FunctionString[ConstantCount]) = 'x') and Not CharInSet(FunctionString[ConstantCount], ['0'..'9'])) or (ConstantCount > Length(FunctionString));
      if Constant <> '' then WorkingValue := WorkingValue + StrToInt(Constant);
    end
    // - is found, the next term will be negative
    else if FunctionString[Count] = '-' then
    begin
      ConstantCount := Count + 1;
      Constant := '';
      // Get x coefficient and power and calculate term value (with negative)
      repeat
        if LowerCase(FunctionString[ConstantCount]) = 'x' then Constant := ''
        else Constant := Constant + FunctionString[ConstantCount];
        ConstantCount := ConstantCount + 1;
      until (Not(LowerCase(FunctionString[ConstantCount]) = 'x') and Not CharInSet(FunctionString[ConstantCount], ['0'..'9'])) or (ConstantCount > Length(FunctionString));
      if Constant <> '' then WorkingValue := WorkingValue - StrToInt(Constant);
    end;
  end;

  Result := WorkingValue;
end;

function TQuestion.ExpandBinomial (Binomial : String) : String;
var Constant, Power : Integer; Expansion : String;
begin
  Constant := StrToInt(Binomial[4]);
  Power := StrToInt(Binomial[9]);

  Expansion := '1+';
  Expansion := Expansion + IntToStr(Constant * Power) + 'x+';
  Expansion := Expansion + IntToStr(Power * (Power - 1) * Sqr(Constant) DIV 2) + 'x^{2}+';
  Expansion := Expansion + IntToStr(Power * (Power - 1) * (Power - 2) * (Constant * Constant * Constant) DIV 6) + 'x^{3}';
  Result := Expansion;
end;

function TQuestion.GenerateAlgebraicFraction : String;
var Fraction : String;
begin
  Fraction := '\frac{';
  Fraction := Fraction + IntToStr(Random(8) + 2);
  Fraction := Fraction + '}{';
  Fraction := Fraction + 'x+' + IntToStr(Random(8) + 2);
  Fraction := Fraction + '}';
  Result := Fraction;
end;

function TQuestion.AddAlgebraicFractions(Equation1, Equation2 : String) : String;
var A, B, C, D : Integer; Sum : String;
begin
  // Split coeffs and constants --- \frac{ax+b}{cx+d} --- \frac{ex+f}{gx+h}
  A := StrToInt(Equation1[7]);
  B := StrToInt(Equation1[12]);
  C := StrToInt(Equation2[7]);
  D := StrToInt(Equation2[12]);

  // Rewrite answer
  Sum := '\frac{' + IntToStr(A + C) + 'x+' + IntToStr(A*D + B*C) + '}{(x+' + IntToStr(B) + ')(x+' + IntToStr(D) + ')}';
  Result := Sum;
end;

function TQuestion.GenerateVector : String;
var ICoeff, JCoeff : Integer;
begin
  repeat
    ICoeff := Random(19) - 9;
  until (ICoeff < -1) or (ICoeff > 1);
  repeat
    JCoeff := Random(19) - 9;
  until (JCoeff < -1) or (JCoeff > 1);

  if JCoeff > 0 then Result := IntToStr(ICoeff) + 'i+' + IntToStr(JCoeff) + 'j'
  else Result := IntToStr(ICoeff) + 'i' + IntToStr(JCoeff) + 'j';
end;

function TQuestion.GetMagnitudeOfVector (Vector : String) : String;
var ICoeff, JCoeff, SquaredMagnitude : Integer;
begin
  // Split vector into coefficients of i and j
  if Vector[1] = '-' then
  begin
    ICoeff := StrToInt('-' + Vector[2]);
    JCoeff := StrToInt(Vector[5]);
  end
  else
  begin
    ICoeff := StrToInt(Vector[1]);
    JCoeff := StrToInt(Vector[4]);
  end;

  // Calculate magnitude
  SquaredMagnitude := Sqr(ICoeff) + Sqr(JCoeff);
  if SquaredMagnitude = 4 then Result := '2'
  else if SquaredMagnitude = 9 then Result := '3'
  else if SquaredMagnitude = 16 then Result := '4'
  else if SquaredMagnitude = 25 then Result := '5'
  else if SquaredMagnitude = 36 then Result := '6'
  else if SquaredMagnitude = 49 then Result := '7'
  else if SquaredMagnitude = 64 then Result := '8'
  else if SquaredMagnitude = 81 then Result := '9'
  else if SquaredMagnitude = 100 then Result := '10'
  else if SquaredMagnitude = 121 then Result := '11'
  else if SquaredMagnitude = 144 then Result := '12'
  else if SquaredMagnitude = 169 then Result := '13'
  else if SquaredMagnitude = 196 then Result := '14'
  else if SquaredMagnitude = 225 then Result := '15'
  else if SquaredMagnitude = 256 then Result := '16'
  else if SquaredMagnitude = 289 then Result := '17'
  else Result := '\sqrt{' + IntToStr(SquaredMagnitude) + '}';
end;

function TQuestion.VectorScalarProduct(VectorA, VectorB : String) : String;
var AICoeff, AJCoeff, BICoeff, BJCoeff : Integer;
begin
  // Get coefficients of vector A
  if VectorA[1] = '-' then
  begin
    AICoeff := StrToInt('-' + VectorA[2]);
    if VectorA[4] = '-' then AJCoeff := StrToInt('-' + VectorA[5])
    else AJCoeff := StrToInt(VectorA[5]);
  end
  else
  begin
    AICoeff := StrToInt(VectorA[1]);
    if VectorA[3] = '-' then AJCoeff := StrToInt('-' + VectorA[4])
    else AJCoeff := StrToInt(VectorA[4]);
  end;

  // Get coefficients of vector B
  if VectorB[1] = '-' then
  begin
    BICoeff := StrToInt('-' + VectorB[2]);
    if VectorB[4] = '-' then BJCoeff := StrToInt('-' + VectorB[5])
    else BJCoeff := StrToInt(VectorB[5]);
  end
  else
  begin
    BICoeff := StrToInt(VectorB[1]);
    if VectorB[3] = '-' then BJCoeff := StrToInt('-' + VectorB[4])
    else BJCoeff := StrToInt(VectorB[4]);
  end;

  Result := IntToStr((AICoeff * BICoeff) + (AJCoeff * BJCoeff));
end;

function TQuestion.VectorAngleBetween(VectorA, VectorB : String) : String;
var VectorAMagnitude, VectorBMagnitude : Real; ChangingString : String;
begin
  // If magnitude of vector is integer, write that
  if Length(GetMagnitudeOfVector(VectorA)) < 3 then VectorAMagnitude := StrToFloat(GetMagnitudeOfVector(VectorA))
  // Else it is in surd form, write with square root
  else
  begin
    ChangingString := StringReplace(GetMagnitudeOfVector(VectorA), '\sqrt{', '', [rfReplaceAll]);
    ChangingString := StringReplace(ChangingString, '}', '', [rfReplaceAll]);
    VectorAMagnitude := sqrt(StrToInt(ChangingString));
  end;

  // If magnitude of vector is integer, write that
  if Length(GetMagnitudeOfVector(VectorB)) < 3 then VectorBMagnitude := StrToFloat(GetMagnitudeOfVector(VectorB))
  // Else it is in surd form, write with square root
  else
  begin
    ChangingString := StringReplace(GetMagnitudeOfVector(VectorB), '\sqrt{', '', [rfReplaceAll]);
    ChangingString := StringReplace(ChangingString, '}', '', [rfReplaceAll]);
    VectorBMagnitude := sqrt(StrToInt(ChangingString));
  end;

  Result := IntToStr( Round(Arccos(StrToInt(VectorScalarProduct(VectorA, VectorB)) / (VectorAMagnitude * VectorBMagnitude)) * 180 / pi));
end;

function TQuestion.VectorThirdConnector(VectorA, VectorB : String) : String;
var AICoeff, AJCoeff, BICoeff, BJCoeff, CICoeff, CJCoeff : Integer; ThirdVector : String;
begin
  // Split vector A into coefficient and constant
  if VectorA[1] = '-' then
  begin
    AICoeff := StrToInt('-' + VectorA[2]);
    if VectorA[4] = '-' then AJCoeff := StrToInt('-' + VectorA[5])
    else AJCoeff := StrToInt(VectorA[5]);
  end
  else
  begin
    AICoeff := StrToInt(VectorA[1]);
    if VectorA[3] = '-' then AJCoeff := StrToInt('-' + VectorA[4])
    else AJCoeff := StrToInt(VectorA[4]);
  end;

  // Split vector B into coefficient and constant
  if VectorB[1] = '-' then
  begin
    BICoeff := StrToInt('-' + VectorB[2]);
    if VectorB[4] = '-' then BJCoeff := StrToInt('-' + VectorB[5])
    else BJCoeff := StrToInt(VectorB[5]);
  end
  else
  begin
    BICoeff := StrToInt(VectorB[1]);
    if VectorB[3] = '-' then BJCoeff := StrToInt('-' + VectorB[4])
    else BJCoeff := StrToInt(VectorB[4]);
  end;

  // Replace 1 with i or j so not shown in the actual question (correct format)
  CICoeff := -1 * (AICoeff + BICoeff);
  CJCoeff := -1 * (AJCoeff + BJCoeff);
  ThirdVector := '';
  if CICoeff = -1 then ThirdVector := '-i'
  else if CICoeff = 1 then ThirdVector := 'i'
  else if CICoeff <> 0 then ThirdVector := IntToStr(CICoeff) + 'i';
  if CJCoeff = -1 then ThirdVector := ThirdVector + '-j'
  else if CJCoeff = 1 then ThirdVector := ThirdVector + '+j'
  else if CJCoeff < 0 then ThirdVector := ThirdVector + IntToStr(CJCoeff) + 'j'
  else if CJCoeff > 0 then ThirdVector := ThirdVector + '+' + IntToStr(CJCoeff) + 'j';

  Result := ThirdVector;
end;

function TQuestion.DifferentiateAToTheX (Equation : String) : String;
var Coeff, Term, Power, DiffEquation : String;
begin
  // Split into coefficient, term and power
  Coeff := '';
  Term := '';
  Power := '';
  if Equation[2] = '(' then
  begin
    Coeff := Equation[1];
    Term := Equation[3];
    if Equation[6] = 'x' then Power := '1'
    else Power := Equation[6];
  end
  else
  begin
    Coeff := '1';
    Term := Equation[1];
    if Equation[4] = 'x' then Power := '1'
    else Power := Equation[4];
  end;

  // Rewrite differential
  DiffEquation := '';
  if Coeff <> '1' then DiffEquation := Coeff;
  DiffEquation := DiffEquation + '(' + Term + '^{';
  if Power <> '1' then DiffEquation := DiffEquation + Power;
  DiffEquation := DiffEquation + 'x})ln(' + Term + ')';

  // Return differential
  Result := DiffEquation;
end;

function TQuestion.DifferentiateEToTheX(Equation: String) : String;
var Coeff, Power, DiffEquation : String;
begin
  Coeff := '';
  Power := '';
  DiffEquation := '';
  // Split into coeff and power
  if Equation[1] <> 'e' then
  begin
    Coeff := Equation[1];
    if Equation[5] <> 'x' then
    begin
      // Negative number
      if Equation[5] = '-' then Power := Equation[5] + Equation[6]
      // Positive number
      else Power := Equation[5];
    end
    else Power := '1';
  end
  else
  begin
    Coeff := '1';
    if Equation[4] <> 'x' then
    begin
      // Negative number
      if Equation[4] = '-' then Power := Equation[4] + Equation[5]
      // Positive number
      else Power := Equation[4];
    end
    else Power := '1';
  end;

  // Calculate differential
  if (Power <> '1') and (Coeff <> '1') then DiffEquation := IntToStr(StrToInt(Coeff) * StrToInt(Power));
  DiffEquation := DiffEquation + 'e^{';
  if (Power <> '1') then DiffEquation := DiffEquation + Power;
  DiffEquation := DiffEquation + 'x}';

  // Return Differential
  Result := DiffEquation;
end;

function TQuestion.IntegrationEToTheX (Equation : String) : String;
var Coeff, Power, IntEquation : String;
begin
  Coeff := '';
  Power := '';
  IntEquation := '';
  // Split into coeff and power
  if Equation[1] <> 'e' then
  begin
    Coeff := Equation[1];
    if Equation[5] <> 'x' then
    begin
      // Negative number
      if Equation[5] = '-' then Power := Equation[5] + Equation[6]
      // Positive number
      else Power := Equation[5];
    end
    else Power := '1';
  end
  else
  begin
    Coeff := '1';
    if Equation[4] <> 'x' then
    begin
      // Negative number
      if Equation[4] = '-' then Power := Equation[4] + Equation[5]
      // Positive number
      else Power := Equation[4];
    end
    else Power := '1';
  end;

  // Calculate new integrated coeff
  if StrToInt(Coeff) DIV StrToInt(Power) < 0 then IntEquation := '-';
  if StrToInt(Coeff) MOD StrToInt(Power) = 0 then
  begin
    if Abs(StrToInt(Coeff)) > Abs(StrToInt(Power)) then IntEquation := IntEquation + IntToStr(Abs(StrToInt(Coeff) DIV StrToInt(Power))) + 'e^{' + Power + 'x}'
    else if Abs(StrToInt(Coeff)) = Abs(StrToInt(Power)) then IntEquation := IntEquation + 'e^{' + Power + 'x}'
    else
    begin
      IntEquation := IntEquation + '\frac{e^{' + Power + 'x}}{' + IntToStr(Abs(StrToInt(Power))) + '}';
    end;
  end
  else IntEquation := IntEquation + '\frac{' + IntToStr(Abs(StrToInt(Coeff))) + 'e^{' + Power + 'x}}{' + IntToStr(Abs(StrToInt(Power))) + '}';

  Result := IntEquation;
end;

function TQuestion.IntegrationReciprocal (Equation : String) : String;
var Coeff, Constant, IntEquation : String;
begin
  Coeff := Equation[10];
  Constant := Equation[13];
  IntEquation := '\frac{ln(' + Coeff + 'x+' + Constant + '}{' + Coeff + '}';
  Result := IntEquation;
end;

// Generate an equation
function TQuestion.GenerateEquation(Constant, Linear, Quadratic, Cubic, Fraction, Trig, AdvancedTrig, Log, E, AToTheX : Boolean) : String;
var Equation : String; RandomInt : Integer;
begin
  // Initialise equation
  Equation := '';

  // Simple trig - sin, cos, tan
  if Trig then
  begin
    RandomInt := Random(3);
    if RandomInt = 0 then Equation := Equation + '\sin(x)';
    if RandomInt = 1 then Equation := Equation + '\cos(x)';
    if RandomInt = 2 then Equation := Equation + '\tan(x)';
  end;
  // Advanced trig - sec, cot, cosec
  if AdvancedTrig then
  begin
    // Add a plus to the start if not first thing
    if Length(Equation) <> 0 then Equation := Equation + '+';

    RandomInt := Random(3);
    if RandomInt = 0 then Equation := Equation + '\cot(x)';
    if RandomInt = 1 then Equation := Equation + '\sec(x)';
    if RandomInt = 2 then Equation := Equation + '\cosec(x)';
  end;
  // Ln
  if Log then
  begin
    // Add a plus to the start if not first thing
    if Length(Equation) <> 0 then Equation := Equation + '+';
    Equation := Equation + 'ln(x)';
  end;
  // e
  if E then
  begin
    // Add a plus to the start if not first thing
    if Length(Equation) <> 0 then Equation := Equation + '+';

    // Coefficient and e
    RandomInt := Random(9) + 1;
    if RandomInt <> 1 then Equation := Equation + IntToStr(RandomInt) + 'e^{';

    // Power
    repeat
      RandomInt := Random(11) - 5;
    until (RandomInt <> 0) and (RandomInt <> 1) and (RandomInt <> -1);
    Equation := Equation + IntToStr(RandomInt);
    Equation := Equation + 'x}';
  end;
  // a^x
  if AToTheX then
  begin
    // Add a plus to the start if not first thing
    if Length(Equation) <> 0 then Equation := Equation + '+';

    // Coefficient
    RandomInt := Random(9) + 1;
    if RandomInt <> 1 then Equation := Equation + IntToStr(RandomInt) + '(';

    // A to the X
    RandomInt := Random(7) + 2;
    Equation := Equation + IntToStr(RandomInt);
    Equation := Equation + '^{x}';
    if Equation[Length(Equation) - 5] = '(' then Equation := Equation + ')';
  end;
  // Fraction
  if Fraction then
  begin
    // Add a plus to the start if not first thing
    if Length(Equation) <> 0 then Equation := Equation + '+';
    Equation := Equation + '\frac{' + GenerateEquation(true, true, false, false, false, false, false, false, false, false) + '}{' + GenerateEquation(true, true, false, false, false, false, false, false, false, false) + '}';
  end;
  // Cubic - x^3
  if Cubic then
  begin
    // Add a plus to the start if not first thing
    if Length(Equation) <> 0 then Equation := Equation + '+';
    Equation := Equation + 'x^{3}';
  end;
  // Quadratic - x^2
  if Quadratic then
  begin
    // Add a plus or minus to the start if not first thing
    if Length(Equation) <> 0 then
    begin
      RandomInt := Random(2);
      if RandomInt = 0 then Equation := Equation + '+'
      else Equation := Equation + '-';

      // Random coefficient
      RandomInt := Random(5) + 2;
      if RandomInt = 1 then Equation := Equation + 'x^{2}'
      else Equation := Equation + IntToStr(RandomInt) + 'x^{2}';
    end
    // No coefficient if first term
    else Equation := Equation + 'x^{2}';
  end;
  // Linear - x
  if Linear then
  begin
    // Add a plus or minus to the start if not first thing
    if Length(Equation) <> 0 then
    begin
      RandomInt := Random(2);
      if RandomInt = 0 then Equation := Equation + '+'
      else Equation := Equation + '-';

      // Random Coefficient
      RandomInt := Random(8) + 2;
      if RandomInt = 1 then Equation := Equation + 'x'
      else Equation := Equation + IntToStr(RandomInt) + 'x';
    end
    // No coefficient if first term
    else Equation := Equation + 'x';
  end;
  // Constant - number
  if Constant then
  begin
    // Add a plus to the start if not first thing
    if Length(Equation) <> 0 then
    begin
      RandomInt := Random(2);
      if RandomInt = 0 then Equation := Equation + '+'
      else Equation := Equation + '-';
    end;
    Equation := Equation + IntToStr(Random(8) + 2);
  end;

  GenerateEquation := Equation;
end;

procedure TQuestion.GenerateParametricToCartesianQuestion;
var QuestionType : Integer; XParametric, YParametric, CartesianEquation : String;
begin
  // Choose question type
  QuestionType := Random(2);

  if QuestionType = 0 then
  begin
    // Create equations for question
    XParametric := IntToStr(Random(5) + 2) + 't+' + IntToStr(Random(8) + 2);
    YParametric := 't^{2}';
    CartesianEquation := 'y=(\frac{x-' + XParametric[4] + '}{' + XParametric[1] + '})^{2}';
  end
  else if QuestionType = 1 then
  begin
    // Create equations for question
    XParametric := IntToStr(Random(5) + 2) + 't+' + IntToStr(Random(8) + 2);
    YParametric := '\frac{1}{t}';
    CartesianEquation := 'y=\frac{' + XParametric[1] + '}{x-' + XParametric[4] + '}';
  end;

  // Write question and answer
  QQuestion := 'Write x=' + XParametric + ' and y=' + YParametric + ' in cartesian form';
  QCorrectAnswer := CartesianEquation;
end;

procedure TQuestion.GenerateIterationQuestion;
var XValue, StartingXValue : Real; Equation, IterativeEquation : String; Count, NumOfIterations : Integer;
begin
  // Keep generating question until numbers are not too large (over 1000 or under -1000)
  repeat
    Equation := GenerateEquation(true, true, true, false, false, false, false, false, false, false);
    StartingXValue := (Random(20) + 1) / 10;
    XValue := StartingXValue;
    NumOfIterations := Random(5) + 3;

    for Count := 1 to NumOfIterations do
      XValue := ValueOfFunction(Equation, XValue);
  until (XValue >= -999) and (XValue <= 999);

  // Format question and output
  IterativeEquation := StringReplace(Equation, 'x', 'x_n', [rfReplaceAll]);
  QQuestion := 'x_{n+1}=' + IterativeEquation + ' and x_0=' + FloatToStr(StartingXValue) + '. Find x_' + IntToStr(NumOfIterations) + ' to 2dp';
  QCorrectAnswer := FormatFloat('##0.00', XValue);
end;

constructor TQuestion.Create(TheTopic: string; TheSubTopic: string);
var Equation1, Equation2, Equation3 : String; RandomNum : Integer;
begin
  // Set topic and sub topic
  QTopic := AnsiString(TheTopic);
  QSubTopic := AnsiString(TheSubTopic);

  QQuestion := '';
  QCorrectAnswer := '';

  // Generate question and calculate answer
  // Algebra and Series
  if TheTopic = 'Algebra and Series' then
  begin
    if TheSubTopic = 'Algebraic Fractions' then
    begin
      Equation1 := GenerateAlgebraicFraction;
      Equation2 := GenerateAlgebraicFraction;
      Equation3 := AddAlgebraicFractions(Equation1, Equation2);
      QQuestion := 'Write ' + Equation1 + ' + ' + Equation2 + ' as a single fraction';
      QCorrectAnswer := Equation3;
    end
    else if TheSubTopic = 'Partial Fractions' then
    begin
      Equation1 := GenerateAlgebraicFraction;
      Equation2 := GenerateAlgebraicFraction;
      Equation3 := AddAlgebraicFractions(Equation1, Equation2);
      QQuestion := 'Write ' + Equation3 + ' as two fractions';
      QCorrectAnswer := Equation1 + '+' + Equation2;
    end
    else if TheSubTopic = 'Binomial Expansion' then
    begin
      Equation1 := '(1+' + IntToStr(Random(8) + 2) + 'x)^{' + IntToStr(Random(6) + 4) + '}';
      Equation2 := ExpandBinomial(Equation1);
      QQuestion := 'Expand ' + Equation1 + ' to the cubic power';
      QCorrectAnswer := Equation2;
    end;
  end;

  // Coordinate Geometry
  if TheTopic = 'Coordinate Geometry' then
  begin
    GenerateParametricToCartesianQuestion;
  end;

  // Differentiation
  if TheTopic = 'Differentiation' then
  begin
    // AToTheX
    if TheSubTopic = 'AToTheX' then
    begin
      Equation1 := GenerateEquation(false, false, false, false, false, false, false, false, false, true);
      Equation2 := DifferentiateAToTheX(Equation1);
      QQuestion := 'Differentiate ' + Equation1;
      QCorrectAnswer := Equation2;
    end
    // E To The X
    else if TheSubTopic = 'EToTheX' then
    begin
      Equation1 := GenerateEquation(false, false, false, false, false, false, false, false, true, false);
      Equation2 := DifferentiateEToTheX(Equation1);
      QQuestion := 'Differentiate ' + Equation1;
      QCorrectAnswer := Equation2;
    end;
  end;

  // Functions
  if TheTopic = 'Functions' then
  begin
    if TheSubTopic = 'Function Combinations' then
    begin
      Equation1 := GenerateEquation(true, true, true, true, false, false, false, false, false, false);
      Equation2 := GenerateEquation(true, true, false, false, false, false, false, false, false, false);
      RandomNum := Random(5) + 2;
      QQuestion := 'f(x)=' + Equation1 + ' and g(x)=' + Equation2 + '. Find gf(x) when x=' + IntToStr(RandomNum) + '.';
      QCorrectAnswer := FloatToStr(ValueOfFunction(Equation2, ValueOfFunction(Equation1, RandomNum)));
    end
    else if TheSubTopic = 'Domain and Range' then
    begin
      Equation1 := '\frac{' + GenerateEquation(true, true, false, false, false, false, false, false, false, false) + '}{' + GenerateEquation(true, true, false, false, false, false, false, false, false, false) + '}';
      QQuestion := 'f(x)=' + Equation1 + '. What value can x not be?';
      if Equation1[13] = '+' then QCorrectAnswer := '-' + Equation1[14]
      else QCorrectAnswer := Equation1[14];
    end;
  end;

  // Integration
  if TheTopic = 'Integration' then
  begin
    if TheSubTopic = 'Exponential' then
    begin
      Equation1 := GenerateEquation(false, false, false, false, false, false, false, false, true, false);
      Equation2 := IntegrationEToTheX(Equation1);
      QQuestion := 'Find \int' + Equation1;
      QCorrectAnswer := Equation2;
    end
    else if TheSubTopic = 'Reciprocal' then
    begin
      Equation1 := '\frac{1}{' + IntToStr(Random(8) + 2) + 'x+' + IntToStr(Random(8) + 2) + '}';
      Equation2 := IntegrationReciprocal(Equation1);
      QQuestion := 'Find \int' + Equation1;
      QCorrectAnswer := Equation2;
    end;

  end;

  // Numerical Methods
  if TheTopic = 'Numerical Methods' then
  begin
    if TheSubTopic = 'Iteration' then GenerateIterationQuestion;
  end;

  // Trigonometry
  if TheTopic = 'Trigonometry' then
  begin
    if TheSubTopic = 'Sec, Cosec, Cot' then
    begin
      Equation1 := FloatToStr((Random(300) + 1) / 100);
      Equation2 := GenerateEquation(false, false, false, false, false, false, true, false, false, false);
      Equation2 := StringReplace(Equation2, 'x', Equation1, [rfReplaceAll]);
      QQuestion := 'Find the value of ' + Equation2 + ' to 2 decimal places';
      if Equation2[2] = 's' then QCorrectAnswer := FormatFloat('#0.00', Sec(StrToFloat(Equation1)))
      else if Equation2[4] = 't' then QCorrectAnswer := FormatFloat('#0.00', Cot(StrToFloat(Equation1)))
      else if Equation2[4] = 's' then QCorrectAnswer := FormatFloat('#0.00', Csc(StrToFloat(Equation1)));
    end;
  end;

  // Vectors
  if TheTopic = 'Vectors' then
  begin
    // Magnitude
    if TheSubTopic = 'Magnitude' then
    begin
      Equation1 := GenerateVector;
      Equation2 := GetMagnitudeOfVector(Equation1);
      QQuestion := 'Find the magnitude of ' + Equation1 + '. Write your answer in exact form.';
      QCorrectAnswer := Equation2;
    end
    // Scalar Product
    else if TheSubTopic = 'ScalarProduct' then
    begin
      Equation1 := GenerateVector;
      Equation2 := GenerateVector;
      QQuestion := 'Find the angle between ' + Equation1 + ' and ' + Equation2 + ' to the nearest degree.';
      QCorrectAnswer := VectorAngleBetween(Equation1, Equation2);
    end
    // Lines
    else if TheSubTopic = 'Lines' then
    begin
      Equation1 := GenerateVector;
      Equation2 := GenerateVector;
      QQuestion := 'What vector connects the position vectors ' + Equation1 + ' and ' + Equation2 + '.';
      QCorrectAnswer := VectorThirdConnector(Equation1, Equation2);
    end;
  end;
end;

function TQuestion.GetTopic : String;
begin
  GetTopic := String(QTopic);
end;

function TQuestion.GetSubTopic : String;
begin
  GetSubTopic := String(QSubTopic);
end;

procedure TQuestion.SetTopic (NewTopic : String);
begin
  QTopic := AnsiString(NewTopic);
end;

procedure TQuestion.SetSubTopic (NewSubTopic : String);
begin
  QSubTopic := AnsiString(NewSubTopic);
end;

procedure TQuestion.SetQuestion (NewQuestion : String);
begin
  QQuestion := NewQuestion;
end;

procedure TQuestion.SetCorrectAnswer (NewCorrectAnswer : String);
begin
  QCorrectAnswer := NewCorrectAnswer
end;

// Clears the canvas - text/images drawn on screen
procedure ClearCanvas (Form : TForm);
begin
  with Form do Canvas.FillRect(Rect(0, 0, ClientWidth, ClientHeight));
end;

// Convert text into mathematical expression shown on screen
procedure ShowMathsText (Text : String; X, Y, GapWidth : Integer; Canvas : TCanvas);
var CurrentX, CurrentY, Count, XMovementHolder, XMovementHolder2 : Integer; RecursiveString : String;
begin
  // Initialise variables
  Count := 1;
  CurrentX := X;
  CurrentY := Y;
  Canvas.Font.Size := 10;

  // Write out each character individually
  while Count <= Text.Length do
  begin
    // ^ is indices marker, raise previous to a power
    if Text[Count] = '^' then
    begin
      // Increase to power
      CurrentY := CurrentY - (5 * GapWidth);
      Count := Count + 1;

      // { if indices is more than one character, must be closed
      if Text[Count] = '{' then
      begin
        Count := Count + 1;
        RecursiveString := '';
        repeat
          RecursiveString := RecursiveString + Text[Count];
          Count := Count + 1;
        until (Text[Count] = '}') or (Count > Text.Length);
          ShowMathsText(RecursiveString, CurrentX, CurrentY, GapWidth, Canvas);
          CurrentX := CurrentX + (GapWidth * RecursiveString.Length * 8);
      end

      // Otherwise just one character
      else
      begin
        Canvas.TextOut(CurrentX, CurrentY, Text[Count]);
        CurrentX := CurrentX + (8 * GapWidth);
      end;

      // Remove Y back to normal line
      CurrentY := CurrentY + (5 * GapWidth);
    end

    // _ lowers the text
    else if Text[Count] = '_' then
    begin
      // Lower
      CurrentY := CurrentY + (5 * GapWidth);
      Count := Count + 1;

      // { if more than one character, must be closed
      if Text[Count] = '{' then
      begin
        Count := Count + 1;
        RecursiveString := '';
        repeat
          RecursiveString := RecursiveString + Text[Count];
          Count := Count + 1;
        until (Text[Count] = '}') or (Count > Text.Length);
          ShowMathsText(RecursiveString, CurrentX, CurrentY, GapWidth, Canvas);
          CurrentX := CurrentX + (GapWidth * RecursiveString.Length * 8);
      end

      // Otherwise just one character
      else
      begin
        Canvas.TextOut(CurrentX, CurrentY, Text[Count]);
        CurrentX := CurrentX + (8 * GapWidth);
      end;

      // Remove Y back to normal line
      CurrentY := CurrentY - (5 * GapWidth);
    end

    // \ Functions
    else if Text[Count] = '\' then
    begin
      Count := Count + 1;
      // Plus or Minus Sign
      if (Text[Count] = 'p') and (Text[Count + 1] = 'm') then
      begin
        Canvas.TextOut(CurrentX, CurrentY, '±');
        CurrentX := CurrentX + (9 * GapWidth);
        Count := Count + 1;
      end
      // Minus or Plus Sign
      else if (Text[Count] = 'm') and (Text[Count + 1] = 'p') then
      begin
        Canvas.TextOut(CurrentX, CurrentY, '∓');
        CurrentX := CurrentX + (9 * GapWidth);
        Count := Count + 1;
      end
      // Less Than or Equal To Sign
      else if (Text[Count] = 'l') and (Text[Count + 1] = 'e') and (Text[Count + 2] = 'q') then
      begin
        Canvas.TextOut(CurrentX, CurrentY, '≤');
        CurrentX := CurrentX + (9 * GapWidth);
        Count := Count + 2;
      end
      // Greater Than or Equal To Sign
      else if (Text[Count] = 'g') and (Text[Count + 1] = 'e') and (Text[Count + 2] = 'q') then
      begin
        Canvas.TextOut(CurrentX, CurrentY, '≥');
        CurrentX := CurrentX + (9 * GapWidth);
        Count := Count + 2;
      end
      // Infinity Sign
      else if (Text[Count] = 'i') and (Text[Count + 1] = 'n') and (Text[Count + 2] = 'f') then
      begin
        Canvas.TextOut(CurrentX, CurrentY, '∞');
        CurrentX := CurrentX + (12 * GapWidth);
        Count := Count + 2;
      end
      // Theta Sign
      else if (Text[Count] = 't') and (Text[Count + 1] = 'h') and (Text[Count + 2] = 'e') and (Text[Count + 3] = 't') and (Text[Count + 4] = 'a') then
      begin
        Canvas.TextOut(CurrentX, CurrentY, 'Θ');
        CurrentX := CurrentX + (12 * GapWidth);
        Count := Count + 4;
      end
      // Trig - Sin
      else if (Text[Count] = 's') and (Text[Count + 1] = 'i') and (Text[Count + 2] = 'n') then
      begin
        Canvas.TextOut(CurrentX, CurrentY, 'Sin');
        CurrentX := CurrentX + (21 * GapWidth);
        Count := Count + 2;
      end
      // Trig - Cos
      else if (Text[Count] = 'c') and (Text[Count + 1] = 'o') and (Text[Count + 2] = 's')
      and (Text[Count + 3] <> 'e') then
      begin
        Canvas.TextOut(CurrentX, CurrentY, 'Cos');
        CurrentX := CurrentX + (24 * GapWidth);
        Count := Count + 2;
      end
      // Trig - Tan
      else if (Text[Count] = 't') and (Text[Count + 1] = 'a') and (Text[Count + 2] = 'n') then
      begin
        Canvas.TextOut(CurrentX, CurrentY, 'Tan');
        CurrentX := CurrentX + (24 * GapWidth);
        Count := Count + 2;
      end
      // Trig - Arcsin
      else if (Text[Count] = 'a') and (Text[Count + 1] = 'r') and (Text[Count + 2] = 'c')
      and (Text[Count + 3] = 's') and (Text[Count + 4] = 'i') and (Text[Count + 5] = 'n') then
      begin
        Canvas.TextOut(CurrentX, CurrentY, 'Arcsin');
        CurrentX := CurrentX + (38 * GapWidth);
        Count := Count + 5;
      end
      // Trig - Arccos
      else if (Text[Count] = 'a') and (Text[Count + 1] = 'r') and (Text[Count + 2] = 'c')
      and (Text[Count + 3] = 'c') and (Text[Count + 4] = 'o') and (Text[Count + 5] = 's') then
      begin
        Canvas.TextOut(CurrentX, CurrentY, 'Arccos');
        CurrentX := CurrentX + (40 * GapWidth);
        Count := Count + 5;
      end
      // Trig - Arctan
      else if (Text[Count] = 'a') and (Text[Count + 1] = 'r') and (Text[Count + 2] = 'c')
      and (Text[Count + 3] = 't') and (Text[Count + 4] = 'a') and (Text[Count + 5] = 'n') then
      begin
        Canvas.TextOut(CurrentX, CurrentY, 'Arctan');
        CurrentX := CurrentX + (38 * GapWidth);
        Count := Count + 5;
      end
      // Trig - Cot
      else if (Text[Count] = 'c') and (Text[Count + 1] = 'o') and (Text[Count + 2] = 't') then
      begin
        Canvas.TextOut(CurrentX, CurrentY, 'Cot');
        CurrentX := CurrentX + (21 * GapWidth);
        Count := Count + 2;
      end
      // Trig - Sec
      else if (Text[Count] = 's') and (Text[Count + 1] = 'e') and (Text[Count + 2] = 'c') then
      begin
        Canvas.TextOut(CurrentX, CurrentY, 'Sec');
        CurrentX := CurrentX + (24 * GapWidth);
        Count := Count + 2;
      end
      // Trig - Cosec
      else if (Text[Count] = 'c') and (Text[Count + 1] = 'o') and (Text[Count + 2] = 's')
      and (Text[Count + 3] = 'e') and (Text[Count + 4] = 'c') then
      begin
        Canvas.TextOut(CurrentX, CurrentY, 'Cosec');
        CurrentX := CurrentX + (38 * GapWidth);
        Count := Count + 4;
      end
      // Fractions ><><><><><><><><><><><><><><><><><><><><><><><><><><><><
      else if (Text[Count] = 'f') and (Text[Count + 1] = 'r') and (Text[Count + 2] = 'a')
      and (Text[Count + 3] = 'c') and (Text[Count + 4] = '{') then
      begin
        // Write both top and bottom of the fraction
        XMovementHolder := CurrentX;
        Count := Count + 5;
        RecursiveString := '';
        repeat
          RecursiveString := RecursiveString + Text[Count];
          Count := Count + 1;
        until (Text[Count] = '}') or (Count > Length(Text));
        ShowMathsText(RecursiveString, CurrentX, CurrentY - (8 * GapWidth), GapWidth, Canvas);
        XMovementHolder2 := Length(RecursiveString) * 8 * GapWidth;
        Count := Count + 2;
        RecursiveString := '';
        repeat
          RecursiveString := RecursiveString + Text[Count];
          Count := Count + 1;
        until (Text[Count] = '}') or (Count > Length(Text));
        ShowMathsText(RecursiveString, CurrentX, CurrentY + (8 * GapWidth), GapWidth, Canvas);
        if Length(RecursiveString) * 8 * GapWidth > XMovementHolder2 then CurrentX := CurrentX + (Length(RecursiveString) * 8 * GapWidth)
        else CurrentX := CurrentX + XMovementHolder2;

        // Draw fraction line
        Canvas.MoveTo(XMovementHolder, CurrentY + (8 * GapWidth));
        Canvas.LineTo(CurrentX, CurrentY + (8 * GapWidth));
        CurrentX := CurrentX + (3 * GapWidth);
      end
      // Binomials - binom{}{}
      else if (Text[Count] = 'b') and (Text[Count + 1] = 'i') and (Text[Count + 2] = 'n')
      and (Text[Count + 3] = 'o') and (Text[Count + 4] = 'm') and (Text[Count + 5] = '{') then
      begin
        // Open bracket
        Canvas.Font.Size := 18;
        Canvas.TextOut(CurrentX, CurrentY - 8, '(');
        CurrentX := CurrentX + (10 * GapWidth);
        Canvas.Font.Size := 10;

        // Write both top and bottom of binomial, then work out where to place close bracket
        Count := Count + 6;
        RecursiveString := '';
        repeat
          RecursiveString := RecursiveString + Text[Count];
          Count := Count + 1;
        until (Text[Count] = '}') or (Count > Length(Text));
        ShowMathsText(RecursiveString, CurrentX, CurrentY - (8 * GapWidth), GapWidth, Canvas);
        XMovementHolder := Length(RecursiveString) * 8 * GapWidth;
        Count := Count + 2;
        RecursiveString := '';
        repeat
          RecursiveString := RecursiveString + Text[Count];
          Count := Count + 1;
        until (Text[Count] = '}') or (Count > Length(Text));
        ShowMathsText(RecursiveString, CurrentX, CurrentY + (8 * GapWidth), GapWidth, Canvas);
        if Length(RecursiveString) * 8 * GapWidth > XMovementHolder then CurrentX := CurrentX + (Length(RecursiveString) * 8 * GapWidth)
        else CurrentX := CurrentX + XMovementHolder;

        // Close bracket
        Canvas.Font.Size := 18;
        Canvas.TextOut(CurrentX, CurrentY - 8, ')');
        CurrentX := CurrentX + (10 * GapWidth);
        Canvas.Font.Size := 10;
      end
      // Square Roots - sqrt{}
      else if (Text[Count] = 's') and (Text[Count + 1] = 'q') and (Text[Count + 2] = 'r')
      and (Text[Count + 3] = 't') and (Text[Count + 4] = '{') then
      begin
        Count := Count + 5;
        Canvas.Font.Size := 15;
        Canvas.TextOut(CurrentX, CurrentY - 6, '√');
        Canvas.Font.Size := 10;
        CurrentX := CurrentX + (14 * GapWidth);
        XMovementHolder := CurrentX;
        RecursiveString := '';
        repeat
          RecursiveString := RecursiveString + Text[Count];
          Count := Count + 1;
        until (Text[Count] = '}') or (Count > Length(Text));
        ShowMathsText(RecursiveString, CurrentX, CurrentY, GapWidth, Canvas);
        CurrentX := CurrentX + (Length(RecursiveString) * 8 * GapWidth);
        Canvas.MoveTo(XMovementHolder, CurrentY - (5 * GapWidth));
        Canvas.LineTo(CurrentX, CurrentY - (5 * GapWidth));
      end
      // Sum (Sigma) - sum{}{}
      else if (Text[Count] = 's') and (Text[Count + 1] = 'u') and (Text[Count + 2] = 'm')
      and (Text[Count + 3] = '{') then
      begin
        // Write out top and bottom of sigma, then work out where to put sigma
        Count := Count + 4;
        RecursiveString := '';
        repeat
          RecursiveString := RecursiveString + Text[Count];
          Count := Count + 1;
        until (Text[Count] = '}') or (Count > Length(Text));
        ShowMathsText(RecursiveString, CurrentX, CurrentY - (8 * GapWidth), GapWidth, Canvas);
        XMovementHolder := Length(RecursiveString) * 8 * GapWidth;
        Count := Count + 2;
        RecursiveString := '';
        repeat
          RecursiveString := RecursiveString + Text[Count];
          Count := Count + 1;
        until (Text[Count] = '}') or (Count > Length(Text));
        ShowMathsText(RecursiveString, CurrentX, CurrentY + (8 * GapWidth), GapWidth, Canvas);
        if Length(RecursiveString) * 8 * GapWidth > XMovementHolder then CurrentX := CurrentX + (Length(RecursiveString) * 8 * GapWidth)
        else CurrentX := CurrentX + XMovementHolder;

        // Sigma
        Canvas.Font.Size := 20;
        Canvas.TextOut(CurrentX, CurrentY - (8 * GapWidth), 'Σ');
        Canvas.Font.Size := 10;
        CurrentX := CurrentX + (16 * GapWidth);
      end
      // Definite Integral - int{}{}
      else if (Text[Count] = 'i') and (Text[Count + 1] = 'n') and (Text[Count + 2] = 't')
      and (Text[Count + 3] = '{') then
      begin
        // Top and bottom of integral
        Count := Count + 4;
        RecursiveString := '';
        repeat
          RecursiveString := RecursiveString + Text[Count];
          Count := Count + 1;
        until (Text[Count] = '}') or (Count > Length(Text));
        ShowMathsText(RecursiveString, CurrentX, CurrentY - (8 * GapWidth), GapWidth, Canvas);
        XMovementHolder := Length(RecursiveString) * 8 * GapWidth;
        Count := Count + 2;
        RecursiveString := '';
        repeat
          RecursiveString := RecursiveString + Text[Count];
          Count := Count + 1;
        until (Text[Count] = '}') or (Count > Length(Text));
        ShowMathsText(RecursiveString, CurrentX, CurrentY + (8 * GapWidth), GapWidth, Canvas);
        if Length(RecursiveString) * 8 * GapWidth > XMovementHolder then CurrentX := CurrentX + (Length(RecursiveString) * 8 * GapWidth)
        else CurrentX := CurrentX + XMovementHolder;

        // Integral sign
        Canvas.Font.Size := 15;
        Canvas.TextOut(CurrentX, CurrentY - (5 * GapWidth), '∫');
        Canvas.Font.Size := 10;
        CurrentX := CurrentX + (12 * GapWidth);
      end
      // Integral Sign - int
      else if (Text[Count] = 'i') and (Text[Count + 1] = 'n') and (Text[Count + 2] = 't') then
      begin
        Canvas.Font.Size := 15;
        Canvas.TextOut(CurrentX, CurrentY - (5 * GapWidth), '∫');
        Canvas.Font.Size := 10;
        CurrentX := CurrentX + (12 * GapWidth);
        Count := Count + 2;
      end;
    end

    // Otherwise just a normal number/letter
    else
    begin
      Canvas.TextOut(CurrentX, CurrentY, Text[Count]);
      // Amount that X moves along depends on size on character on display
      if (Text[Count] = 'i') or (Text[Count] = 'l') or (Text[Count] = 't') or (Text[Count] = '.') or (Text[Count] = ',') then CurrentX := CurrentX + (4 * GapWidth)
      else if (Text[Count] = 'f') or (Text[Count] = 'j') or (Text[Count] = 'r') then CurrentX := CurrentX + (6 * GapWidth)
      else if (Text[Count] = 'I') or (Text[Count] = 'J') then CurrentX := CurrentX + (7 * GapWidth)
      else if (Text[Count] = 'u') or (Text[Count] = 'D') or (Text[Count] = 'G') or (Text[Count] = 'H') or (Text[Count] = 'U') or (Text[Count] = 'Y') then CurrentX := CurrentX + (9 * GapWidth)
      else if (Text[Count] = 'A') or (Text[Count] = 'N') or (Text[Count] = 'Q') or (Text[Count] = 'S') or (Text[Count] = 'V') or (Text[Count] = 'X') then CurrentX := CurrentX + (10 * GapWidth)
      else if (Text[Count] = 'm') or (Text[Count] = 'w') then CurrentX := CurrentX + (13 * GapWidth)
      else if (Text[Count] = 'M') or (Text[Count] = 'W') then CurrentX := CurrentX + (14 * GapWidth)
      else CurrentX := CurrentX + (8 * GapWidth);
    end;

    // Move onto next character
    Count := Count + 1;
  end;
end;

end.
