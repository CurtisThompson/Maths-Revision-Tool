object TopicSelect: TTopicSelect
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Topic Select'
  ClientHeight = 274
  ClientWidth = 484
  Color = clCream
  Constraints.MaxHeight = 303
  Constraints.MaxWidth = 490
  Constraints.MinHeight = 302
  Constraints.MinWidth = 490
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
    Top = 72
    Width = 90
    Height = 13
    Caption = 'Algebra and Series'
  end
  object lblCoordinate: TLabel
    Left = 8
    Top = 91
    Width = 103
    Height = 13
    Caption = 'Coordinate Geometry'
  end
  object lblDifferentiation: TLabel
    Left = 8
    Top = 110
    Width = 69
    Height = 13
    Caption = 'Differentiation'
  end
  object lblFunctions: TLabel
    Left = 8
    Top = 129
    Width = 46
    Height = 13
    Caption = 'Functions'
  end
  object lblIntegration: TLabel
    Left = 8
    Top = 148
    Width = 54
    Height = 13
    Caption = 'Integration'
  end
  object lblNumericalM: TLabel
    Left = 8
    Top = 167
    Width = 90
    Height = 13
    Caption = 'Numerical Methods'
  end
  object lblTrigonometry: TLabel
    Left = 8
    Top = 186
    Width = 64
    Height = 13
    Caption = 'Trigonometry'
  end
  object lblVectors: TLabel
    Left = 8
    Top = 205
    Width = 36
    Height = 13
    Caption = 'Vectors'
  end
  object lblTopic: TLabel
    Left = 8
    Top = 48
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
  object lblNumQ: TLabel
    Left = 176
    Top = 48
    Width = 117
    Height = 13
    Caption = 'Number of Questions'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDelete: TLabel
    Left = 336
    Top = 48
    Width = 37
    Height = 13
    Caption = 'Delete'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblQ1: TLabel
    Left = 176
    Top = 72
    Width = 6
    Height = 13
    Caption = '0'
    Visible = False
  end
  object lblQ2: TLabel
    Left = 176
    Top = 91
    Width = 6
    Height = 13
    Caption = '0'
    Visible = False
  end
  object lblQ3: TLabel
    Left = 176
    Top = 110
    Width = 6
    Height = 13
    Caption = '0'
    Visible = False
  end
  object lblQ4: TLabel
    Left = 176
    Top = 129
    Width = 6
    Height = 13
    Caption = '0'
    Visible = False
  end
  object lblQ5: TLabel
    Left = 176
    Top = 148
    Width = 6
    Height = 13
    Caption = '0'
    Visible = False
  end
  object lblQ6: TLabel
    Left = 176
    Top = 167
    Width = 6
    Height = 13
    Caption = '0'
    Visible = False
  end
  object lblQ7: TLabel
    Left = 176
    Top = 186
    Width = 6
    Height = 13
    Caption = '0'
    Visible = False
  end
  object lblQ8: TLabel
    Left = 176
    Top = 205
    Width = 6
    Height = 13
    Caption = '0'
    Visible = False
  end
  object shpTableLine: TShape
    Left = 8
    Top = 63
    Width = 400
    Height = 2
  end
  object cboxTopicList: TComboBox
    Left = 8
    Top = 8
    Width = 233
    Height = 21
    Style = csDropDownList
    TabOrder = 0
    TextHint = 'Select topics to revise'
    Items.Strings = (
      'Algebra and Series'
      'Coordinate Geometry'
      'Differentiation'
      'Functions'
      'Integration'
      'Numerical Methods'
      'Trigonometry'
      'Vectors')
  end
  object btnAddTopic: TButton
    Left = 367
    Top = 6
    Width = 98
    Height = 25
    Caption = 'Add Topic'
    TabOrder = 2
    OnClick = btnAddTopicClick
  end
  object btnGenerateQuestions: TButton
    Left = 344
    Top = 239
    Width = 121
    Height = 25
    Caption = 'Generate Questions'
    TabOrder = 3
    OnClick = btnGenerateQuestionsClick
  end
  object edtNumOfQuestions: TEdit
    Left = 247
    Top = 8
    Width = 114
    Height = 21
    NumbersOnly = True
    TabOrder = 1
    TextHint = 'Number of Questions'
  end
  object btnQ1: TButton
    Left = 333
    Top = 71
    Width = 75
    Height = 17
    Caption = 'Delete'
    TabOrder = 4
    Visible = False
    OnClick = btnQ1Click
  end
  object btnQ2: TButton
    Left = 333
    Top = 90
    Width = 75
    Height = 17
    Caption = 'Delete'
    TabOrder = 5
    Visible = False
    OnClick = btnQ2Click
  end
  object btnQ3: TButton
    Left = 333
    Top = 109
    Width = 75
    Height = 17
    Caption = 'Delete'
    TabOrder = 6
    Visible = False
    OnClick = btnQ3Click
  end
  object btnQ4: TButton
    Left = 333
    Top = 128
    Width = 75
    Height = 17
    Caption = 'Delete'
    TabOrder = 7
    Visible = False
    OnClick = btnQ4Click
  end
  object btnQ5: TButton
    Left = 333
    Top = 147
    Width = 75
    Height = 17
    Caption = 'Delete'
    TabOrder = 8
    Visible = False
    OnClick = btnQ5Click
  end
  object btnQ6: TButton
    Left = 333
    Top = 166
    Width = 75
    Height = 17
    Caption = 'Delete'
    TabOrder = 9
    Visible = False
    OnClick = btnQ6Click
  end
  object btnQ7: TButton
    Left = 333
    Top = 185
    Width = 75
    Height = 17
    Caption = 'Delete'
    TabOrder = 10
    Visible = False
    OnClick = btnQ7Click
  end
  object btnQ8: TButton
    Left = 333
    Top = 204
    Width = 75
    Height = 17
    Caption = 'Delete'
    TabOrder = 11
    Visible = False
    OnClick = btnQ8Click
  end
  object btnPrintQuestions: TButton
    Left = 217
    Top = 239
    Width = 121
    Height = 25
    Caption = 'Print Questions'
    TabOrder = 12
    OnClick = btnPrintQuestionsClick
  end
end
