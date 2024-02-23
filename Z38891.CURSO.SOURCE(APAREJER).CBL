       IDENTIFICATION DIVISION.
       PROGRAM-ID. APAREJER.
       AUTHOR. TRONCOSO LEANDRO.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

            SELECT SUCURSAL-EN1 ASSIGN TO SUC01
            ORGANIZATION IS SEQUENTIAL
            ACCESS IS SEQUENTIAL
            FILE STATUS IS FS-SUC01.

            SELECT SUCURSAL-EN2 ASSIGN TO SUC02
            ORGANIZATION IS SEQUENTIAL
            ACCESS IS SEQUENTIAL
            FILE STATUS IS FS-SUC02.

            SELECT OBJETIVO-EN ASSIGN TO OBJ
            ORGANIZATION IS SEQUENTIAL
            ACCESS IS SEQUENTIAL
            FILE STATUS IS FS-OBJ.

            SELECT TOTAL-SALIDA ASSIGN TO OUTFILE
            ORGANIZATION IS SEQUENTIAL
            ACCESS IS SEQUENTIAL
            FILE STATUS IS FS-OUTFILE.

       DATA DIVISION.
       FILE SECTION.
       FD SUCURSAL-EN1 RECORDING MODE IS F
                       DATA RECORD IS REG-SUC01.
       01 REG-SUC01.
          05 SUC01-NUMERO         PIC 9(3).
          05 SUC01-DEPTO          PIC X(19).
          05 SUC01-MONTO          PIC 9(6)V99.

       FD SUCURSAL-EN2 RECORDING MODE IS F
                       DATA RECORD IS REG-SUC02.
       01 REG-SUC02.
          05 SUC02-NUMERO         PIC 9(3).
          05 SUC02-DEPTO          PIC X(19).
          05 SUC02-MONTO          PIC 9(6)V99.
       FD OBJETIVO-EN RECORDING MODE IS F
                      DATA RECORD IS REG-OBJ.
       01 REG-OBJ.
          05 OBJ-NUMERO           PIC 9(3).
          05 OBJ-MONTO            PIC 9(7)V99.

       FD TOTAL-SALIDA RECORDING MODE IS F
                       DATA RECORD IS REG-TOTAL.
       01 REG-TOTAL               PIC X(66).

       WORKING-STORAGE SECTION.
       77 FS-SUC01                PIC 99.
          88 FS-SUC01-OK          VALUE 00.
          88 FS-SUC01-FIN         VALUE 10.

       77 FS-SUC02                PIC 99.
          88 FS-SUC02-OK          VALUE 00.
          88 FS-SUC02-FIN         VALUE 10.

       77 FS-OUTFILE              PIC 99.
          88 FS-OUTFILE-OK        VALUE 00.
          88 FS-OUTFILE-FIN       VALUE 10.

       77 FS-OBJ                  PIC 99.
          88 FS-OBJ-OK            VALUE 00.
          88 FS-OBJ-FIN           VALUE 10.

       01 WS-GUIONES.
          05 FILLER               PIC X VALUE SPACES.
          05 FILLER               PIC X(64) VALUE ALL "-".
          05 FILLER               PIC X VALUE SPACES.

       01 WS-TITULO.
          05 FILLER               PIC X VALUE '|'.
          05 FILLER               PIC X(18) VALUE SPACES.
          05 WS-TIT-1             PIC X(28)
                                   VALUE "RESUMEN DE GANANCIAS GENERAL".
          05 FILLER               PIC X(18) VALUE SPACES.
          05 FILLER               PIC X VALUE '|'.

       01 WS-SUBTITULOS.
          05 FILLER               PIC X VALUE "|".
          05 FILLER               PIC X VALUE SPACE.
          05 FILLER               PIC X(12)
                                   VALUE "DEPARTAMENTO".
          05 FILLER               PIC X(10) VALUE SPACES.
          05 FILLER               PIC X(5) VALUE "MONTO".
          05 FILLER               PIC X(14) VALUE SPACES.
          05 FILLER               PIC X(8) VALUE "OBJETIVO".
          05 FILLER               PIC X(14) VALUE SPACES.
          05 FILLER               PIC X VALUE "|".

       01 WS-DETALLE.
          05 FILLER               PIC X VALUE "|".
          05 FILLER               PIC X VALUE SPACE.
          05 WS-DEP-NOMBRE        PIC X(19).
          05 FILLER               PIC X(3) VALUE SPACES.
          05 WS-DEP-MONTO         PIC $$$$$$9,99.
          05 FILLER               PIC X(9) VALUE SPACES.
          05 WS-DEP-OBJETIVO      PIC X(10).
          05 FILLER               PIC X(12) VALUE SPACES.
          05 FILLER               PIC X VALUE "|".

       77 WS-TOTAL-DEPTO          PIC 9(7)V99.

       PROCEDURE DIVISION.

       0100-INIT-PROGRAM.
           PERFORM 0200-OPEN-FILE
           PERFORM 0300-PROCESS-PROGRAM
           PERFORM 0500-CLOSE-FILE
           PERFORM 0600-CLOSE-PROGRAM.

       0200-OPEN-FILE.
           PERFORM 0210-OPEN-SUC01
           PERFORM 0220-OPEN-SUC02
           PERFORM 0230-OPEN-OBJ
           PERFORM 0240-OPEN-OUTFILE.

       0210-OPEN-SUC01.
           OPEN INPUT SUCURSAL-EN1
           IF NOT FS-SUC01-OK THEN
              DISPLAY "FS-SUC01: " FS-SUC01
              PERFORM 0600-CLOSE-PROGRAM
           END-IF.

       0220-OPEN-SUC02.
           OPEN INPUT SUCURSAL-EN2
           IF NOT FS-SUC02-OK THEN
              DISPLAY "FS-SUC02: " FS-SUC02
              PERFORM 0600-CLOSE-PROGRAM
           END-IF.

       0230-OPEN-OBJ.
           OPEN INPUT OBJETIVO-EN
           IF NOT FS-OBJ-OK THEN
              DISPLAY "FS-OBJ: " FS-OBJ
              PERFORM 0600-CLOSE-PROGRAM
           END-IF.

       0240-OPEN-OUTFILE.
           OPEN OUTPUT TOTAL-SALIDA
           IF NOT FS-OUTFILE-OK THEN
              DISPLAY "FS-OUTFILE: " FS-OUTFILE
              PERFORM 0600-CLOSE-PROGRAM
           END-IF.

       0300-PROCESS-PROGRAM.
           INITIALIZE WS-TOTAL-DEPTO
           PERFORM 0310-UPLOAD-TITLE
           PERFORM 0320-READ-SUCURSALES
           PERFORM 0330-COMPARE-TO-DEPTO UNTIL FS-SUC01-FIN
                                         OR    FS-SUC02-FIN
           WRITE REG-TOTAL FROM WS-GUIONES.

       0310-UPLOAD-TITLE.
           WRITE REG-TOTAL FROM WS-GUIONES
           WRITE REG-TOTAL FROM WS-TITULO
           WRITE REG-TOTAL FROM WS-GUIONES
           WRITE REG-TOTAL FROM WS-SUBTITULOS
           WRITE REG-TOTAL FROM WS-GUIONES.

       0320-READ-SUCURSALES.
           READ SUCURSAL-EN1
           READ SUCURSAL-EN2
           READ OBJETIVO-EN.

       0330-COMPARE-TO-DEPTO.
           IF SUC01-NUMERO = SUC02-NUMERO
              ADD SUC01-MONTO TO SUC02-MONTO GIVING WS-TOTAL-DEPTO
              PERFORM 0340-UPLOAD-DETALLES
              PERFORM 0320-READ-SUCURSALES
           ELSE
              IF SUC01-NUMERO > SUC02-NUMERO
                 READ SUCURSAL-EN1
              ELSE
                 READ SUCURSAL-EN2
              END-IF
           END-IF.

       0340-UPLOAD-DETALLES.
           MOVE SUC01-DEPTO TO WS-DEP-NOMBRE
           MOVE WS-TOTAL-DEPTO TO WS-DEP-MONTO
           PERFORM 0400-OBJECTIVE-REACHED
           WRITE REG-TOTAL FROM WS-DETALLE.

       0400-OBJECTIVE-REACHED.
           IF SUC01-NUMERO = OBJ-NUMERO
              IF WS-TOTAL-DEPTO >= OBJ-MONTO
                 MOVE "LOGRADO" TO WS-DEP-OBJETIVO
              ELSE
                 MOVE "NO LOGRADO" TO WS-DEP-OBJETIVO
              END-IF
           ELSE IF SUC01-NUMERO > OBJ-NUMERO
              READ OBJETIVO-EN
           END-IF.

       0500-CLOSE-FILE.
           CLOSE SUCURSAL-EN1
           CLOSE SUCURSAL-EN2
           CLOSE OBJETIVO-EN
           CLOSE TOTAL-SALIDA.

       0600-CLOSE-PROGRAM.
           STOP RUN.
