// DemoForDSA.h : main header file for the DEMOFORDSA application
//

#if !defined(AFX_DEMOFORDSA_H__A0AA38BE_33F0_4A53_A60C_332F35537D25__INCLUDED_)
#define AFX_DEMOFORDSA_H__A0AA38BE_33F0_4A53_A60C_332F35537D25__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CDemoForDSAApp:
// See DemoForDSA.cpp for the implementation of this class
//

class CDemoForDSAApp : public CWinApp
{
public:
	CDemoForDSAApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDemoForDSAApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CDemoForDSAApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DEMOFORDSA_H__A0AA38BE_33F0_4A53_A60C_332F35537D25__INCLUDED_)
