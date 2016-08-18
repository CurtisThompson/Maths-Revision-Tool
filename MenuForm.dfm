object TheMenu: TTheMenu
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Maths Revision Tool'
  ClientHeight = 319
  ClientWidth = 522
  Color = clCream
  Constraints.MaxHeight = 348
  Constraints.MaxWidth = 528
  Constraints.MinHeight = 347
  Constraints.MinWidth = 528
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
  object lblTips: TLabel
    Left = 40
    Top = 272
    Width = 32
    Height = 18
    Caption = 'Tip: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 18
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTitle: TLabel
    Left = 56
    Top = 16
    Width = 409
    Height = 46
    Caption = 'Maths Revision Tool'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'Cooper Black'
    Font.Style = []
    ParentFont = False
  end
  object lblComments: TLabel
    Left = 223
    Top = 217
    Width = 224
    Height = 13
    Caption = 'Comments Will Be Shown After Revision'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnRevise: TButton
    Left = 40
    Top = 88
    Width = 177
    Height = 34
    Caption = 'Revise'
    TabOrder = 0
    OnClick = btnReviseClick
  end
  object btnSavedQuestions: TButton
    Left = 40
    Top = 128
    Width = 177
    Height = 34
    Caption = 'Saved Questions'
    TabOrder = 1
    OnClick = btnSavedQuestionsClick
  end
  object btnFeedback: TButton
    Left = 40
    Top = 168
    Width = 177
    Height = 34
    Caption = 'Feedback'
    TabOrder = 2
    OnClick = btnFeedbackClick
  end
  object btnProgramInfo: TButton
    Left = 40
    Top = 208
    Width = 177
    Height = 34
    Caption = 'Program Info'
    TabOrder = 3
    OnClick = btnProgramInfoClick
  end
  object chrtTopics: TChart
    Left = 223
    Top = 88
    Width = 281
    Height = 121
    Foot.Visible = False
    LeftWall.Visible = False
    Legend.Title.Visible = False
    Legend.Visible = False
    SubFoot.Visible = False
    SubTitle.Visible = False
    Title.Text.Strings = (
      'Topics')
    Title.Visible = False
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMaximum = False
    BottomAxis.Labels = False
    BottomAxis.LabelsFormat.Visible = False
    BottomAxis.Maximum = 7.000000000000000000
    LeftAxis.MinorTicks.Visible = False
    Shadow.Visible = False
    View3D = False
    View3DWalls = False
    Zoom.Allow = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    Locked = True
    OnMouseMove = chrtTopicsMouseMove
    DefaultCanvas = 'TGDIPlusCanvas'
    PrintMargins = (
      15
      13
      15
      13)
    ColorPaletteIndex = 13
    object Series1: TBarSeries
      Title = 'TopicsPercentage'
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
      Data = {
        04080000000000000000000840FF12000000416C676562726120616E64205365
        726965730000000000000040FF13000000436F6F7264696E6174652047656F6D
        657472790000000000000000FF0F000000446966666572656E74696174696F6E
        0000000000001840FF0900000046756E6374696F6E730000000000000000FF0B
        000000496E746567726174696F6E0000000000000040FF110000004E756D6572
        6963616C204D6574686F6473000000000000F03FFF0C000000547269676F6E6F
        6D657472790000000000000000FF07000000566563746F7273}
    end
  end
  object tmrCommentsChange: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmrCommentsChangeTimer
    Top = 288
  end
end
