unit SavedQuestionsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, SavedQuestionClass, QuestionClass,
  QuestionForm;

type
  TSavedQuestions = class(TForm)
    memSavedQuestionsList: TMemo;
    btnPreviousQuestion: TButton;
    btnNextQuestion: TButton;
    btnDeleteQuestion: TButton;
    btnAddQuestion: TButton;
    btnRemoveQuestions: TButton;
    btnRevise: TButton;
    tmrStartDelay: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnPreviousQuestionClick(Sender: TObject);
    procedure btnNextQuestionClick(Sender: TObject);
    procedure btnAddQuestionClick(Sender: TObject);
    procedure btnRemoveQuestionsClick(Sender: TObject);
    procedure btnReviseClick(Sender: TObject);
    procedure btnDeleteQuestionClick(Sender: TObject);
    procedure tmrStartDelayTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SavedQuestions: TSavedQuestions;
  AllQuestionsList : Array of TSavedQuestion;
  UserQuestionsList : Array of TSavedQuestion;
  ChosenQuestionList : Array [1..20] of TSavedQuestion;
  ChosenQuestionNumbers : Array [1..20] of Integer;
  CurrentShownQuestion, NumOfChosenQuestions : Integer;

implementation
uses MenuForm;

procedure ChangeFormForNoQuestions (PreviousButton, NextButton, DeleteButton, AddButton, RemoveButton, ReviseButton : TButton; TheCanvas : TCanvas);
begin
  PreviousButton.Enabled := false;
  NextButton.Enabled := false;
  DeleteButton.Enabled := false;
  AddButton.Enabled := false;
  RemoveButton.Enabled := false;
  ReviseButton.Enabled := false;
  ShowMathsText('No saved questions have been found for ' + TheMenu.LoggedInUser + '.', 10, 35, 1, TheCanvas);
  ShowMathsText('You must save a question to access this area.', 10, 55, 1, TheCanvas);
end;

// Search for question in array, delete it, then move each one down
procedure DeleteQuestionFromArray (var QuestionList : Array of TSavedQuestion; QuestionToDelete : TSavedQuestion);
var Count, Count2 : Integer; QuestionDeleted : Boolean;
begin
  QuestionDeleted := false;
  Count := 0;
  repeat
    if Count > High(QuestionList) then QuestionDeleted := true
    else
    begin
      if (QuestionList[Count].Topic = QuestionToDelete.Topic) and (QuestionList[Count].SubTopic = QuestionToDelete.SubTopic)
      and (QuestionList[Count].Question = QuestionToDelete.Question) and (QuestionList[Count].CorrectAnswer = QuestionToDelete.CorrectAnswer)
      and (QuestionList[Count].GetSaveTime = QuestionToDelete.GetSaveTime) and (QuestionList[Count].GetUser = QuestionToDelete.GetUser) then
      begin
        QuestionDeleted := true;
        for Count2 := Count to High(QuestionList) - 1 do
        begin
          QuestionList[Count2].Topic := QuestionList[Count2 + 1].Topic;
          QuestionList[Count2].SubTopic := QuestionList[Count2 + 1].SubTopic;
          QuestionList[Count2].Question := QuestionList[Count2 + 1].Question;
          QuestionList[Count2].CorrectAnswer := QuestionList[Count2 + 1].CorrectAnswer;
          QuestionList[Count2].SetSaveTime(QuestionList[Count2 + 1].GetSaveTime);
          QuestionList[Count2].SetUser(QuestionList[Count2 + 1].GetUser);
        end;
      end;
    end;
    Count := Count + 1;
  until QuestionDeleted;
end;

procedure SortQuestionsByDate (var QuestionList : Array of TSavedQuestion);
var Passes, Count : Integer; Holder : TSavedQuestion;
begin
  // Bubble sort - repeat the pass until no passes
  repeat
    Passes := 0;
    for Count := Low(QuestionList) to High(QuestionList) - 1 do
    begin
      if QuestionList[Count].GetSaveTime < QuestionList[Count + 1].GetSaveTime then
      begin
        Holder := QuestionList[Count];
        QuestionList[Count] := QuestionList[Count + 1];
        QuestionList[Count + 1] := Holder;
        Passes := Passes + 1;
      end;
    end;
  until Passes = 0;
end;

procedure ShowQuestion(TheCanvas : TCanvas; TheQuestion : TQuestion; QuestionNumber : Integer);
begin
  ClearCanvas(SavedQuestions);
  ShowMathsText(IntToStr(QuestionNumber) + ') ' + TheQuestion.Topic, 10, 5, 1, TheCanvas);
  ShowMathsText(TheQuestion.Question, 10, 35, 1, TheCanvas);
end;

{$R *.dfm}

procedure TSavedQuestions.btnAddQuestionClick(Sender: TObject);
var Count : Integer; CanAddQuestion : Boolean;
begin
  CanAddQuestion := true;

  // Check if question can be added (if not already added)
  Count := 1;
  repeat
    if CurrentShownQuestion = ChosenQuestionNumbers[Count] then CanAddQuestion := false;
    Count := Count + 1;
    if Count > 20 then CanAddQuestion := false;
  until (CanAddQuestion = false) or (ChosenQuestionNumbers[Count] = -1);


  // If addable, then add to list of questions
  if CanAddQuestion then
  begin
    ChosenQuestionList[Count] := UserQuestionsList[CurrentShownQuestion];
    ChosenQuestionNumbers[Count] := CurrentShownQuestion;
    NumOfChosenQuestions := NumOfChosenQuestions + 1;

    // Add question to display of questions
    memSavedQuestionsList.Lines.Add('Question ' + IntToStr(CurrentShownQuestion + 1) + ' - ' + UserQuestionsList[CurrentShownQuestion].Topic);
  end;
end;

procedure TSavedQuestions.btnDeleteQuestionClick(Sender: TObject);
begin
  // Delete question
  DeleteQuestionFromArray(AllQuestionsList, UserQuestionsList[CurrentShownQuestion]);
  SetLength(AllQuestionsList, Length(AllQuestionsList) - 1);
  DeleteQuestionFromArray(UserQuestionsList, UserQuestionsList[CurrentShownQuestion]);
  SetLength(UserQuestionsList, Length(UserQuestionsList) - 1);

  // Show the previous question if there is one
  if Length(UserQuestionsList) <> 0 then
  begin
    CurrentShownQuestion := CurrentShownQuestion - 1;
    if CurrentShownQuestion < 0 then
      CurrentShownQuestion := Length(UserQuestionsList) - 1;
    ShowQuestion(Canvas, UserQuestionsList[CurrentShownQuestion], CurrentShownQuestion + 1);
  end
  // Otherwise, do not allow user to do anything more
  else ChangeFormForNoQuestions(btnPreviousQuestion, btnNextQuestion, btnDeleteQuestion, btnAddQuestion, btnRemoveQuestions, btnRevise, Canvas);
end;

procedure TSavedQuestions.btnNextQuestionClick(Sender: TObject);
begin
  // Change current shown question number
  CurrentShownQuestion := CurrentShownQuestion + 1;
  if CurrentShownQuestion > Length(UserQuestionsList) - 1 then
    CurrentShownQuestion := 0;

  // Show question
  ShowQuestion(Canvas, UserQuestionsList[CurrentShownQuestion], CurrentShownQuestion + 1);
end;

procedure TSavedQuestions.btnPreviousQuestionClick(Sender: TObject);
begin
  // Change current shown question number
  CurrentShownQuestion := CurrentShownQuestion - 1;
  if CurrentShownQuestion < 0 then
    CurrentShownQuestion := Length(UserQuestionsList) - 1;

  // Show question
  ShowQuestion(Canvas, UserQuestionsList[CurrentShownQuestion], CurrentShownQuestion + 1);
end;

procedure TSavedQuestions.btnRemoveQuestionsClick(Sender: TObject);
var Count, QuestionPosition : Integer; QuestionFound : Boolean;
begin
  // Initialise
  QuestionPosition := 1;

  // Find whether question has been added before
  QuestionFound := false;
  for Count := 1 to 20 do
  begin
    if ChosenQuestionNumbers[Count] = CurrentShownQuestion then
    begin
      QuestionFound := true;
      QuestionPosition := Count;
    end;
  end;

  // If question is in the list, remove it
  if QuestionFound then
  begin
    for Count := QuestionPosition to 19 do
    begin
      ChosenQuestionNumbers[Count] := ChosenQuestionNumbers[Count + 1];
      ChosenQuestionList[Count] := ChosenQuestionList[Count + 1];
    end;
    ChosenQuestionNumbers[20] := -1;
    NumOfChosenQuestions := NumOfChosenQuestions - 1;
    memSavedQuestionsList.Lines.Delete(QuestionPosition - 2);
  end;
end;

procedure TSavedQuestions.btnReviseClick(Sender: TObject);
var Count : Integer;
begin
  // If questions to revise have been chosen, go to revision form
  if NumOfChosenQuestions > 0 then
  begin
    TheQuestionForm.NumOfQuestions := NumOfChosenQuestions;
    for Count := 1 to 20 do
      TheQuestionForm.QuestionList[Count] := ChosenQuestionList[Count + 1];
    TheQuestionForm.Show;
    SavedQuestions.Hide;
  end;
end;

procedure TSavedQuestions.FormClose(Sender: TObject; var Action: TCloseAction);
var QuestionsFile : TextFile; Count : Integer;
begin
  // Save questions back to file
  AssignFile(QuestionsFile, 'SavedQuestions.AMF');
  Rewrite(QuestionsFile);
  for Count := Low(AllQuestionsList) to High(AllQuestionsList) do
    Writeln(QuestionsFile, AllQuestionsList[Count].Topic + '|' + AllQuestionsList[Count].SubTopic + '|' + AllQuestionsList[Count].Question + '|' + AllQuestionsList[Count].CorrectAnswer + '|' + AllQuestionsList[Count].GetUser + '|' + DateToStr(AllQuestionsList[Count].GetSaveTime));
  CloseFile(QuestionsFile);
  TheMenu.Show;
end;

procedure TSavedQuestions.FormShow(Sender: TObject);
var QuestionsFile : TextFile; Count : Integer; ReadInList : TStringList; ReadInLine : String;
begin
  memSavedQuestionsList.Lines.Clear;
  for Count := 1 to 20 do
    ChosenQuestionNumbers[Count] := -1;
  NumOfChosenQuestions := 0;
  tmrStartDelay.Enabled := true;
  SetLength(UserQuestionsList, 0);

  if FileExists('SavedQuestions.AMF') then
  begin
    try
      // Attempt to load questions from the file
      AssignFile(QuestionsFile, 'SavedQuestions.AMF');
      Reset(QuestionsFile);
      Count := 0;
      SetLength(AllQuestionsList, 1);
      while not EoF(QuestionsFile) do
      begin
        SetLength(AllQuestionsList, Count + 1);
        ReadInList := TStringList.Create;
        Readln(QuestionsFile, ReadInLine);
        ExtractStrings(['|'], [], PChar(ReadInLine), ReadInList);
        AllQuestionsList[Count] := TSavedQuestion.Create('','');
        AllQuestionsList[Count].Topic := ReadInList[0];
        AllQuestionsList[Count].SubTopic := ReadInList[1];
        AllQuestionsList[Count].Question := ReadInList[2];
        AllQuestionsList[Count].CorrectAnswer := ReadInList[3];
        AllQuestionsList[Count].SetUser(ReadInList[4]);
        AllQuestionsList[Count].SetSaveTime(StrToDate(ReadInList[5]));
        Count := Count + 1;
      end;
      SetLength(AllQuestionsList, Count);
      CloseFile(QuestionsFile);
      SortQuestionsByDate(AllQuestionsList);

      // Put user's questions into a seperate array
      for Count := Low(AllQuestionsList) to High(AllQuestionsList) do
      begin
        if AllQuestionsList[Count].GetUser = TheMenu.LoggedInUser then
        begin
          SetLength(UserQuestionsList, Length(UserQuestionsList) + 1);
          UserQuestionsList[Length(UserQuestionsList) - 1] := TSavedQuestion.Create('','');
          UserQuestionsList[Length(UserQuestionsList) - 1].Topic := AllQuestionsList[Count].Topic;
          UserQuestionsList[Length(UserQuestionsList) - 1].SubTopic := AllQuestionsList[Count].SubTopic;
          UserQuestionsList[Length(UserQuestionsList) - 1].Question := AllQuestionsList[Count].Question;
          UserQuestionsList[Length(UserQuestionsList) - 1].CorrectAnswer := AllQuestionsList[Count].CorrectAnswer;
          UserQuestionsList[Length(UserQuestionsList) - 1].SetUser(AllQuestionsList[Count].GetUser);
          UserQuestionsList[Length(UserQuestionsList) - 1].SetSaveTime(AllQuestionsList[Count].GetSaveTime);
        end;
      end;

      // If questions loaded, allow user to choose from them
      btnPreviousQuestion.Enabled := true;
      btnNextQuestion.Enabled := true;
      btnDeleteQuestion.Enabled := true;
      btnAddQuestion.Enabled := true;
      btnRemoveQuestions.Enabled := true;
      btnRevise.Enabled := true;
      CurrentShownQuestion := 0;

      // Show question
      ShowQuestion(Canvas, UserQuestionsList[CurrentShownQuestion], 1);

      // If no questions then tell user
      if Length(UserQuestionsList) = 0 then ChangeFormForNoQuestions(btnPreviousQuestion, btnNextQuestion, btnDeleteQuestion, btnAddQuestion, btnRemoveQuestions, btnRevise, Canvas);
    except
      // If no file found then will show the default screen (no access to saved question features)
      ChangeFormForNoQuestions(btnPreviousQuestion, btnNextQuestion, btnDeleteQuestion, btnAddQuestion, btnRemoveQuestions, btnRevise, Canvas);
    end;
  end
  // If file doesnt exist show the no access screen
  else ChangeFormForNoQuestions(btnPreviousQuestion, btnNextQuestion, btnDeleteQuestion, btnAddQuestion, btnRemoveQuestions, btnRevise, Canvas);
end;

{ currently a problem with showing the question in the FormShow procedure
  a one millisecond delay at the start gets around this
  need to find a better solution if possible}
procedure TSavedQuestions.tmrStartDelayTimer(Sender: TObject);
begin
  if Length(UserQuestionsList) <> 0 then ShowQuestion(Canvas, UserQuestionsList[CurrentShownQuestion], CurrentShownQuestion + 1);
  tmrStartDelay.Enabled := false;
end;

end.
