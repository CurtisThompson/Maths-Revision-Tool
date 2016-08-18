unit UserClass;

interface
type
  TUser = Class
  private
    UUsername : String[15];
    UPassword : String[15];
  public
    constructor Create (NewUsername, NewPassword : String);
    function GetUsername : String;
    function GetPassword : String;
    procedure SetUsername (NewUsername : String);
    procedure SetPassword (NewPassword : String);
    property Username : String read GetUsername write SetUsername;
    property Password : String read GetPassword write SetPassword;
end;

implementation

constructor TUser.Create(NewUsername, NewPassword: String);
begin
  UUsername := AnsiString(NewUsername);
  UPassword := AnsiString(NewPassword);
end;

function TUser.GetUsername : String;
begin
  Result := String(UUsername);
end;

function TUser.GetPassword : String;
begin
  Result := String(UPassword);
end;

// Sets a new username
procedure TUser.SetUsername (NewUsername : String);
begin
  UUsername := AnsiString(NewUsername);
end;

// Sets a new password
procedure TUser.SetPassword (NewPassword : String);
begin
  UPassword := AnsiString(NewPassword);
end;

end.
