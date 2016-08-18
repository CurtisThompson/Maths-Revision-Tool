unit TopicSelectForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, QuestionClass, QuestionForm, Printers,
  SavedQuestionClass, System.UITypes;

type
  TTopicSelect = class(TForm)
    cboxTopicList: TComboBox;
    btnAddTopic: TButton;
    btnGenerateQuestions: TButton;
    edtNumOfQuestions: TEdit;
    lblAlgebra: TLabel;
    lblCoordinate: TLabel;
    lblDifferentiation: TLabel;
    lblFunctions: TLabel;
    lblIntegration: TLabel;
    lblNumericalM: TLabel;
    lblTrigonometry: TLabel;
    lblVectors: TLabel;
    lblTopic: TLabel;
    lblNumQ: TLabel;
    lblDelete: TLabel;
    lblQ1: TLabel;
    lblQ2: TLabel;
    lblQ3: TLabel;
    lblQ4: TLabel;
    lblQ5: TLabel;
    lblQ6: TLabel;
    lblQ7: TLabel;
    lblQ8: TLabel;
    shpTableLine: TShape;
    btnQ1: TButton;
    btnQ2: TButton;
    btnQ3: TButton;
    btnQ4: TButton;
    btnQ5: TButton;
    btnQ6: TButton;
    btnQ7: TButton;
    btnQ8: TButton;
    btnPrintQuestions: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAddTopicClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnQ1Click(Sender: TObject);
    procedure btnQ2Click(Sender: TObject);
    procedure btnQ3Click(Sender: TObject);
    procedure btnQ4Click(Sender: TObject);
    procedure btnQ5Click(Sender: TObject);
    procedure btnQ6Click(Sender: TObject);
    procedure btnQ7Click(Sender: TObject);
    procedure btnQ8Click(Sender: TObject);
    procedure btnGenerateQuestionsClick(Sender: TObject);
    procedure btnPrintQuestionsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TopicSelect: TTopicSelect;
  TotalNumOfQuestions : Integer;
  NumOfQuestions : Array [1..8] of Integer;
  QuestionList : Array [1..20] of TQuestion;

implementation

uses MenuForm;

procedure DeleteQuestionChoice (var ResetInt : Integer; TheLabel : TLabel; TheButton : TButton);
begin
  ResetInt := 0;
  TheLabel.Visible := false;
  TheButton.Visible := false;
end;

procedure ShowQuestionChoice (TheLabel : TLabel; TheButton : TButton);
begin
  TheLabel.Visible := true;
  TheButton.Visible := true;
end;

function SumIntegerArray (IntegerArray : Array of Integer) : Integer;
var Count, CountingSum : Integer;
begin
  CountingSum := 0;
  for Count := Low(IntegerArray) to High(IntegerArray) do
    CountingSum := CountingSum + IntegerArray[Count];
  Result := CountingSum;
end;

procedure GenerateQuestions;
var QuestionsSoFar, Count, QuestionsToAdd, QuestionSubTopic : Integer; AddedSuccessful : Boolean;
begin
  // Generate questions for each category, if error, stop then retry
  repeat
    try
      AddedSuccessful := true;
      QuestionsSoFar := 0;

      QuestionsToAdd := NumOfQuestions[1];
      if QuestionsToAdd > 0 then
      begin
        for Count := 1 to QuestionsToAdd do
        begin
          QuestionsSoFar := QuestionsSoFar + 1;
          QuestionSubTopic := Random(3);
          if QuestionSubTopic = 0 then QuestionList[QuestionsSoFar] := TQuestion.Create('Algebra and Series', 'Algebraic Fractions');
          if QuestionSubTopic = 1 then QuestionList[QuestionsSoFar] := TQuestion.Create('Algebra and Series', 'Partial Fractions');
          if QuestionSubTopic = 2 then QuestionList[QuestionsSoFar] := TQuestion.Create('Algebra and Series', 'Binomial Expansion');
        end;
      end;

      // Coordinate Geometry questions
      QuestionsToAdd := NumOfQuestions[2];
      if QuestionsToAdd > 0 then
      begin
        for Count := 1 to QuestionsToAdd do
        begin
          QuestionsSoFar := QuestionsSoFar + 1;
          QuestionSubTopic := Random(1);
          if QuestionSubTopic = 0 then QuestionList[QuestionsSoFar] := TQuestion.Create('Coordinate Geometry', 'Parametric To Cartesian');
        end;
      end;

      // Differentiation questions
      QuestionsToAdd := NumOfQuestions[3];
      if QuestionsToAdd > 0 then
      begin
        for Count := 1 to QuestionsToAdd do
        begin
          QuestionsSoFar := QuestionsSoFar + 1;
          QuestionSubTopic := Random(2);
          if QuestionSubTopic = 0 then QuestionList[QuestionsSoFar] := TQuestion.Create('Differentiation', 'AToTheX')
          else if QuestionSubTopic = 1 then QuestionList[QuestionsSoFar] := TQuestion.Create('Differentiation', 'EToTheX');
        end;
      end;

      // Functions
      QuestionsToAdd := NumOfQuestions[4];
      if QuestionsToAdd > 0 then
      begin
        for Count := 1 to QuestionsToAdd do
        begin
          QuestionsSoFar := QuestionsSoFar + 1;
          QuestionSubTopic := Random(2);
          if QuestionSubTopic = 0 then QuestionList[QuestionsSoFar] := TQuestion.Create('Functions', 'Function Combinations');
          if QuestionSubTopic = 1 then QuestionList[QuestionsSoFar] := TQuestion.Create('Functions', 'Domain and Range');
        end;
      end;

      // Integration
      QuestionsToAdd := NumOfQuestions[5];
      if QuestionsToAdd > 0 then
      begin
        for Count := 1 to QuestionsToAdd do
        begin
          QuestionsSoFar := QuestionsSoFar + 1;
          QuestionSubTopic := Random(2);
          if QuestionSubTopic = 0 then QuestionList[QuestionsSoFar] := TQuestion.Create('Integration', 'Exponential');
          if QuestionSubTopic = 1 then QuestionList[QuestionsSoFar] := TQuestion.Create('Integration', 'Reciprocal');
        end;
      end;

      // Numerical Methods
      QuestionsToAdd := NumOfQuestions[6];
      if QuestionsToAdd > 0 then
      begin
        for Count := 1 to QuestionsToAdd do
        begin
          QuestionsSoFar := QuestionsSoFar + 1;
          QuestionSubTopic := Random(1);
          if QuestionSubTopic = 0 then QuestionList[QuestionsSoFar] := TQuestion.Create('Numerical Methods', 'Iteration');
        end;
      end;

      // Trigonometry
      QuestionsToAdd := NumOfQuestions[7];
      if QuestionsToAdd > 0 then
      begin
        for Count := 1 to QuestionsToAdd do
        begin
          QuestionsSoFar := QuestionsSoFar + 1;
          QuestionSubTopic := 0;
          if QuestionSubTopic = 0 then QuestionList[QuestionsSoFar] := TQuestion.Create('Trigonometry', 'Sec, Cosec, Cot');
        end;
      end;

      // Vector questions
      QuestionsToAdd := NumOfQuestions[8];
      if QuestionsToAdd > 0 then
      begin
        for Count := 1 to QuestionsToAdd do
        begin
          QuestionsSoFar := QuestionsSoFar + 1;
          QuestionSubTopic := Random(3);
          if QuestionSubTopic = 0 then QuestionList[QuestionsSoFar] := TQuestion.Create('Vectors', 'Magnitude')
          else if QuestionSubTopic = 1 then QuestionList[QuestionsSoFar] := TQuestion.Create('Vectors', 'ScalarProduct')
          else if QuestionSubTopic = 2 then QuestionList[QuestionsSoFar] := TQuestion.Create('Vectors', 'Lines');
        end;
      end;
    except
      AddedSuccessful := false;
    end;
  until AddedSuccessful;
end;

{$R *.dfm}

procedure TTopicSelect.btnAddTopicClick(Sender: TObject);
begin
  // If can add question (topic chosen and will result in 20 or less questions)
  if (cboxTopicList.ItemIndex > -1) and (cboxTopicList.ItemIndex < 8)
  and (TotalNumOfQuestions + StrToInt(edtNumOfQuestions.Text) <= 20) then
  begin
    // Add questions to correct topic
    NumOfQuestions[cboxTopicList.ItemIndex + 1] := NumOfQuestions[cboxTopicList.ItemIndex + 1] + StrToInt(edtNumOfQuestions.Text);

    // Change number of questions shown to user for each caption
    lblQ1.Caption := IntToStr(NumOfQuestions[1]);
    lblQ2.Caption := IntToStr(NumOfQuestions[2]);
    lblQ3.Caption := IntToStr(NumOfQuestions[3]);
    lblQ4.Caption := IntToStr(NumOfQuestions[4]);
    lblQ5.Caption := IntToStr(NumOfQuestions[5]);
    lblQ6.Caption := IntToStr(NumOfQuestions[6]);
    lblQ7.Caption := IntToStr(NumOfQuestions[7]);
    lblQ8.Caption := IntToStr(NumOfQuestions[8]);

    // Show/hide topic 1 labels depending on whether any questions (number) for it
    if NumOfQuestions[1] <> 0 then ShowQuestionChoice(lblQ1, btnQ1);
    if NumOfQuestions[2] <> 0 then ShowQuestionChoice(lblQ2, btnQ2);
    if NumOfQuestions[3] <> 0 then ShowQuestionChoice(lblQ3, btnQ3);
    if NumOfQuestions[4] <> 0 then ShowQuestionChoice(lblQ4, btnQ4);
    if NumOfQuestions[5] <> 0 then ShowQuestionChoice(lblQ5, btnQ5);
    if NumOfQuestions[6] <> 0 then ShowQuestionChoice(lblQ6, btnQ6);
    if NumOfQuestions[7] <> 0 then ShowQuestionChoice(lblQ7, btnQ7);
    if NumOfQuestions[8] <> 0 then ShowQuestionChoice(lblQ8, btnQ8);

    // Recalculate total questions
    TotalNumOfQuestions := SumIntegerArray(NumOfQuestions);
  end
  // Dont add questions as cant have more than 20 questions
  else ShowMessage('Could not add topic. Make sure to select a topic and there can be no more than 20 questions.');
end;


procedure TTopicSelect.btnGenerateQuestionsClick(Sender: TObject);
var Count, TotalNumOfQuestions : Integer;
begin
  GenerateQuestions;
  TotalNumOfQuestions := SumIntegerArray(NumOfQuestions);

  // Send all questions to the question form if they have been generated
  if TotalNumOfQuestions > 0 then
  begin
    TheQuestionForm.NumOfQuestions := TotalNumOfQuestions;
    for Count := 1 to 20 do
      TheQuestionForm.QuestionList[Count] := QuestionList[Count];
    TheQuestionForm.Show();
    TopicSelect.Hide;
  end;
end;

procedure TTopicSelect.btnPrintQuestionsClick(Sender: TObject);
var PrinterDialog : TPrintDialog; Count, ShouldQuestionsSave, XSpacing : Integer; QuestionFile : TextFile; QuestionToSave : TSavedQuestion;
begin
  // Generate questions
  GenerateQuestions;
  TotalNumOfQuestions := SumIntegerArray(NumOfQuestions);

  // If questions have been generated, allow the user to choose to print
  if TotalNumOfQuestions > 0 then
  begin
    PrinterDialog := TPrintDialog.Create(TopicSelect);
    PrinterDialog.MinPage := 1;
    PrinterDialog.MaxPage := 1;
    PrinterDialog.ToPage  := 1;
    PrinterDialog.Options := [poPageNums];

    // If the user selects to print in the dialog, print questions
    if PrinterDialog.Execute then
    begin
      Printer.Orientation := poPortrait;
      Printer.Title := 'Maths Revision Tool Print-Out';
      Printer.Copies := PrinterDialog.Copies;
      Printer.BeginDoc;

      XSpacing := Round(GetDeviceCaps(Printer.Canvas.Handle, LOGPIXELSX) / 100);
      if XSpacing = 0 then XSpacing := 1;

      ShowMathsText('Maths Revision Tool - A2 Maths Practice Questions', 20 * XSpacing, 100, XSpacing, Printer.Canvas);
      ShowMathsText('By Curtis Thompson', 1500 + (500 * XSpacing), 100, XSpacing, Printer.Canvas);
      for Count := 1 to TotalNumOfQuestions do
      begin
        ShowMathsText(IntToStr(Count) + ') ' + QuestionList[Count].Question, 20 * XSpacing, (Count * 200) + 200, XSpacing, Printer.Canvas);
      end;
      Printer.EndDoc;
    end;

    // Ask whether questions should also be saved
    ShouldQuestionsSave := MessageDlg('Would you also like to save the printed questions?', mtCustom, mbYesNo, 0);
    if ShouldQuestionsSave = mrYes then
    begin
      AssignFile(QuestionFile, 'SavedQuestions.AMF');
      if FileExists('SavedQuestions.AMF') then Append(QuestionFile)
      else Rewrite(QuestionFile);

      for Count := 1 to TotalNumOfQuestions do
      begin
        // Get question into save format
        QuestionToSave := TSavedQuestion.Create('a','a');
        QuestionToSave.Topic := QuestionList[Count].Topic;
        QuestionToSave.SubTopic := QuestionList[Count].SubTopic;
        QuestionToSave.Question := QuestionList[Count].Question;
        QuestionToSave.CorrectAnswer := QuestionList[Count].CorrectAnswer;
        QuestionToSave.SetUser(TheMenu.LoggedInUser);
        QuestionToSave.SetSaveTime(Now);

        // Save to file
        Writeln(QuestionFile, QuestionToSave.Topic + '|' + QuestionToSave.SubTopic + '|' + QuestionToSave.Question + '|' + QuestionToSave.CorrectAnswer + '|' + QuestionToSave.GetUser + '|' + DateToStr(QuestionToSave.GetSaveTime));
        QuestionToSave.Free;
      end;

      CloseFile(QuestionFile);
    end;

    ShowMessage('Returning to menu.');
    Close;
  end;
end;

// Remove topic 1 questions and hide labels
procedure TTopicSelect.btnQ1Click(Sender: TObject);
begin
  DeleteQuestionChoice(NumOfQuestions[1], lblQ1, btnQ1);
  TotalNumOfQuestions := SumIntegerArray(NumOfQuestions);
end;

// Question 2
procedure TTopicSelect.btnQ2Click(Sender: TObject);
begin
  DeleteQuestionChoice(NumOfQuestions[2], lblQ2, btnQ2);
  TotalNumOfQuestions := SumIntegerArray(NumOfQuestions);
end;

// Question 3
procedure TTopicSelect.btnQ3Click(Sender: TObject);
begin
  DeleteQuestionChoice(NumOfQuestions[3], lblQ3, btnQ3);
  TotalNumOfQuestions := SumIntegerArray(NumOfQuestions);
end;

// Question 4
procedure TTopicSelect.btnQ4Click(Sender: TObject);
begin
  DeleteQuestionChoice(NumOfQuestions[4], lblQ4, btnQ4);
  TotalNumOfQuestions := SumIntegerArray(NumOfQuestions);
end;

// Question 5
procedure TTopicSelect.btnQ5Click(Sender: TObject);
begin
  DeleteQuestionChoice(NumOfQuestions[5], lblQ5, btnQ5);
  TotalNumOfQuestions := SumIntegerArray(NumOfQuestions);
end;

// Question 6
procedure TTopicSelect.btnQ6Click(Sender: TObject);
begin
  DeleteQuestionChoice(NumOfQuestions[6], lblQ6, btnQ6);
  TotalNumOfQuestions := SumIntegerArray(NumOfQuestions);
end;

// Question 7
procedure TTopicSelect.btnQ7Click(Sender: TObject);
begin
  DeleteQuestionChoice(NumOfQuestions[7], lblQ7, btnQ7);
  TotalNumOfQuestions := SumIntegerArray(NumOfQuestions);
end;

// Question 8
procedure TTopicSelect.btnQ8Click(Sender: TObject);
begin
  DeleteQuestionChoice(NumOfQuestions[8], lblQ8, btnQ8);
  TotalNumOfQuestions := SumIntegerArray(NumOfQuestions);
end;

procedure TTopicSelect.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Show menu when form closed
  TheMenu.Show;
end;

procedure TTopicSelect.FormShow(Sender: TObject);
begin
  // Resets variables and labels when the form is shown
  TotalNumOfQuestions := 0;
  NumOfQuestions[1] := 0;
  NumOfQuestions[2] := 0;
  NumOfQuestions[3] := 0;
  NumOfQuestions[4] := 0;
  NumOfQuestions[5] := 0;
  NumOfQuestions[6] := 0;
  NumOfQuestions[7] := 0;
  NumOfQuestions[8] := 0;
  lblQ1.Visible := false;
  lblQ2.Visible := false;
  lblQ3.Visible := false;
  lblQ4.Visible := false;
  lblQ5.Visible := false;
  lblQ6.Visible := false;
  lblQ7.Visible := false;
  lblQ8.Visible := false;
  btnQ1.Visible := false;
  btnQ2.Visible := false;
  btnQ3.Visible := false;
  btnQ4.Visible := false;
  btnQ5.Visible := false;
  btnQ6.Visible := false;
  btnQ7.Visible := false;
  btnQ8.Visible := false;
end;

end.
