object SavedQuestions: TSavedQuestions
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'SavedQuestions'
  ClientHeight = 227
  ClientWidth = 760
  Color = clCream
  Constraints.MaxHeight = 256
  Constraints.MaxWidth = 766
  Constraints.MinHeight = 255
  Constraints.MinWidth = 766
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
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object memSavedQuestionsList: TMemo
    Left = 520
    Top = 8
    Width = 218
    Height = 199
    Lines.Strings = (
      'memSavedQuestionsList')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object btnPreviousQuestion: TButton
    Left = 8
    Top = 152
    Width = 121
    Height = 25
    Caption = 'Previous Question'
    TabOrder = 1
    OnClick = btnPreviousQuestionClick
  end
  object btnNextQuestion: TButton
    Left = 392
    Top = 152
    Width = 122
    Height = 25
    Caption = 'Next Question'
    TabOrder = 2
    OnClick = btnNextQuestionClick
  end
  object btnDeleteQuestion: TButton
    Left = 8
    Top = 183
    Width = 121
    Height = 25
    Caption = 'Delete Question'
    TabOrder = 3
    OnClick = btnDeleteQuestionClick
  end
  object btnAddQuestion: TButton
    Left = 135
    Top = 183
    Width = 122
    Height = 25
    Caption = 'Add Question'
    TabOrder = 4
    OnClick = btnAddQuestionClick
  end
  object btnRemoveQuestions: TButton
    Left = 263
    Top = 183
    Width = 123
    Height = 25
    Caption = 'Remove Questions'
    TabOrder = 5
    OnClick = btnRemoveQuestionsClick
  end
  object btnRevise: TButton
    Left = 392
    Top = 183
    Width = 122
    Height = 25
    Caption = 'Revise'
    TabOrder = 6
    OnClick = btnReviseClick
  end
  object tmrStartDelay: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tmrStartDelayTimer
  end
end
