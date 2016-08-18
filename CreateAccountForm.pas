unit CreateAccountForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UserClass;

type
  TCreateAccount = class(TForm)
    edtUsername: TEdit;
    edtPassword: TEdit;
    edtRepeatPassword: TEdit;
    btnCreateAccount: TButton;
    procedure btnCreateAccountClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CreateAccount: TCreateAccount;

implementation

{$R *.dfm}

procedure TCreateAccount.btnCreateAccountClick(Sender: TObject);
var UserFile : TextFile; NewUser : TUser; UserAlreadyExists : Boolean; ReadInUser : String; UserPassCombo : TStringList;
begin
  // New account username and password must be of right length
  if (edtPassword.Text = edtRepeatPassword.Text) and (Length(edtUsername.Text) > 5)
  and (Length(edtUsername.Text) < 16) and (Length(edtPassword.Text) > 5) and (Length(edtPassword.Text) < 16) then
  begin
    // User can only be created if does not exist already
    UserAlreadyExists := false;

    // Check each user in file to make sure not repeating if created
    if FileExists('Users.AMF') then
    begin
      AssignFile(UserFile, 'Users.AMF');
      Reset(UserFile);
      UserPassCombo := TStringList.Create;
      while not EoF(UserFile) do
      begin
        Readln(UserFile, ReadInUser);
        ExtractStrings(['|'], [], PChar(ReadInUser), UserPassCombo);

        // Compare new user username to read in username
        if (edtUsername.Text = UserPassCombo[0]) then UserAlreadyExists := true;
      end;
      CloseFile(UserFile);
    end;

    if UserAlreadyExists then ShowMessage ('User already exists.')
    // Create account
    else
    begin
      NewUser := TUser.Create(edtUsername.Text, edtPassword.Text);
      AssignFile(UserFile, 'Users.AMF');
      if FileExists('Users.AMF') then Append(UserFile)
      else Rewrite(UserFile);
      Writeln(UserFile, NewUser.Username + '|' + NewUser.Password);
      CloseFile(UserFile);
      Close;
    end;
  end
  // Cannot create account as passwords dont match
  else ShowMessage ('Account not created. Username and password must be between 6-15 characters, and passwords must match.');
end;

// Make sure text boxes are blank when form is shown
procedure TCreateAccount.FormShow(Sender: TObject);
begin
  edtUsername.Text := '';
  edtPassword.Text := '';
  edtRepeatPassword.Text := '';
end;

end.
