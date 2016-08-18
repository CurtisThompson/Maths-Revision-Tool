unit MenuForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, TopicSelectForm, ProgramInfoForm,
  SavedQuestionsForm, QuestionClass, UserClass, FeedbackForm, VclTee.TeeGDIPlus,
  VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart;

type
  TTheMenu = class(TForm)
    btnRevise: TButton;
    btnSavedQuestions: TButton;
    btnFeedback: TButton;
    btnProgramInfo: TButton;
    lblTips: TLabel;
    lblTitle: TLabel;
    chrtTopics: TChart;
    Series1: TBarSeries;
    lblComments: TLabel;
    tmrCommentsChange: TTimer;
    procedure FormShow(Sender: TObject);
    procedure btnReviseClick(Sender: TObject);
    procedure btnProgramInfoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSavedQuestionsClick(Sender: TObject);
    procedure btnFeedbackClick(Sender: TObject);
    procedure tmrCommentsChangeTimer(Sender: TObject);
    procedure chrtTopicsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    LoggedInUser : String;
  end;

var
  TheMenu: TTheMenu;
  RecentFeedbackTopicScores : Array [1..8, 1..2] of Integer;
  RecentFeedbackComments : Array of String;
  CurrentShownComment : Integer;

implementation
uses LoginForm;

function NewTip : String;
var RandomTip : Integer; TipList : Array [0..9] of String;
begin
  RandomTip := Random(10);
  TipList[0] := 'Tip: Revise in short sessions of 20 to 30 minutes';
  TipList[1] := 'Tip: Take regular breaks when revising';
  TipList[2] := 'Tip: Don''t just revise your strongest topics!';
  TipList[3] := 'Tip: Make a revision plan and stick to it';
  TipList[4] := 'Tip: Get rid of all distractions like your phone when revising';
  TipList[5] := 'Tip: Test yourself regularly!';
  TipList[6] := 'Tip: Revise actively, don''t just read notes';
  TipList[7] := 'Tip: All good revisers get sleep every day';
  TipList[8] := 'Tip: All good revisers get fresh air every day';
  Tiplist[9] := 'Tip: Stay hydrated to improve your memory';

  NewTip := TipList[RandomTip];
end;

{$R *.dfm}

procedure TTheMenu.btnFeedbackClick(Sender: TObject);
begin
  Feedback.Show;
  TheMenu.Hide;
end;

procedure TTheMenu.btnProgramInfoClick(Sender: TObject);
begin
  ProgramInfo.Show;
  TheMenu.Hide;
end;

procedure TTheMenu.btnReviseClick(Sender: TObject);
begin
  TopicSelect.Show;
  TheMenu.Hide;
end;

procedure TTheMenu.btnSavedQuestionsClick(Sender: TObject);
begin
  SavedQuestions.Show;
  TheMenu.Hide;
end;

procedure TTheMenu.chrtTopicsMouseMove(Sender: TObject; Shift: TShiftState; X,
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

procedure TTheMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tmrCommentsChange.Enabled := false;
  Login.Show;
end;

procedure TTheMenu.FormShow(Sender: TObject);
var Count : Integer; FeedbackFile : TextFile; ReadInLine : String; ReadInList : TStringList;
begin
  // Show new revision tip
  lblTips.Caption := NewTip;
  tmrCommentsChange.Enabled := true;

  // Style marks chart
  chrtTopics[0].Marks.Visible := false;

  // Initialise comments array
  SetLength(RecentFeedbackComments, 0);
  for Count := 1 to 8 do
  begin
    RecentFeedbackTopicScores[Count, 1] := 0;
    RecentFeedbackTopicScores[Count, 2] := 0;
  end;

  // Read feedback in from file, if it is feedback for current user add scores and comments to array
  try
    AssignFile(FeedbackFile, 'Feedback.AMF');
    Reset(FeedbackFile);
    Count := 0;
    while (not EoF(FeedbackFile)) and (Length(RecentFeedbackComments) < 11) do
    begin
      ReadInList := TStringList.Create;
      Readln(FeedbackFile, ReadInLine);
      ExtractStrings(['|'], [], PChar(ReadInLine), ReadInList);
      if ReadInList[1] = LoggedInUser then
      begin
        SetLength(RecentFeedbackComments, Count + 1);
        try
          RecentFeedbackComments[Count] := ReadInList[21]
        except
          RecentFeedbackComments[Count] := '';
        end;

        RecentFeedbackTopicScores[1, 1] := RecentFeedbackTopicScores[1, 1] + StrToInt(ReadInList[3]);
        RecentFeedbackTopicScores[1, 2] := RecentFeedbackTopicScores[1, 2] + StrToInt(ReadInList[4]);
        RecentFeedbackTopicScores[2, 1] := RecentFeedbackTopicScores[2, 1] + StrToInt(ReadInList[5]);
        RecentFeedbackTopicScores[2, 2] := RecentFeedbackTopicScores[2, 2] + StrToInt(ReadInList[6]);
        RecentFeedbackTopicScores[3, 1] := RecentFeedbackTopicScores[3, 1] + StrToInt(ReadInList[7]);
        RecentFeedbackTopicScores[3, 2] := RecentFeedbackTopicScores[3, 2] + StrToInt(ReadInList[8]);
        RecentFeedbackTopicScores[4, 1] := RecentFeedbackTopicScores[4, 1] + StrToInt(ReadInList[9]);
        RecentFeedbackTopicScores[4, 2] := RecentFeedbackTopicScores[4, 2] + StrToInt(ReadInList[10]);
        RecentFeedbackTopicScores[5, 1] := RecentFeedbackTopicScores[5, 1] + StrToInt(ReadInList[11]);
        RecentFeedbackTopicScores[5, 2] := RecentFeedbackTopicScores[5, 2] + StrToInt(ReadInList[12]);
        RecentFeedbackTopicScores[6, 1] := RecentFeedbackTopicScores[6, 1] + StrToInt(ReadInList[13]);
        RecentFeedbackTopicScores[6, 2] := RecentFeedbackTopicScores[6, 2] + StrToInt(ReadInList[14]);
        RecentFeedbackTopicScores[7, 1] := RecentFeedbackTopicScores[7, 1] + StrToInt(ReadInList[15]);
        RecentFeedbackTopicScores[7, 2] := RecentFeedbackTopicScores[7, 2] + StrToInt(ReadInList[16]);
        RecentFeedbackTopicScores[8, 1] := RecentFeedbackTopicScores[8, 1] + StrToInt(ReadInList[17]);
        RecentFeedbackTopicScores[8, 2] := RecentFeedbackTopicScores[8, 2] + StrToInt(ReadInList[18]);
      end;

      Count := Count + 1;
      ReadInList.Free;
    end;

    chrtTopics[0].Clear;
    for Count := 1 to 8 do
    begin
      chrtTopics[0].Add((RecentFeedbackTopicScores[Count, 1] / RecentFeedbackTopicScores[Count, 2]) * 100);
    end;
  except
  end;
  CloseFile(FeedbackFile);

  // If comments, show first one, otherwise disable comment rotation
  if Length(RecentFeedbackComments) <> 0 then lblComments.Caption := 'Comments: "' + Copy(RecentFeedbackComments[0], 1, 30) + '..."'
  else tmrCommentsChange.Enabled := false;
  CurrentShownComment := 0;
end;

procedure TTheMenu.tmrCommentsChangeTimer(Sender: TObject);
begin
  // If there are comments, rotate around to next one
  if Length(RecentFeedbackComments) <> 0 then
  begin
    CurrentShownComment := CurrentShownComment + 1;
    if CurrentShownComment > High(RecentFeedbackComments) then CurrentShownComment := 0;
    lblComments.Caption := 'Comments: "' + Copy(RecentFeedbackComments[CurrentShownComment], 1, 30) + '..."';
  end;
end;

end.
