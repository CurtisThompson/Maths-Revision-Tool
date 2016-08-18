unit ProgramInfoForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, MathsCodesForm, UserClass, System.UITypes;

type
  TProgramInfo = class(TForm)
    lblProgramName: TLabel;
    lblProgramAuthor: TLabel;
    lblProgramDate: TLabel;
    btnViewMathsCodes: TButton;
    btnDeleteAccount: TButton;
    btnChangePassword: TButton;
    edtNewPassword: TEdit;
    edtConfirmPassword: TEdit;
    btnConfirmChange: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnChangePasswordClick(Sender: TObject);
    procedure btnViewMathsCodesClick(Sender: TObject);
    procedure btnConfirmChangeClick(Sender: TObject);
    procedure btnDeleteAccountClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProgramInfo: TProgramInfo;

implementation

uses MenuForm, LoginForm;

{$R *.dfm}

// Search for feedback in array, delete it, then move each one down
procedure DeleteUserFromArray (var UserList : Array of TUser; UserToDelete : TUser);
var Count, Count2 : Integer; UserDeleted : Boolean;
begin
  UserDeleted := false;
  Count := 0;
  repeat
    if Count > High(UserList) then UserDeleted := true
    else
    begin
      if (UserList[Count].Username = UserToDelete.Username) then
      begin
        UserDeleted := true;
        for Count2 := Count to High(UserList) - 1 do
        begin
          UserList[Count2].Username := UserList[Count2 + 1].Username;
          UserList[Count2].Password := UserList[Count2 + 1].Password;
        end;
      end;
    end;
    Count := Count + 1;
  until UserDeleted;
end;

procedure TProgramInfo.btnChangePasswordClick(Sender: TObject);
begin
  if ProgramInfo.Height <> 210 then ProgramInfo.Height := 210
  else ProgramInfo.Height := 303;
end;

procedure TProgramInfo.btnConfirmChangeClick(Sender: TObject);
var UserFile : TextFile; TheUser : TUser; Count : Integer; UserList : Array of TUser;
    CurrentLine : String; CurrentLineSplit : TStringList;
begin
  // Only change password if new passwords match, and are correct length
  if (edtNewPassword.Text = edtConfirmPassword.Text) and (Length(edtNewPassword.Text) > 5)
  and (Length(edtNewPassword.Text) < 16) then
  begin
    // Get all users
    AssignFile(UserFile, 'Users.AMF');
    Reset(UserFile);
    Count := 1;
    SetLength(UserList, 1);
    while not EoF(UserFile) do
    begin
      SetLength(UserList, Count);
      CurrentLineSplit := TStringList.Create;
      Readln(UserFile, CurrentLine);
      ExtractStrings(['|'], [], PChar(CurrentLine), CurrentLineSplit);
      UserList[Count - 1] := TUser.Create(CurrentLineSplit[0], CurrentLineSplit[1]);
      CurrentLineSplit.Free;
      Count := Count + 1;
    end;
    CloseFile(UserFile);

    // Find user, delete, and re-add with new password
    TheUser := TUser.Create(TheMenu.LoggedInUser, '');
    DeleteUserFromArray(UserList, TheUser);
    SetLength(UserList, Length(UserList) - 1);
    AssignFile(UserFile, 'Users.AMF');
    Rewrite(UserFile);
    for Count := Low(UserList) to High(UserList) do
      Writeln(UserFile, UserList[Count].Username + '|' + UserList[Count].Password);
    Writeln(UserFile, TheMenu.LoggedInUser + '|' + edtNewPassword.Text);
    CloseFile(UserFile);
    ShowMessage('Password changed.');
  end;
end;

procedure TProgramInfo.btnDeleteAccountClick(Sender: TObject);
var DeleteAccount, Count : Integer; UserFile : TextFile; UserToDelete : TUser;
    UserList : Array of TUser; CurrentLineSplit : TStringList; CurrentLine : String;
begin
  DeleteAccount := MessageDlg('Are you sure you want to delete your account?', mtCustom, mbYesNo, 0);
  if DeleteAccount = mrYes then
  begin
    // Get all users
    AssignFile(UserFile, 'Users.AMF');
    Reset(UserFile);
    Count := 1;
    SetLength(UserList, 1);
    while not EoF(UserFile) do
    begin
      SetLength(UserList, Count);
      CurrentLineSplit := TStringList.Create;
      Readln(UserFile, CurrentLine);
      ExtractStrings(['|'], [], PChar(CurrentLine), CurrentLineSplit);
      UserList[Count - 1] := TUser.Create(CurrentLineSplit[0], CurrentLineSplit[1]);
      CurrentLineSplit.Free;
      Count := Count + 1;
    end;
    CloseFile(UserFile);

    // Find user and delete them
    UserToDelete := TUser.Create(TheMenu.LoggedInUser, '');
    DeleteUserFromArray(UserList, UserToDelete);
    SetLength(UserList, Length(UserList) - 1);

    // Save to file
    AssignFile(UserFile, 'Users.AMF');
    Rewrite(UserFile);
    for Count := Low(UserList) to High(UserList) do
      Writeln(UserFile, UserList[Count].Username + '|' + UserList[Count].Password);
    CloseFile(UserFile);

    // Now that user is deleted, take them back to menu
    Login.Show();
    ProgramInfo.Hide();
  end;

end;

procedure TProgramInfo.btnViewMathsCodesClick(Sender: TObject);
begin
  MathsCodes.Show;
end;

procedure TProgramInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TheMenu.Show;
end;

procedure TProgramInfo.FormShow(Sender: TObject);
begin
  edtNewPassword.Text := '';
  edtConfirmPassword.Text := '';
  ProgramInfo.Height := 205;
end;

end.
