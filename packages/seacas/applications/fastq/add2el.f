C    Copyright(C) 1999-2020 National Technology & Engineering Solutions
C    of Sandia, LLC (NTESS).  Under the terms of Contract DE-NA0003525 with
C    NTESS, the U.S. Government retains certain rights in this software.
C    
C    See packages/seacas/LICENSE for details

C $Id: add2el.f,v 1.1 1990/11/30 11:02:44 gdsjaar Exp $
C $Log: add2el.f,v $
C Revision 1.1  1990/11/30 11:02:44  gdsjaar
C Initial revision
C
C
CC* FILE: [.PAVING]ADD2EL.FOR
CC* MODIFIED BY: TED BLACKER
CC* MODIFICATION DATE: 7/6/90
CC* MODIFICATION: COMPLETED HEADER INFORMATION
C
      SUBROUTINE ADD2EL (MXND, MLN, XN, YN, NUID, LXK, KXL, NXL, LXN,
     &   ANGLE, LNODES, NNN, KKK, LLL, NNNOLD, LLLOLD, NLOOP, I1, I4,
     &   IAVAIL, NAVAIL, GRAPH, VIDEO, NOROOM, ERR)
C***********************************************************************
C
C  SUBROUTINE ADD2EL = CLOSES A SIX SIDED REGION BY FORMING 2 ELEMENTS
C
C***********************************************************************
C
      DIMENSION XN (MXND), YN (MXND), NUID (MXND)
      DIMENSION LXK (4, MXND), KXL (2, 3*MXND)
      DIMENSION NXL (2, 3*MXND), LXN (4, MXND)
      DIMENSION ANGLE (MXND), LNODES (MLN, MXND)
C
      LOGICAL GRAPH, VIDEO, ERR, NOROOM
C
      ERR = .FALSE.
C
      I2 = LNODES (3, I1)
      I3 = LNODES (3, I2)
      I5 = LNODES (3, I4)
      I6 = LNODES (3, I5)
C
      CALL CONNOD (MXND, MLN, XN, YN, NUID, LXK, KXL, NXL, LXN, ANGLE,
     &   LNODES, NNN, KKK, LLL, NNNOLD, LLLOLD, I1, I2, I3, I4, IDUM,
     &   NLOOP, IAVAIL, NAVAIL, GRAPH, VIDEO, NOROOM, ERR)
      IF ((NOROOM) .OR. (ERR)) GOTO 100
      CALL CLOSE4 (MXND, MLN, LXK, KXL, NXL, LXN, LNODES,
     &   I1, I4, I5, I6, KKK, ERR)
C
  100 CONTINUE
C
      RETURN
C
      END
