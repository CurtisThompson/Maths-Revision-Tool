object Login: TLogin
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Login'
  ClientHeight = 109
  ClientWidth = 251
  Color = clCream
  Constraints.MaxHeight = 138
  Constraints.MaxWidth = 257
  Constraints.MinHeight = 137
  Constraints.MinWidth = 257
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001003030020001000100300300001600000028000000300000006000
    000001000100000000000000000000000000000000000000000000000000EBEB
    EB0000000000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFF
    FFFFFFFF0000FFFFFFFFFFFF0000FFFE3FFFE07F0000FFFC1FFFC01F0000FFFC
    1FFF800F0000FFFC1FFF800F0000FFFC1FFF07870000FFFC1FFF07C70000FFFC
    1FFF07E30000FFFC1FFF07F30000FFFC1FFF06F30000FFFC1FFF07670000FFFC
    1FFF078F0000FFFC1FFF07FF0000FFFC1FFF07FF0000FFFC1FFF07FF0000FFFC
    1FFF07FF0000FFFC1FFF07FF0000FFFC1FFF07FF0000FFFC1FFF07FF0000FFFC
    1FFF07FF0000FFFC1FFF07FF0000FFFC1FFF07FF0000F83C1FFF07FF0000F01C
    1FFF07FF0000E0CC1FFF07FF0000E3EC1FFF07FF0000C1EC1FFF07FF0000C1DC
    1FFF07FF0000C0FC1FFF07FF0000E0FC1FFF07FF0000E07C1FFF07FF0000F00C
    1FFF07FF0000F0000000003F0000F8000000001F0000FC000000001F0000FF00
    0000001F0000FFE00000003F0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFF
    FFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFF
    FFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFF
    FFFFFFFF0000FFFFFFFFFFFF0000FFFE3FFFE07F0000FFFC1FFFC01F0000FFFC
    1FFF800F0000FFFC1FFF800F0000FFFC1FFF07870000FFFC1FFF07C70000FFFC
    1FFF07E30000FFFC1FFF07F30000FFFC1FFF06F30000FFFC1FFF07670000FFFC
    1FFF078F0000FFFC1FFF07FF0000FFFC1FFF07FF0000FFFC1FFF07FF0000FFFC
    1FFF07FF0000FFFC1FFF07FF0000FFFC1FFF07FF0000FFFC1FFF07FF0000FFFC
    1FFF07FF0000FFFC1FFF07FF0000FFFC1FFF07FF0000F83C1FFF07FF0000F01C
    1FFF07FF0000E0CC1FFF07FF0000E3EC1FFF07FF0000C1EC1FFF07FF0000C1DC
    1FFF07FF0000C0FC1FFF07FF0000E0FC1FFF07FF0000E07C1FFF07FF0000F00C
    1FFF07FF0000F0000000003F0000F8000000001F0000FC000000001F0000FF00
    0000001F0000FFE00000003F0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFF
    FFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFF
    FFFFFFFF0000}
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object edtUsername: TEdit
    Left = 8
    Top = 16
    Width = 227
    Height = 21
    MaxLength = 15
    TabOrder = 0
    TextHint = 'Username'
  end
  object edtPassword: TEdit
    Left = 8
    Top = 43
    Width = 227
    Height = 21
    MaxLength = 15
    PasswordChar = '*'
    TabOrder = 1
    TextHint = 'Password'
  end
  object btnLogin: TButton
    Left = 128
    Top = 70
    Width = 107
    Height = 25
    Caption = 'Login'
    TabOrder = 2
    OnClick = btnLoginClick
  end
  object btnNewAccount: TButton
    Left = 8
    Top = 70
    Width = 105
    Height = 25
    Caption = 'Create Account'
    TabOrder = 3
    OnClick = btnNewAccountClick
  end
end
