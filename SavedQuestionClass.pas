unit SavedQuestionClass;

interface

uses QuestionClass;

type TSavedQuestion = Class (TQuestion)
  private
    SaveTime : TDateTime;
    User : String[15];
  public
    //constructor Create;
    function GetSaveTime : TDateTime;
    function GetUser : String;
    procedure SetSaveTime (NewSaveTime : TDateTime);
    procedure SetUser (NewUser : String);
end;

implementation

function TSavedQuestion.GetSaveTime : TDateTime;
begin
  GetSaveTime := SaveTime;
end;

function TSavedQuestion.GetUser : String;
begin
  GetUser := String(User);
end;

procedure TSavedQuestion.SetSaveTime (NewSaveTime : TDateTime);
begin
  SaveTime := NewSaveTime;
end;

procedure TSavedQuestion.SetUser (NewUser : String);
begin
  User := AnsiString(NewUser);
end;

end.
