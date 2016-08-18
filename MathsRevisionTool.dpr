program MathsRevisionTool;

uses
  Vcl.Forms,
  LoginForm in 'LoginForm.pas' {Login},
  CreateAccountForm in 'CreateAccountForm.pas' {CreateAccount},
  MenuForm in 'MenuForm.pas' {TheMenu},
  ProgramInfoForm in 'ProgramInfoForm.pas' {ProgramInfo},
  TopicSelectForm in 'TopicSelectForm.pas' {TopicSelect},
  SavedQuestionsForm in 'SavedQuestionsForm.pas' {SavedQuestions},
  MathsCodesForm in 'MathsCodesForm.pas' {MathsCodes},
  QuestionForm in 'QuestionForm.pas' {TheQuestionForm},
  PostQuestionForm in 'PostQuestionForm.pas' {PostQuestion},
  FeedbackForm in 'FeedbackForm.pas' {Feedback},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Amethyst Kamri');
  Application.CreateForm(TLogin, Login);
  Application.CreateForm(TCreateAccount, CreateAccount);
  Application.CreateForm(TTheMenu, TheMenu);
  Application.CreateForm(TProgramInfo, ProgramInfo);
  Application.CreateForm(TTopicSelect, TopicSelect);
  Application.CreateForm(TSavedQuestions, SavedQuestions);
  Application.CreateForm(TMathsCodes, MathsCodes);
  Application.CreateForm(TTheQuestionForm, TheQuestionForm);
  Application.CreateForm(TPostQuestion, PostQuestion);
  Application.CreateForm(TFeedback, Feedback);
  Application.Run;
end.
