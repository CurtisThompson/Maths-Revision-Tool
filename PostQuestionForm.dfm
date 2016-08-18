object PostQuestion: TPostQuestion
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Results'
  ClientHeight = 272
  ClientWidth = 515
  Color = clCream
  Constraints.MaxHeight = 301
  Constraints.MaxWidth = 521
  Constraints.MinHeight = 300
  Constraints.MinWidth = 521
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
  object lblAlgebra: TLabel
    Left = 8
    Top = 32
    Width = 90
    Height = 13
    Caption = 'Algebra and Series'
  end
  object lblCoordinate: TLabel
    Left = 8
    Top = 51
    Width = 103
    Height = 13
    Caption = 'Coordinate Geometry'
  end
  object lblDifferentiation: TLabel
    Left = 8
    Top = 70
    Width = 69
    Height = 13
    Caption = 'Differentiation'
  end
  object lblFunctions: TLabel
    Left = 8
    Top = 89
    Width = 46
    Height = 13
    Caption = 'Functions'
  end
  object lblIntegration: TLabel
    Left = 8
    Top = 108
    Width = 54
    Height = 13
    Caption = 'Integration'
  end
  object lblNumericalM: TLabel
    Left = 8
    Top = 127
    Width = 90
    Height = 13
    Caption = 'Numerical Methods'
  end
  object lblTrigonometry: TLabel
    Left = 8
    Top = 146
    Width = 64
    Height = 13
    Caption = 'Trigonometry'
  end
  object lblVectors: TLabel
    Left = 8
    Top = 165
    Width = 36
    Height = 13
    Caption = 'Vectors'
  end
  object lblTopic: TLabel
    Left = 8
    Top = 8
    Width = 30
    Height = 13
    Caption = 'Topic'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblNumQCorrect: TLabel
    Left = 176
    Top = 8
    Width = 42
    Height = 13
    Caption = 'Correct'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblQ1Correct: TLabel
    Left = 176
    Top = 32
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lblQ2Correct: TLabel
    Left = 176
    Top = 51
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lblQ3Correct: TLabel
    Left = 176
    Top = 70
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lblQ4Correct: TLabel
    Left = 176
    Top = 89
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lblQ5Correct: TLabel
    Left = 176
    Top = 108
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lblQ6Correct: TLabel
    Left = 176
    Top = 127
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lblQ7Correct: TLabel
    Left = 176
    Top = 146
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lblQ8Correct: TLabel
    Left = 176
    Top = 165
    Width = 6
    Height = 13
    Caption = '0'
  end
  object shpTableLine: TShape
    Left = 8
    Top = 24
    Width = 400
    Height = 2
  end
  object lblNumQTotal: TLabel
    Left = 289
    Top = 8
    Width = 29
    Height = 13
    Caption = 'Total'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblQ1Total: TLabel
    Left = 289
    Top = 32
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lblQ2Total: TLabel
    Left = 289
    Top = 51
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lblQ3Total: TLabel
    Left = 289
    Top = 70
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lblQ4Total: TLabel
    Left = 289
    Top = 89
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lblQ5Total: TLabel
    Left = 289
    Top = 108
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lblQ6Total: TLabel
    Left = 289
    Top = 127
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lblQ7Total: TLabel
    Left = 289
    Top = 146
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lblQ8Total: TLabel
    Left = 289
    Top = 165
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lblTotalCorrect: TLabel
    Left = 440
    Top = 69
    Width = 15
    Height = 33
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblTotalMarks: TLabel
    Left = 440
    Top = 111
    Width = 15
    Height = 33
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object shpMarkDivisor: TShape
    Left = 440
    Top = 107
    Width = 15
    Height = 2
  end
  object edtUserComments: TEdit
    Left = 8
    Top = 200
    Width = 489
    Height = 21
    MaxLength = 255
    TabOrder = 0
    TextHint = 'Add a comment here...'
  end
  object btnFinish: TButton
    Left = 384
    Top = 227
    Width = 113
    Height = 25
    Caption = 'Finish'
    TabOrder = 1
    OnClick = btnFinishClick
  end
end
