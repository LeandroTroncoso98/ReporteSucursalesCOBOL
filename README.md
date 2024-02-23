# ReporteSucursalesCOBOL
La empresa cuenta con dos sucursales y busca verificar si la suma de las ganancias mensuales entre ambas supera los objetivos establecidos.
Cada sucursal guarda informes con las ganancias generales por departamento (por ejemplo: Bazar, Limpieza).

Deberás desarrollar un programa que sume los montos del mismo departamento en ambas sucursales, 
analice si se alcanza el objetivo fijado por auditoría y presente un informe. 
Los datos de los archivos SUC-01 y SUC-02 se estructuran de la siguiente manera:

Los datos de los archivos son SUC-01:
001TEXTIL             00056423
002CARNICERIA         34568963
003BAZAR              12698785
004ELECTRO            26589786
Los primeros 3 digitos son el numero de departamento.
Los proximos 19 digitos seran el nombre del departamento.
Los ultimos 8 digitos seran el monto ganado por departamento. (Formato: 000000.00)

Los datos de los archivos son SUC-02:
001TEXTIL             07956325
002CARNICERIA         14596982
003BAZAR              08654987
004ELECTRO            34598792
Los primeros 3 digitos son el numero de departamento.
Los proximos 19 digitos seran el nombre del departamento.
Los ultimos 8 digitos seran el monto ganado por departamento. (Formato: 000000.00)


Los objetivos dados por los auditores: 
001015356423
002134568963
003012698785
004226589786
Las primeros 3 digitos son el numero de departamento 
El resto el valor objetivo que deben alcanzar.
(Formato: $0000000.00)

El formato del reporte debera estar presentado de la siguiente forma:

 ----------------------------------------------------------------
|                 RESUMEN DE GANANCIAS GENERALES                 |
 ----------------------------------------------------------------
| DEPARTAMENTO          MONTO              OBJETIVO              |
 ----------------------------------------------------------------
| XXXXXXXXXXXXXXXXXXX   $XXXXXX.XX         NO LOGRADO            | 
| XXXXXXXXXXXXXXXXXXX   $XXXXXX.XX         LOGRADO               |
 ----------------------------------------------------------------                          
