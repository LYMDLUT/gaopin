// DemoForDSADlg.cpp : implementation file
//

#include "stdafx.h"
#include "DemoForDSA.h"
#include "DemoForDSADlg.h"
#include "visa.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#define MAX_REC_SIZE 200

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDemoForDSADlg dialog

CDemoForDSADlg::CDemoForDSADlg(CWnd* pParent /*=NULL*/)
	: CDialog(CDemoForDSADlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDemoForDSADlg)
	m_strInstrAddr = _T("");
	m_strResult = _T("");
	m_strCommand = _T("");
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CDemoForDSADlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDemoForDSADlg)
	DDX_Text(pDX, IDC_EDIT_INSTR_ADDR, m_strInstrAddr);
	DDX_Text(pDX, IDC_EDIT_RESULT, m_strResult);
	DDX_Text(pDX, IDC_EDIT_COMMAND, m_strCommand);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CDemoForDSADlg, CDialog)
	//{{AFX_MSG_MAP(CDemoForDSADlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BT_CONNECT, OnBtConnectInstr)
	ON_BN_CLICKED(IDC_BT_WRITE, OnBtWrite)
	ON_BN_CLICKED(IDC_BT_READ, OnBtRead)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDemoForDSADlg message handlers

BOOL CDemoForDSADlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	m_strCommand = "*IDN?";
	UpdateData(false);

	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CDemoForDSADlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CDemoForDSADlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CDemoForDSADlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CDemoForDSADlg::OnBtConnectInstr()		//Connect to the instrument
{
	// TODO: Add your control notification handler code here
	ViStatus status;
	ViSession defaultRM;
	ViString expr = "?*";
	ViPFindList findList = new unsigned long;
	ViPUInt32 retcnt = new unsigned long;
	ViChar instrDesc[1000];
	CString strSrc = "";
	CString strInstr = "";
	unsigned long i = 0;
	bool bFindDSA = false;

	status = viOpenDefaultRM(&defaultRM);
	if (status < VI_SUCCESS)
	{ 
		// Error Initializing VISA...exiting 
		MessageBox("No VISA instrument was opened !");
		return ;
	}	

	memset(instrDesc,0,1000);

	//Find resource
	status = viFindRsrc(defaultRM,expr,findList, retcnt, instrDesc);	

	for (i = 0;i < (*retcnt);i++)
	{
		//Get instrument name
		strSrc.Format("%s",instrDesc);
		InstrWrite(strSrc,"*IDN?");
		::Sleep(200);
		InstrRead(strSrc,&strInstr);

		//If the instrument(resource) belongs to the DSA series then jump out from the loop
		strInstr.MakeUpper();
		if (strInstr.Find("DSA") >= 0)
		{
			bFindDSA = true;
			m_strInstrAddr = strSrc;
			break;
		}

		//Find next resource
		status =  viFindNext(*findList,instrDesc);		
	}
	
	if (bFindDSA == false)
	{
		MessageBox("Didn't find any DSA!");
	}
	UpdateData(false);	
}

void CDemoForDSADlg::OnBtWrite()			//write operation
{
	// TODO: Add your control notification handler code here
	UpdateData(true);
	if (m_strInstrAddr.IsEmpty())
	{
		MessageBox("Please connect the instrument first!");
	}
	InstrWrite(m_strInstrAddr,m_strCommand);
	m_strResult.Empty();
	UpdateData(false);	
}

void CDemoForDSADlg::OnBtRead()				//read operation
{
	// TODO: Add your control notification handler code here
	UpdateData(true);
	InstrRead(m_strInstrAddr,&m_strResult);
	UpdateData(false);	
}

bool CDemoForDSADlg::InstrWrite(CString strAddr, CString strContent)	//write function
{
	ViSession defaultRM,instr;
	ViStatus status;
	ViUInt32 retCount;
	char * SendBuf = NULL;
	char * SendAddr = NULL;
	bool bWriteOK = false;
	CString str;

	//Change the address's data style from CString to char*
	SendAddr = strAddr.GetBuffer(strAddr.GetLength());
	strcpy(SendAddr,strAddr);
	strAddr.ReleaseBuffer();

	//Change the command's data style from CString to char*
	SendBuf = strContent.GetBuffer(strContent.GetLength());
	strcpy(SendBuf,strContent);
	strContent.ReleaseBuffer();

	//open the VISA instrument
	status = viOpenDefaultRM(&defaultRM);
	if (status < VI_SUCCESS)
	{ 
		AfxMessageBox("No VISA instrument was opened !");
		return false;
	}

	status = viOpen(defaultRM, SendAddr, VI_NULL, VI_NULL, &instr);

	//write command to the instrument
	status = viWrite(instr, (unsigned char *)SendBuf, strlen(SendBuf), &retCount);

	//close the instrument
	status = viClose(instr);
	status = viClose(defaultRM);

	return bWriteOK;
}

bool CDemoForDSADlg::InstrRead(CString strAddr, CString *pstrResult)	//Read from the instrument
{
	ViSession defaultRM,instr;
	ViStatus status;
	ViUInt32 retCount;
	char * SendAddr = NULL;
	unsigned char RecBuf[MAX_REC_SIZE];
	bool bReadOK = false;
	CString str;

	//Change the address's data style from CString to char*
	SendAddr = strAddr.GetBuffer(strAddr.GetLength());
	strcpy(SendAddr,strAddr);
	strAddr.ReleaseBuffer();

	memset(RecBuf,0,MAX_REC_SIZE);

	//open the VISA instrument
	status = viOpenDefaultRM(&defaultRM);
	if (status < VI_SUCCESS)
	{ 
		// Error Initializing VISA...exiting 
		AfxMessageBox("No VISA instrument was opened !");
		return false;
	}

	//open the instrument
	status = viOpen(defaultRM, SendAddr, VI_NULL, VI_NULL, &instr);

	//read from the instrument
	status = viRead(instr, RecBuf, MAX_REC_SIZE, &retCount);

	//close the instrument
	status = viClose(instr);
	status = viClose(defaultRM);

	(*pstrResult).Format("%s",RecBuf);

	return bReadOK;
}
