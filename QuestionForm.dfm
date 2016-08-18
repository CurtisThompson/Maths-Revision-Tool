object TheQuestionForm: TTheQuestionForm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Questions'
  ClientHeight = 289
  ClientWidth = 549
  Color = clCream
  Constraints.MaxHeight = 318
  Constraints.MaxWidth = 555
  Constraints.MinHeight = 317
  Constraints.MinWidth = 555
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
  object edtAnswerBox: TEdit
    Left = 272
    Top = 197
    Width = 225
    Height = 21
    TabOrder = 1
    TextHint = 'Enter Answer Here...'
    OnKeyPress = edtAnswerBoxKeyPress
  end
  object btnPreviousQuestion: TButton
    Left = 16
    Top = 240
    Width = 97
    Height = 25
    Caption = 'Previous Question'
    TabOrder = 2
    OnClick = btnPreviousQuestionClick
  end
  object btnNextQuestion: TButton
    Left = 119
    Top = 240
    Width = 97
    Height = 25
    Caption = 'Next Question'
    TabOrder = 3
    OnClick = btnNextQuestionClick
  end
  object btnSaveQuestion: TButton
    Left = 222
    Top = 240
    Width = 99
    Height = 25
    Caption = 'Save Question'
    TabOrder = 4
    OnClick = btnSaveQuestionClick
  end
  object btnExitRevision: TButton
    Left = 431
    Top = 240
    Width = 98
    Height = 25
    Caption = 'Exit Revision'
    TabOrder = 6
    OnClick = btnExitRevisionClick
  end
  object memWorkingOut: TMemo
    Left = 8
    Top = 88
    Width = 521
    Height = 97
    Hint = 'Enter your working out here, it will not be marked.'
    Lines.Strings = (
      'memWorkingOut')
    ParentShowHint = False
    ScrollBars = ssVertical
    ShowHint = True
    TabOrder = 0
  end
  object btnMarkAnswers: TButton
    Left = 327
    Top = 240
    Width = 98
    Height = 25
    Caption = 'Mark Answers'
    TabOrder = 5
    OnClick = btnMarkAnswersClick
  end
  object btnMathsCodes: TButton
    Left = 503
    Top = 195
    Width = 25
    Height = 25
    Caption = '?'
    TabOrder = 7
    OnClick = btnMathsCodesClick
  end
  object tmrStartDelay: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tmrStartDelayTimer
  end
end
