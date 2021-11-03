Sub set_image_width_board()
With Selection.InlineShapes(1) ' 가로 종횡비 고정 x
.LockAspectRatio = False
.Width = CentimetersToPoints(16.5)
With .Borders
.OutsideColor = wdColorBlack '그림테두리 검정색
.OutsideLineStyle = wdLineStyleSingle '그림테두리 실선
.OutsideLineWidth = wdLineWidth075pt '그림테두리 두께 0.75pt로 통일
End With
End With
End Sub

 Sub all_set_image_width_board()
 For i = 1 To ActiveDocument.InlineShapes.Count 'for 문으로 1번째 그림부터 마지막 그림까지
 With ActiveDocument.InlineShapes(i)
 .Width = CentimetersToPoints(16.5) ' 그림너비 16.5cm로 통일
 With .Borders
 .OutsideColor = wdColorBlack '그림테두리 검정색
 .OutsideLineStyle = wdLineStyleSingle '그림테두리 실선
 .OutsideLineWidth = wdLineWidth075pt '그림테두리 두께 0.75pt로 통일
 End With
 End With
 Next
 End Sub
