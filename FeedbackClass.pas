unit FeedbackClass;

interface
type TIndivFeedback = Class
  private
    FFeedbackTime : TDateTime;
    FUser : String[15];
    FTopic : String[30];
    FTopicCorrectMarks : Array [1..8] of Byte;
    FTopicTotalMarks : Array[1..8] of Byte;
    FCorrectMarks : Byte;
    FTotalMarks : Byte;
    FComments : String[255];
  public
    function GetUser : String;
    function GetTopic : String;
    function GetComments : String;
    function GetTopicCorrectMarks (Index : Integer) : Byte;
    function GetTopicTotalMarks (Index : Integer) : Byte;
    procedure SetFeedbackTime (NewFeedbackTime : TDateTime);
    procedure SetUser (NewUser : String);
    procedure SetTopic (NewTopic : String);
    procedure SetTopicCorrectMarks (Index : Integer; Mark : Byte);
    procedure SetTopicTotalMarks (Index : Integer; Mark : Byte);
    procedure SetCorrectMarks (NewCorrectMarks : Byte);
    procedure SetTotalMarks (NewTotalMarks : Byte);
    procedure SetComments (NewComments : String);
    property FeedbackTime : TDateTime read FFeedbackTime write SetFeedbackTime;
    property User : String read GetUser write SetUser;
    property Topic : String read GetTopic write SetTopic;
    property TopicCorrectMarks[Index : Integer] : Byte read GetTopicCorrectMarks write SetTopicCorrectMarks;
    property TopicTotalMarks[Index : Integer] : Byte read GetTopicTotalMarks write SetTopicTotalMarks;
    property CorrectMarks : Byte read FCorrectMarks write SetCorrectMarks;
    property TotalMarks : Byte read FTotalMarks write SetTotalMarks;
    property Comments : String read GetComments write SetComments;
end;

implementation

function TIndivFeedback.GetUser : String;
begin
  Result := String(FUser);
end;

function TIndivFeedback.GetTopic : String;
begin
  Result := String(FTopic);
end;

function TIndivFeedback.GetComments : String;
begin
  Result := String(FComments);
end;

function TIndivFeedback.GetTopicCorrectMarks(Index: Integer) : Byte;
begin
  Result := FTopicCorrectMarks[Index];
end;

function TIndivFeedback.GetTopicTotalMarks(Index: Integer) : Byte;
begin
  Result := FTopicTotalMarks[Index];
end;

procedure TIndivFeedback.SetFeedbackTime (NewFeedbackTime : TDateTime);
begin
  FFeedbackTime := NewFeedbackTime;
end;

procedure TIndivFeedback.SetUser (NewUser : String);
begin
  FUser := AnsiString(NewUser);
end;

procedure TIndivFeedback.SetTopic (NewTopic : String);
begin
  FTopic := AnsiString(NewTopic);
end;

procedure TIndivFeedback.SetTopicCorrectMarks (Index : Integer; Mark : Byte);
begin
  FTopicCorrectMarks[Index] := Mark;
end;

procedure TIndivFeedback.SetTopicTotalMarks(Index : Integer; Mark : Byte);
begin
  FTopicTotalMarks[Index] := Mark;
end;

procedure TIndivFeedback.SetCorrectMarks (NewCorrectMarks : Byte);
begin
  FCorrectMarks := NewCorrectMarks;
end;

procedure TIndivFeedback.SetTotalMarks (NewTotalMarks : Byte);
begin
  FTotalMarks := NewTotalMarks;
end;

procedure TIndivFeedback.SetComments (NewComments : String);
begin
  FComments := AnsiString(NewComments);
end;

end.
