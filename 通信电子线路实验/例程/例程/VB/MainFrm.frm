VERSION 5.00
Begin VB.Form MainFrm 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "DemoForDSA"
   ClientHeight    =   3750
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   8760
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   250
   ScaleMode       =   0  'User
   ScaleWidth      =   373
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame2 
      Height          =   3375
      Left            =   6720
      TabIndex        =   1
      Top             =   120
      Width           =   1815
      Begin VB.CommandButton CmdConnect 
         Caption         =   "Connect"
         Height          =   375
         Left            =   360
         TabIndex        =   11
         Top             =   360
         Width           =   1095
      End
      Begin VB.CommandButton CmdExit 
         Caption         =   "Exit"
         Height          =   375
         Left            =   360
         TabIndex        =   10
         Top             =   2280
         Width           =   1095
      End
      Begin VB.CommandButton CmdRead 
         Caption         =   "Read"
         Height          =   375
         Left            =   360
         TabIndex        =   9
         Top             =   1680
         Width           =   1095
      End
      Begin VB.CommandButton CmdWrite 
         Caption         =   "Write"
         Height          =   375
         Left            =   360
         TabIndex        =   8
         Top             =   960
         Width           =   1095
      End
   End
   Begin VB.Frame Frame1 
      Height          =   3375
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   6255
      Begin VB.TextBox TxtReturn 
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   1095
         Left            =   1080
         TabIndex        =   7
         Top             =   2040
         Width           =   4935
      End
      Begin VB.TextBox TxtCommand 
         Height          =   405
         Left            =   1080
         TabIndex        =   6
         Top             =   1080
         Width           =   4935
      End
      Begin VB.TextBox TxtInsAddr 
         Height          =   405
         Left            =   1080
         TabIndex        =   5
         Top             =   240
         Width           =   4935
      End
      Begin VB.Label LblReturn 
         Caption         =   "Return"
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Top             =   2160
         Width           =   855
      End
      Begin VB.Label LblCommand 
         Caption         =   "Command"
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   1200
         Width           =   855
      End
      Begin VB.Label LblInstrumentAddr 
         Caption         =   "Address"
         Height          =   255
         Left            =   120
         TabIndex        =   2
         Top             =   360
         Width           =   855
      End
   End
End
Attribute VB_Name = "MainFrm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


' Connect to the instrument
Private Sub CmdConnect_Click()
    Const MAX_CNT = 200
    Dim status As Long
    Dim dfltRM As Long
    Dim sesn As Long
    Dim fList As Long
    Dim buffer As String * MAX_CNT, Desc As String * 256
    Dim nList As Long, retCount As Long
    Dim rsrcName(19) As String * VI_FIND_BUFLEN, instrDesc As String * VI_FIND_BUFLEN
    Dim i, j As Long
    Dim strRet As String
    Dim strSrc As String
    Dim bFindDSA As Boolean
        
    'Open the VISA instrument
    status = viOpenDefaultRM(dfltRM)
    'Failed to open the instrument
    If (status < VI_SUCCESS) Then
        MsgBox "No VISA resource was opened £¡"
        Exit Sub
    End If
    
    'Find instrument resource
    Call viFindRsrc(dfltRM, "?*", fList, nList, rsrcName(0))
    'Get the list of the instrument(resource)
    strRet = ""
    bFindDSA = False
    For i = 0 To nList - 1
        'Get the instrument name
        InstrWrite rsrcName(i), "*IDN?"
        Sleep 200
        strRet = InstrRead(rsrcName(i))
        strSrc = rsrcName(i)
        'Continue to switch the resource until find a DSA instrument
        strRet = UCase(strRet)
        j = InStr(strRet, "DSA")
        If (j >= 0) Then
            bFindDSA = True
            Exit For
        End If
                
        Call viFindNext(fList + i - 1, rsrcName(i))
    Next i
    
    If (bFindDSA = True) Then
        TxtInsAddr.Text = strSrc
    Else
        TxtInsAddr.Text = ""
    End If
    
End Sub

'Exit the program
Private Sub CmdExit_Click()
    Unload Me
End Sub

'Read the return value from the instrument
Private Sub CmdRead_Click()
    Dim strTemp As String
    strTemp = InstrRead(TxtInsAddr.Text)
    TxtReturn.Text = strTemp
End Sub

'Write the command to the instrument
Private Sub CmdWrite_Click()
    If (TxtInsAddr.Text = "") Then
        MsgBox ("Please write the instrument address£¡")
    End If
    
    InstrWrite TxtInsAddr.Text, TxtCommand.Text
End Sub

'-----------------------------------------------------------
'Function Name£ºInstrWrite
'Function£º  Send command to the instrument
'Input£º  rsrcName,instrument(resource) name    strCmd,Command
'-----------------------------------------------------------
Public Sub InstrWrite(rsrcName As String, strCmd As String)
    Dim status As Long
    Dim dfltRM As Long
    Dim sesn As Long
    Dim rSize As Long
    
    'Initialize the system
    status = viOpenDefaultRM(dfltRM)
    'Failed to Initialize the system
    If (status < VI_SUCCESS) Then
        MsgBox "No VISA resource was opened£¡"
        Exit Sub
    End If
    'Open the VISA instrument
    status = viOpen(dfltRM, rsrcName, VI_NULL, VI_NULL, sesn)
    'Failed to open the instrument
    If (status < VI_SUCCESS) Then
        MsgBox "Failed to open the instrument£¡"
        Exit Sub
    End If
    
    'Write command to the instrument
    status = viWrite(sesn, strCmd, Len(strCmd), rSize)
    'Failed to write to the instrument
    If (status < VI_SUCCESS) Then
        MsgBox "Faild to write to the instrument£¡"
        Exit Sub
    End If
    
    'Close the session
    status = viClose(sesn)
    
    status = viClose(dfltRM)

End Sub

'-----------------------------------------------------------
'Function Name£ºInstrRead
'Function£º  Read the return value from the instrument
'Input£º  rsrcName,Resource name
'Return£ºThe string gotten from the instrument
'-----------------------------------------------------------
Public Function InstrRead(rsrcName As String) As String
    Dim status As Long
    Dim dfltRM As Long
    Dim sesn As Long
    Dim strTemp0 As String * 256
    Dim strTemp1 As String
    Dim rSize As Long
        
    'Begin by initializing the system
    status = viOpenDefaultRM(dfltRM)
    'Initialize failed
    If (status < VI_SUCCESS) Then
        MsgBox "No VISA instrument was opened!"
        Exit Function
    End If
    'Open the instrument
    status = viOpen(dfltRM, rsrcName, VI_NULL, VI_NULL, sesn)
    'Open instrument failed
    If (status < VI_SUCCESS) Then
         MsgBox "Failed to open the instrument!"
         Exit Function
    End If
    
    'Read from the instrument
    stasus = viRead(sesn, strTemp0, 256, rSize)
    'Read failed
    If (status < VI_SUCCESS) Then
        MsgBox "Failed to read from the instrument!"
        Exit Function
    End If
    
    'Close the system
    status = viClose(sesn)
    
    status = viClose(dfltRM)
    
    'Remove the space at the end of the string
    strTemp1 = Left(strTemp0, rSize)
    InstrRead = strTemp1
End Function


