unit QuestionForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, QuestionClass, Vcl.StdCtrls, PostQuestionForm, System.UITypes,
  SavedQuestionClass, MathsCodesForm, Vcl.ExtCtrls;

type
  TTheQuestionForm = class(TForm)
    edtAnswerBox: TEdit;
    btnPreviousQuestion: TButton;
    btnNextQuestion: TButton;
    btnSaveQuestion: TButton;
    btnExitRevision: TButton;
    memWorkingOut: TMemo;
    btnMarkAnswers: TButton;
    btnMathsCodes: TButton;
    tmrStartDelay: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNextQuestionClick(Sender: TObject);
    procedure btnPreviousQuestionClick(Sender: TObject);
    procedure edtAnswerBoxKeyPress(Sender: TObject; var Key: Char);
    procedure btnExitRevisionClick(Sender: TObject);
    procedure btnMarkAnswersClick(Sender: TObject);
    procedure btnSaveQuestionClick(Sender: TObject);
    procedure btnMathsCodesClick(Sender: TObject);
    procedure tmrStartDelayTimer(Sender: TObject);
  private
    { Private declarations }
  public
    QuestionList : Array [1..20] of TQuestion;
    NumOfQuestions : Integer;
    UserFinished, ShowPostQuestion : Boolean;
  end;

var
  TheQuestionForm: TTheQuestionForm;
  CurrentQuestion, NumCorrect : Integer;
  UsersAnswers : Array [1..20, 1..2] of String; // 1 user answer, 2 user correct (y yes, n no)
  TopicMarks : Array [1..8, 1..2] of Integer;

implementation
uses MenuForm;

procedure ShowQuestion (TheCanvas : TCanvas; AnswerBox : TEdit; TheCurrentQuestion : TQuestion; CurrentAnswer : String); overload;
begin
  ShowMathsText(IntToStr(CurrentQuestion) + ') ' + TheCurrentQuestion.Topic, 10, 5, 1, TheCanvas);
  ShowMathsText(TheCurrentQuestion.Question, 10, 35, 1, TheCanvas);
  ShowMathsText(CurrentAnswer, 10, 195, 1, TheCanvas);
  AnswerBox.Text := CurrentAnswer;
end;

procedure ShowQuestion (TheCanvas : TCanvas; TheCurrentQuestion : TQuestion; CurrentAnswer : String); overload;
begin
  ShowMathsText(IntToStr(CurrentQuestion) + ') ' + TheCurrentQuestion.Topic, 10, 5, 1, TheCanvas);
  ShowMathsText(TheCurrentQuestion.Question, 10, 35, 1, TheCanvas);
  ShowMathsText(CurrentAnswer, 10, 195, 1, TheCanvas);
end;

function CompareAnswers (RawAnswer1, RawAnswer2 : String) : Boolean;
var Answer1, Answer2 : String;
begin
  Answer1 := RawAnswer1;
  Answer2 := RawAnswer2;

  // Convert to comparable format
  Answer1 := StringReplace(Answer1, '{', '', [rfReplaceAll]);
  Answer1 := StringReplace(Answer1, '}', '', [rfReplaceAll]);
  Answer1 := StringReplace(Answer1, '(', '', [rfReplaceAll]);
  Answer1 := StringReplace(Answer1, ')', '', [rfReplaceAll]);
  Answer2 := StringReplace(Answer2, '{', '', [rfReplaceAll]);
  Answer2 := StringReplace(Answer2, '}', '', [rfReplaceAll]);
  Answer2 := StringReplace(Answer2, '(', '', [rfReplaceAll]);
  Answer2 := StringReplace(Answer2, ')', '', [rfReplaceAll]);

  // Compare and return
  if Lowercase(Answer1) = Lowercase(Answer2) then Result := true
  else Result := false;
end;

{$R *.dfm}

// When exiting revision, make sure user wants to do so (no accident) - if finished then take back to menu
procedure TTheQuestionForm.btnExitRevisionClick(Sender: TObject);
var ExitChoice, Count : Integer;
begin
  if UserFinished then
  begin
    for Count := 1 to 8 do
    begin
      PostQuestion.CorrectMarks[Count] := TopicMarks[Count, 1];
      PostQuestion.NumOfQuestions[Count] := TopicMarks[Count, 2];
    end;
    ShowPostQuestion := true;
    Close;
  end
  else
  begin
    ExitChoice := MessageDlg('Are you sure you want to exit?', mtCustom, mbYesNo, 0);
    if ExitChoice = mrYes then
    begin
      Close;
    end;
  end;
end;

// Will mark the users answers
procedure TTheQuestionForm.btnMarkAnswersClick(Sender: TObject);
var IsUserSure, Count : Integer;
begin
  // Ask if user is sure they are done
  IsUserSure := MessageDlg(
  'Are you sure you are finished?', mtCustom, mbYesNo, 0);
  // If user is done
  if IsUserSure = mrYes then
  begin
    // User is finished
    UserFinished := true;

    // Change layout of form
    edtAnswerBox.Visible := false;
    btnMarkAnswers.Enabled := false;
    btnExitRevision.Caption := 'Finish';

    // Add current answer to array (to be marked)
    UsersAnswers[CurrentQuestion, 1] := edtAnswerBox.Text;

    // Mark the users answers
    for Count := 1 to NumOfQuestions do
    begin
      if CompareAnswers(UsersAnswers[Count, 1], QuestionList[Count].CorrectAnswer) then
      begin
        UsersAnswers[Count, 2] := 'y';
        NumCorrect := NumCorrect + 1;

        // Add to specific topic correct marks
        if QuestionList[Count].Topic = 'Algebra and Series' then TopicMarks[1, 1] := TopicMarks[1, 1] + 1
        else if QuestionList[Count].Topic = 'Coordinate Geometry' then TopicMarks[2, 1] := TopicMarks[2, 1] + 1
        else if QuestionList[Count].Topic = 'Differentiation' then TopicMarks[3, 1] := TopicMarks[3, 1] + 1
        else if QuestionList[Count].Topic = 'Functions' then TopicMarks[4, 1] := TopicMarks[4, 1] + 1
        else if QuestionList[Count].Topic = 'Integration' then TopicMarks[5, 1] := TopicMarks[5, 1] + 1
        else if QuestionList[Count].Topic = 'Numerical Methods' then TopicMarks[6, 1] := TopicMarks[6, 1] + 1
        else if QuestionList[Count].Topic = 'Trigonometry' then TopicMarks[7, 1] := TopicMarks[7, 1] + 1
        else if QuestionList[Count].Topic = 'Vectors' then TopicMarks[8, 1] := TopicMarks[8, 1] + 1;
      end
      else UsersAnswers[Count, 2] := 'n';

      // Add to specific topic total marks
      if QuestionList[Count].Topic = 'Algebra and Series' then TopicMarks[1, 2] := TopicMarks[1, 2] + 1
      else if QuestionList[Count].Topic = 'Coordinate Geometry' then TopicMarks[2, 2] := TopicMarks[2, 2] + 1
      else if QuestionList[Count].Topic = 'Differentiation' then TopicMarks[3, 2] := TopicMarks[3, 2] + 1
      else if QuestionList[Count].Topic = 'Functions' then TopicMarks[4, 2] := TopicMarks[4, 2] + 1
      else if QuestionList[Count].Topic = 'Integration' then TopicMarks[5, 2] := TopicMarks[5, 2] + 1
      else if QuestionList[Count].Topic = 'Numerical Methods' then TopicMarks[6, 2] := TopicMarks[6, 2] + 1
      else if QuestionList[Count].Topic = 'Trigonometry' then TopicMarks[7, 2] := TopicMarks[7, 2] + 1
      else if QuestionList[Count].Topic = 'Vectors' then TopicMarks[8, 2] := TopicMarks[8, 2] + 1
    end;

    // Show correct answer for question they are already on
    if UsersAnswers[CurrentQuestion, 2] = 'y' then ShowMathsText('Correct', 275, 195, 1, Canvas)
    else ShowMathsText(QuestionList[CurrentQuestion].CorrectAnswer, 275, 195, 1, Canvas);
  end;
end;

procedure TTheQuestionForm.btnMathsCodesClick(Sender: TObject);
begin
  MathsCodes.Show;
end;

procedure TTheQuestionForm.btnNextQuestionClick(Sender: TObject);
begin
  // Save answer for users current question
  if CurrentQuestion <> 0 then UsersAnswers[CurrentQuestion, 1] := edtAnswerBox.Text;

  ClearCanvas(TheQuestionForm);

  // Change to next question
  CurrentQuestion := CurrentQuestion + 1;
  if CurrentQuestion = 1 then btnPreviousQuestion.Enabled := false
  else btnPreviousQuestion.Enabled := true;
  if CurrentQuestion = NumOfQuestions then btnNextQuestion.Enabled := false
  else btnNextQuestion.Enabled := true;

  // Show question
  ShowQuestion(Canvas, edtAnswerBox, QuestionList[CurrentQuestion], UsersAnswers[CurrentQuestion, 1]);

  // Show answer if user is finished
  if UserFinished then
  begin
    if UsersAnswers[CurrentQuestion, 2] = 'y' then ShowMathsText('Correct', 275, 195, 1, Canvas)
    else ShowMathsText(QuestionList[CurrentQuestion].CorrectAnswer, 275, 195, 1, Canvas);
  end;
end;

procedure TTheQuestionForm.btnPreviousQuestionClick(Sender: TObject);
begin
  // Save answer for users current question
  UsersAnswers[CurrentQuestion, 1] := edtAnswerBox.Text;

  ClearCanvas(TheQuestionForm);

  // Change to previous question
  CurrentQuestion := CurrentQuestion - 1;
  if CurrentQuestion = 1 then btnPreviousQuestion.Enabled := false
  else btnPreviousQuestion.Enabled := true;
  if CurrentQuestion = NumOfQuestions then btnNextQuestion.Enabled := false
  else btnNextQuestion.Enabled := true;

  // Show question
  ShowQuestion(Canvas, edtAnswerBox, QuestionList[CurrentQuestion], UsersAnswers[CurrentQuestion, 1]);

  // Show answer if user is finished
  if UserFinished then
  begin
    if UsersAnswers[CurrentQuestion, 2] = 'y' then ShowMathsText('Correct', 275, 195, 1, Canvas)
    else ShowMathsText(QuestionList[CurrentQuestion].CorrectAnswer, 275, 195, 1, Canvas);
  end;
end;

procedure TTheQuestionForm.btnSaveQuestionClick(Sender: TObject);
var QuestionToSave : TSavedQuestion; QuestionFile : TextFile;
begin
  // Get question into save format
  QuestionToSave := TSavedQuestion.Create('a','a');
  QuestionToSave.Topic := QuestionList[CurrentQuestion].Topic;
  QuestionToSave.SubTopic := QuestionList[CurrentQuestion].SubTopic;
  QuestionToSave.Question := QuestionList[CurrentQuestion].Question;
  QuestionToSave.CorrectAnswer := QuestionList[CurrentQuestion].CorrectAnswer;
  QuestionToSave.SetUser(TheMenu.LoggedInUser);
  QuestionToSave.SetSaveTime(Now);

  // Save to file
  AssignFile(QuestionFile, 'SavedQuestions.AMF');
  if FileExists('SavedQuestions.AMF') then Append(QuestionFile)
  else Rewrite(QuestionFile);
  Writeln(QuestionFile, QuestionToSave.Topic + '|' + QuestionToSave.SubTopic + '|' + QuestionToSave.Question + '|' + QuestionToSave.CorrectAnswer + '|' + QuestionToSave.GetUser + '|' + DateToStr(QuestionToSave.GetSaveTime));
  CloseFile(QuestionFile);

  // Let user know it has been saved
  ShowMessage('Question has been saved.');
end;

// Show the users current answer whenever they type in
procedure TTheQuestionForm.edtAnswerBoxKeyPress(Sender: TObject; var Key: Char);
begin
  ClearCanvas(TheQuestionForm);
  UsersAnswers[CurrentQuestion, 1] := edtAnswerBox.Text + Key;
  ShowQuestion(Canvas, QuestionList[CurrentQuestion], UsersAnswers[CurrentQuestion, 1]);
end;

// When form is closed, show the main menu
procedure TTheQuestionForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ShowPostQuestion = false then TheMenu.Show()
  else PostQuestion.Show();
end;

procedure TTheQuestionForm.FormShow(Sender: TObject);
var Count : Integer;
begin
  // Initialise form
  ClearCanvas(TheQuestionForm);
  edtAnswerBox.Visible := true;
  btnMarkAnswers.Enabled := true;
  btnExitRevision.Caption := 'Exit Revision';
  btnPreviousQuestion.Enabled := false;
  btnNextQuestion.Enabled := true;
  edtAnswerBox.Text := '';
  memWorkingOut.Lines.Clear;
  tmrStartDelay.Enabled := true;

  // Initialise variables
  ShowPostQuestion := false;
  CurrentQuestion := 1;
  NumCorrect := 0;
  UserFinished := false;
  for Count := 1 to 20 do
  begin
    UsersAnswers[Count, 1] := '';
    UsersAnswers[Count, 2] := '';
  end;
  for Count := 1 to 8 do
  begin
    TopicMarks[Count, 1] := 0;
    TopicMarks[Count, 2] := 0;
  end;
end;

{ currently a problem with showing the question in the FormShow procedure
  a one millisecond delay at the start gets around this
  need to find a better solution if possible}
procedure TTheQuestionForm.tmrStartDelayTimer(Sender: TObject);
begin
  ShowQuestion(Canvas, edtAnswerBox, QuestionList[CurrentQuestion], UsersAnswers[CurrentQuestion, 1]);
  tmrStartDelay.Enabled := false;
end;

end.
