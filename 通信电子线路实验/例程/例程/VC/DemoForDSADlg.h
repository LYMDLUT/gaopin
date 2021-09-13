// DemoForDSADlg.h : header file
//

#if !defined(AFX_DEMOFORDSADLG_H__642F9BCD_5314_4F99_81D5_B3E99FF50AF1__INCLUDED_)
#define AFX_DEMOFORDSADLG_H__642F9BCD_5314_4F99_81D5_B3E99FF50AF1__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CDemoForDSADlg dialog

class CDemoForDSADlg : public CDialog
{
// Construction
public:
	bool InstrRead(CString strAddr, CString *pstrResult);
	bool InstrWrite(CString strAddr, CString strContent);
	CDemoForDSADlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CDemoForDSADlg)
	enum { IDD = IDD_DEMOFORDSA_DIALOG };
	CString	m_strInstrAddr;
	CString	m_strResult;
	CString	m_strCommand;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDemoForDSADlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CDemoForDSADlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnBtConnectInstr();
	afx_msg void OnBtWrite();
	afx_msg void OnBtRead();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DEMOFORDSADLG_H__642F9BCD_5314_4F99_81D5_B3E99FF50AF1__INCLUDED_)
