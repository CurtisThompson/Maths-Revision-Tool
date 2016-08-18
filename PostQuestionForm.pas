unit PostQuestionForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, FeedbackClass;

type
  TPostQuestion = class(TForm)
    lblAlgebra: TLabel;
    lblCoordinate: TLabel;
    lblDifferentiation: TLabel;
    lblFunctions: TLabel;
    lblIntegration: TLabel;
    lblNumericalM: TLabel;
    lblTrigonometry: TLabel;
    lblVectors: TLabel;
    lblTopic: TLabel;
    lblNumQCorrect: TLabel;
    lblQ1Correct: TLabel;
    lblQ2Correct: TLabel;
    lblQ3Correct: TLabel;
    lblQ4Correct: TLabel;
    lblQ5Correct: TLabel;
    lblQ6Correct: TLabel;
    lblQ7Correct: TLabel;
    lblQ8Correct: TLabel;
    shpTableLine: TShape;
    lblNumQTotal: TLabel;
    lblQ1Total: TLabel;
    lblQ2Total: TLabel;
    lblQ3Total: TLabel;
    lblQ4Total: TLabel;
    lblQ5Total: TLabel;
    lblQ6Total: TLabel;
    lblQ7Total: TLabel;
    lblQ8Total: TLabel;
    edtUserComments: TEdit;
    btnFinish: TButton;
    lblTotalCorrect: TLabel;
    lblTotalMarks: TLabel;
    shpMarkDivisor: TShape;
    procedure btnFinishClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CorrectMarks : Array [1..8] of Integer;
    NumOfQuestions : Array [1..8] of Integer;
  end;

var
  PostQuestion: TPostQuestion;
  CurrentFeedback : TIndivFeedback;
  TotalCorrectMarks, TotalQuestions : Integer;

implementation
uses MenuForm;
{$R *.dfm}

procedure TPostQuestion.btnFinishClick(Sender: TObject);
begin
  // Add user comments to current feedback
  CurrentFeedback.Comments := edtUserComments.Text;

  // Close
  Close;
end;

procedure TPostQuestion.FormClose(Sender: TObject; var Action: TCloseAction);
var FeedbackFile : TextFile; Count : Integer;
begin
  // Save the feedback to file
  AssignFile(FeedbackFile, 'Feedback.AMF');
  if FileExists('Feedback.AMF') then Append(FeedbackFile)
  else Rewrite(FeedbackFile);
  CurrentFeedback.Comments := edtUserComments.Text;
  Write(FeedbackFile, DateToStr(CurrentFeedback.FeedbackTime) + '|' + CurrentFeedback.User + '|' + CurrentFeedback.Topic + '|');
  for Count := 1 to 8 do
    Write(FeedbackFile, IntToStr(CurrentFeedback.TopicCorrectMarks[Count]) + '|' + IntToStr(CurrentFeedback.TopicTotalMarks[Count]) + '|');
  Writeln(FeedbackFile, IntToStr(CurrentFeedback.CorrectMarks) + '|' + IntToStr(CurrentFeedback.TotalMarks) + '|' + CurrentFeedback.Comments);
  CloseFile(FeedbackFile);
  TheMenu.Show();
end;

procedure TPostQuestion.FormShow(Sender: TObject);
var Count, MostRevisedTopic : Integer;
begin
  // Create feedback
  CurrentFeedback := TIndivFeedback.Create;
  CurrentFeedback.FeedbackTime := Now;
  CurrentFeedback.User := TheMenu.LoggedInUser;

  // Determine which topic was most revised in this session
  MostRevisedTopic := 1;
  for Count := 2 to 8 do
    if NumOfQuestions[Count] > NumOfQuestions[MostRevisedTopic] then MostRevisedTopic := Count;
  if MostRevisedTopic = 1 then CurrentFeedback.Topic := 'Algebra and Series'
  else if MostRevisedTopic = 2 then CurrentFeedback.Topic := 'Coordinate Geometry'
  else if MostRevisedTopic = 3 then CurrentFeedback.Topic := 'Differentiation'
  else if MostRevisedTopic = 4 then CurrentFeedback.Topic := 'Functions'
  else if MostRevisedTopic = 5 then CurrentFeedback.Topic := 'Integration'
  else if MostRevisedTopic = 6 then CurrentFeedback.Topic := 'Numerical Methods'
  else if MostRevisedTopic = 7 then CurrentFeedback.Topic := 'Trigonometry'
  else if MostRevisedTopic = 8 then CurrentFeedback.Topic := 'Vectors';

  // Add topic marks to feedback
  for Count := 1 to 8 do
  begin
    CurrentFeedback.TopicCorrectMarks[Count] := CorrectMarks[Count];
    CurrentFeedback.TopicTotalMarks[Count] := NumOfQuestions[Count];
  end;

  // Add up marks
  TotalCorrectMarks := CorrectMarks[1] + CorrectMarks[2] + CorrectMarks[3] + CorrectMarks[4]
                    + CorrectMarks[5] + CorrectMarks[6] + CorrectMarks[7] + CorrectMarks[8];
  TotalQuestions := NumOfQuestions[1] + NumOfQuestions[2] + NumOfQuestions[3] + NumOfQuestions[4]
                  + NumOfQuestions[5] + NumOfQuestions[6] + NumOfQuestions[7] + NumOfQuestions[8];
  CurrentFeedback.CorrectMarks := TotalCorrectMarks;
  CurrentFeedback.TotalMarks := TotalQuestions;

  // Change form display
  lblQ1Correct.Caption := IntToStr(CorrectMarks[1]);
  lblQ2Correct.Caption := IntToStr(CorrectMarks[2]);
  lblQ3Correct.Caption := IntToStr(CorrectMarks[3]);
  lblQ4Correct.Caption := IntToStr(CorrectMarks[4]);
  lblQ5Correct.Caption := IntToStr(CorrectMarks[5]);
  lblQ6Correct.Caption := IntToStr(CorrectMarks[6]);
  lblQ7Correct.Caption := IntToStr(CorrectMarks[7]);
  lblQ8Correct.Caption := IntToStr(CorrectMarks[8]);
  lblQ1Total.Caption := IntToStr(NumOfQuestions[1]);
  lblQ2Total.Caption := IntToStr(NumOfQuestions[2]);
  lblQ3Total.Caption := IntToStr(NumOfQuestions[3]);
  lblQ4Total.Caption := IntToStr(NumOfQuestions[4]);
  lblQ5Total.Caption := IntToStr(NumOfQuestions[5]);
  lblQ6Total.Caption := IntToStr(NumOfQuestions[6]);
  lblQ7Total.Caption := IntToStr(NumOfQuestions[7]);
  lblQ8Total.Caption := IntToStr(NumOfQuestions[8]);
  lblTotalCorrect.Caption := IntToStr(TotalCorrectMarks);
  lblTotalMarks.Caption := IntToStr(TotalQuestions);
  if TotalQuestions >= 10 then shpMarkDivisor.Width := 36
  else shpMarkDivisor.Width := 18;
end;

end.
