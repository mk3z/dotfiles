{pkgs, ...}: {
  home = {
    packages = [pkgs.speedcrunch];
    file.".config/SpeedCrunch/SpeedCrunch.ini" = {
      recursive = true;
      text = ''
        [General]
        ConfigVersion=1200

        [SpeedCrunch]
        Display\ColorSchemeName=Tomorrow Night
        Display\DisplayFont="Monospace,12,-1,5,50,0,0,0,0,0"
        Format\ComplexForm=c
        Format\Precision=-1
        Format\Type=f
        General\AngleMode=r
        General\AutoAns=true
        General\AutoCalc=true
        General\AutoCompletion=true
        General\AutoResultToClipboard=false
        General\ComplexNumbers=false
        General\DigitGrouping=1
        General\Language=C
        General\LeaveLastExpression=false
        General\RadixCharacter=*
        General\SessionSave=true
        General\SyntaxHighlighting=true
        General\WindowPositionSave=false
        Layout\BitfieldVisible=false
        Layout\ConstantsDockVisible=false
        Layout\FormulaBookDockVisible=false
        Layout\FunctionsDockVisible=false
        Layout\HistoryDockVisible=false
        Layout\KeypadVisible=false
        Layout\StatusBarVisible=false
        Layout\UserFunctionsDockVisible=false
        Layout\VariablesDockVisible=false
        Layout\WindowAlwaysOnTop=false
        Layout\WindowOnFullScreen=false
      '';
    };
  };
}
