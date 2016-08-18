unit FeedbackForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FeedbackClass,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, Vcl.ExtCtrls, VCLTee.TeeProcs,
  VCLTee.Chart, VCLTee.Series;

type
  TFeedback = class(TForm)
    btnNextFeedback: TButton;
    btnBackFeedback: TButton;
    btnDeleteFeedback: TButton;
    lblFeedbackDate: TLabel;
    lblFeedbackTopic: TLabel;
    edtComments: TEdit;
    lblFeedbackScore: TLabel;
    chrtTopics: TChart;
    Series1: TBarSeries;
    Series2: TBarSeries;
    procedure btnNextFeedbackClick(Sender: TObject);
    procedure btnBackFeedbackClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDeleteFeedbackClick(Sender: TObject);
    procedure chrtTopicsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Feedback: TFeedback;
  CompleteFeedbackList : Array of TIndivFeedback;
  FeedbackList : Array of TIndivFeedback;
  CurrentFeedbackNumber : Integer;

implementation
uses MenuForm;

procedure EnableFeedbackDisplay (DateLabel, TopicLabel, ScoreLabel : TLabel; NextButton, BackButton, DeleteButton : TButton; CommentBox : TEdit);
begin
  DateLabel.Visible := true;
  TopicLabel.Visible := true;
  ScoreLabel.Visible := true;
  NextButton.Enabled := true;
  BackButton.Enabled := true;
  DeleteButton.Enabled := true;
  CommentBox.Text := '';
end;

procedure ChangeFormForNoFeedback (DateLabel, TopicLabel, ScoreLabel : TLabel; NextButton, BackButton, DeleteButton : TButton; CommentBox : TEdit);
begin
  DateLabel.Visible := false;
  TopicLabel.Visible := false;
  ScoreLabel.Visible := true;
  ScoreLabel.Caption := 'No feedback for current user found.';
  NextButton.Enabled := false;
  BackButton.Enabled := false;
  DeleteButton.Enabled := false;
  CommentBox.Text := '';
end;

// Search for feedback in array, delete it, then move each one down
procedure DeleteFeedbackFromArray (var FeedbackList : Array of TIndivFeedback; FeedbackToDelete : TIndivFeedback);
var Count, Count2 : Integer; FeedbackDeleted : Boolean;
begin
  FeedbackDeleted := false;
  Count := 0;
  repeat
    if Count > High(FeedbackList) then FeedbackDeleted := true
    else
    begin
      if (FeedbackList[Count].FeedbackTime = FeedbackToDelete.FeedbackTime) and (FeedbackList[Count].User = FeedbackToDelete.User)
      and (FeedbackList[Count].Topic = FeedbackToDelete.Topic) and (FeedbackList[Count].CorrectMarks = FeedbackToDelete.CorrectMarks)
      and (FeedbackList[Count].TotalMarks = FeedbackToDelete.TotalMarks) and (FeedbackList[Count].Comments = FeedbackToDelete.Comments) then
      begin
        FeedbackDeleted := true;
        for Count2 := Count to High(FeedbackList) - 1 do
          FeedbackList[Count2] := FeedbackList[Count2 + 1];
      end;
    end;
    Count := Count + 1;
  until FeedbackDeleted;
end;

procedure SortFeedbackByDate (var FeedbackList : Array of TIndivFeedback);
var Passes, Count : Integer; Holder : TIndivFeedback;
begin
  // Bubble sort - repeat the pass until no passes
  repeat
    Passes := 0;
    for Count := Low(FeedbackList) to High(FeedbackList) - 1 do
    begin
      if FeedbackList[Count].FeedbackTime < FeedbackList[Count + 1].FeedbackTime then
      begin
        Holder := FeedbackList[Count];
        FeedbackList[Count] := FeedbackList[Count + 1];
        FeedbackList[Count + 1] := Holder;
        Passes := Passes + 1;
      end;
    end;
  until Passes = 0;
end;

procedure ShowCurrentFeedback (TopicLabel, DateLabel, ScoreLabel : TLabel; CommentBox : TEdit; CurrentFeedback : TIndivFeedback; TopicChart : TChart);
var Count : Integer;
begin
  TopicLabel.Caption := CurrentFeedback.Topic;
  DateLabel.Caption := DateToStr(CurrentFeedback.FeedbackTime);
  ScoreLabel.Caption := IntToStr(CurrentFeedback.CorrectMarks) + ' out of ' + IntToStr(CurrentFeedback.TotalMarks) + ' (' + FloatToStr(Round(CurrentFeedback.CorrectMarks / CurrentFeedback.TotalMarks * 100)) + '%)';
  CommentBox.Text := CurrentFeedback.Comments;

  TopicChart[0].Clear;
  TopicChart[1].Clear;
  for Count := 1 to 8 do
  begin
    TopicChart[0].Add(CurrentFeedback.TopicCorrectMarks[Count]);
    TopicChart[1].Add(CurrentFeedback.TopicTotalMarks[Count]);
  end;
end;

{$R *.dfm}

procedure TFeedback.btnBackFeedbackClick(Sender: TObject);
begin
  CurrentFeedbackNumber := CurrentFeedbackNumber - 1;
  if CurrentFeedbackNumber < 0 then CurrentFeedbackNumber := Length(FeedbackList) - 1;
  ShowCurrentFeedback(lblFeedbackTopic, lblFeedbackDate, lblFeedbackScore, edtComments, FeedbackList[CurrentFeedbackNumber], chrtTopics);
end;

procedure TFeedback.btnDeleteFeedbackClick(Sender: TObject);
begin
  // Delete feedback
  DeleteFeedbackFromArray(CompleteFeedbackList, FeedbackList[CurrentFeedbackNumber]);
  SetLength(CompleteFeedbackList, Length(CompleteFeedbackList) - 1);
  DeleteFeedbackFromArray(FeedbackList, FeedbackList[CurrentFeedbackNumber]);
  SetLength(FeedbackList, Length(FeedbackList) - 1);

  // Show previous question feedback
  if Length(FeedbackList) <> 0 then
  begin
    CurrentFeedbackNumber := CurrentFeedbackNumber - 1;
    if CurrentFeedbackNumber < 0 then CurrentFeedbackNumber := Length(FeedbackList) - 1;
    ShowCurrentFeedback(lblFeedbackTopic, lblFeedbackDate, lblFeedbackScore, edtComments, FeedbackList[CurrentFeedbackNumber], chrtTopics);
  end
  // Or if all feedback has been deleted, show no feedback
  else ChangeFormForNoFeedback(lblFeedbackDate, lblFeedbackTopic, lblFeedbackScore, btnNextFeedback, btnBackFeedback, btnDeleteFeedback, edtComments);
end;

procedure TFeedback.btnNextFeedbackClick(Sender: TObject);
begin
  CurrentFeedbackNumber := CurrentFeedbackNumber + 1;
  if CurrentFeedbackNumber > Length(FeedbackList) - 1 then CurrentFeedbackNumber := 0;
  ShowCurrentFeedback(lblFeedbackTopic, lblFeedbackDate, lblFeedbackScore, edtComments, FeedbackList[CurrentFeedbackNumber], chrtTopics);
end;

procedure TFeedback.chrtTopicsMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  // Tell the user which bar (topic) they are hovering over
  if (X > 40) and (X < 71) then chrtTopics.Hint := 'Algebra and Series'
  else if (X > 71) and (X < 99) then chrtTopics.Hint := 'Coordinate Geometry'
  else if (X > 99) and (X < 127) then chrtTopics.Hint := 'Differentiation'
  else if (X > 127) and (X < 155) then chrtTopics.Hint := 'Functions'
  else if (X > 155) and (X < 183) then chrtTopics.Hint := 'Integration'
  else if (X > 183) and (X < 211) then chrtTopics.Hint := 'Numerical Methods'
  else if (X > 211) and (X < 239) then chrtTopics.Hint := 'Trigonometry'
  else if (X > 239) and (X < 267) then chrtTopics.Hint := 'Vectors'
  else chrtTopics.Hint := '';
end;

procedure TFeedback.FormClose(Sender: TObject; var Action: TCloseAction);
var FeedbackFile : TextFile; Count, MarksCount : Integer;
begin
  // Save feedback back to file
  AssignFile(FeedbackFile, 'Feedback.AMF');
  Rewrite(FeedbackFile);
  for Count := Low(CompleteFeedbackList) to High(CompleteFeedbackList) do
  begin
    Write(FeedbackFile, DateToStr(CompleteFeedbackList[Count].FeedbackTime) + '|' + CompleteFeedbackList[Count].User + '|' + CompleteFeedbackList[Count].Topic + '|');
    for MarksCount := 1 to 8 do
      Write(FeedbackFile, IntToStr(CompleteFeedbackList[Count].TopicCorrectMarks[MarksCount]) + '|' + IntToStr(CompleteFeedbackList[Count].TopicTotalMarks[MarksCount]) + '|');
    Writeln(FeedbackFile, IntToStr(CompleteFeedbackList[Count].CorrectMarks) + '|' + IntToStr(CompleteFeedbackList[Count].TotalMarks) + '|' + CompleteFeedbackList[Count].Comments);
  end;
  CloseFile(FeedbackFile);

  TheMenu.Show;
end;

procedure TFeedback.FormShow(Sender: TObject);
var FeedbackFile : TextFile; Count, MarksCount : Integer; ReadInList : TStringList; ReadInLine : String;
begin
  chrtTopics[0].Marks.Visible := false;
  chrtTopics[1].Marks.Visible := false;

  try
    // Attempt to load questions from the file
    AssignFile(FeedbackFile, 'Feedback.AMF');
    Reset(FeedbackFile);
    Count := 0;
    SetLength(CompleteFeedbackList, 1);
    while not EoF(FeedbackFile) do
    begin
      SetLength(CompleteFeedbackList, Count + 1);
      ReadInList := TStringList.Create;
      Readln(FeedbackFile, ReadInLine);
      ExtractStrings(['|'], [], PChar(ReadInLine), ReadInList);
      CompleteFeedbackList[Count] := TIndivFeedback.Create;
      CompleteFeedbackList[Count].FeedbackTime := StrToDate(ReadInList[0]);
      CompleteFeedbackList[Count].User := ReadInList[1];
      CompleteFeedbackList[Count].Topic := ReadInList[2];
      for MarksCount := 1 to 8 do
      begin
        CompleteFeedbackList[Count].TopicCorrectMarks[MarksCount] := StrToInt(ReadInList[(2 * MarksCount) + 1]);
        CompleteFeedbackList[Count].TopicTotalMarks[MarksCount] := StrToInt(ReadInList[(2 * MarksCount) + 2]);
      end;
      CompleteFeedbackList[Count].CorrectMarks := StrToInt(ReadInList[19]);
      CompleteFeedbackList[Count].TotalMarks := StrToInt(ReadInList[20]);
      try
        CompleteFeedbackList[Count].Comments := ReadInList[21]
      except
        CompleteFeedbackList[Count].Comments := '';
      end;
      Count := Count + 1;
    end;
    SetLength(CompleteFeedbackList, Count);
    CloseFile(FeedbackFile);
    SortFeedbackByDate(CompleteFeedbackList);

    // Put user's feedback into a seperate array
    SetLength(FeedbackList, 0);
    for Count := Low(CompleteFeedbackList) to High(CompleteFeedbackList) do
    begin
      if CompleteFeedbackList[Count].User = TheMenu.LoggedInUser then
      begin
        SetLength(FeedbackList, Length(FeedbackList) + 1);
        FeedbackList[Length(FeedbackList) - 1] := TIndivFeedback.Create;
        FeedbackList[Length(FeedbackList) - 1] := CompleteFeedbackList[Count];
      end;
    end;

    CurrentFeedbackNumber := 0;

    // If feedback for user show, else tell them no feedback
    edtComments.Text := '';
    if Length(FeedbackList) <> 0 then
    begin
      EnableFeedbackDisplay(lblFeedbackDate, lblFeedbackTopic, lblFeedbackScore, btnNextFeedback, btnBackFeedback, btnDeleteFeedback, edtComments);
      ShowCurrentFeedback(lblFeedbackTopic, lblFeedbackDate, lblFeedbackScore, edtComments, FeedbackList[CurrentFeedbackNumber], chrtTopics);
    end
    else ChangeFormForNoFeedback(lblFeedbackDate, lblFeedbackTopic, lblFeedbackScore, btnNextFeedback, btnBackFeedback, btnDeleteFeedback, edtComments);
  except
    // If can't load from file, stop feedback being shown
    ChangeFormForNoFeedback(lblFeedbackDate, lblFeedbackTopic, lblFeedbackScore, btnNextFeedback, btnBackFeedback, btnDeleteFeedback, edtComments);
    lblFeedbackScore.Caption := 'File could not be loaded.';
  end;
end;

end.
