unit LoginForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UserClass, CreateAccountForm, MenuForm,
  Vcl.Touch.Keyboard;

type
  TLogin = class(TForm)
    edtUsername: TEdit;
    edtPassword: TEdit;
    btnLogin: TButton;
    btnNewAccount: TButton;
    procedure btnLoginClick(Sender: TObject);
    procedure btnNewAccountClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Login: TLogin;

implementation

{$R *.dfm}

procedure TLogin.btnLoginClick(Sender: TObject);
var UserFile : TextFile; ReadInUser : String; UserPassCombo : TStringList; LoginSuccessful : Boolean;
begin
  // Log in only to become true if matches user-pass combo
  LoginSuccessful := false;

  // Read in user from file
  AssignFile(UserFile, 'Users.AMF');
  Reset(UserFile);
  while not EoF(UserFile) do
  begin
    UserPassCombo := TStringList.Create;
    Readln(UserFile, ReadInUser);
    ExtractStrings(['|'], [], PChar(ReadInUser), UserPassCombo);

    // Compare read in details to what user has entered
    if (UserPassCombo[0] = edtUsername.Text) and (UserPassCombo[1] = edtPassword.Text) then LoginSuccessful := true;
    UserPassCombo.Free;
  end;
  // Close file and string list
  CloseFile(UserFile);

  // If the username and password combination is correct, log in
  if LoginSuccessful then
  begin
    Login.Hide();
    TheMenu.LoggedInUser := edtUsername.Text;
    TheMenu.Show();
  end
  else ShowMessage('Username or password incorrect. Login failed.');
end;

// Show new account form
procedure TLogin.btnNewAccountClick(Sender: TObject);
begin
  CreateAccount.Show();
end;

// Make sure text boxes are blank when form is shown
procedure TLogin.FormShow(Sender: TObject);
begin
  edtUsername.Text := '';
  edtPassword.Text := '';
end;

end.
