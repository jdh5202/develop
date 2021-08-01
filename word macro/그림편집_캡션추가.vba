Sub capture_edit_caption()

' 그림 편집
With Selection.InlineShapes(1)
.LockAspectRatio = False
.Width = CentimetersToPoints(16.5)
    With .Borders
                 .OutsideColor = wdColorBlack    '그림테두리 검정색
                 .OutsideLineStyle = wdLineStyleSingle    '그림테두리 실선
                 .OutsideLineWidth = wdLineWidth075pt    '그림테두리 두께 0.75pt로 통일
    End With

End With

' 캡션 삽입
With Selection
.InsertCaption Label:="그림", TitleAutoText:="InsertCaption1", _
Title:="", Position:=wdCaptionPositionBelow, ExcludeLabel:=0
.Style = ActiveDocument.Styles("[C1] 본문 그림 캡션")
.HomeKey Unit:=wdLine
.TypeText Text:="["
.EndKey Unit:=wdLine
.TypeText Text:="] 캡션작성"
.MoveUp Unit:=wdLine, Count:=1
.Style = ActiveDocument.Styles("[C1] 본문내용")
End With

End Sub

