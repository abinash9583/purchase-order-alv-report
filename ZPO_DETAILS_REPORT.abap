
*Declare Types
TYPES: BEGIN OF ty_po,
         ebeln TYPE ekko-ebeln,
         bukrs TYPE ekko-bukrs,
         bsart TYPE ekko-bsart,
         lifnr TYPE ekko-lifnr,
         bedat TYPE ekko-bedat,
         ebelp TYPE ekpo-ebelp,
         matnr TYPE ekpo-matnr,
         menge TYPE ekpo-menge,
         netpr TYPE ekpo-netpr,
         werks TYPE ekpo-werks,
       END OF ty_po.


*Declare Internal Table & Work Area
DATA: gt_po TYPE STANDARD TABLE OF ty_po,
      gs_po TYPE ty_po.


*Fetch Data Using Open SQL JOIN
SELECT
  a~ebeln
  a~bukrs
  a~bsart
  a~lifnr
  a~bedat
  b~ebelp
  b~matnr
  b~menge
  b~netpr
  b~werks
FROM ekko AS a
INNER JOIN ekpo AS b
ON a~ebeln = b~ebeln
INTO TABLE gt_po
UP TO 100 ROWS.


*Validate Data
IF gt_po IS INITIAL.
  MESSAGE 'No Purchase Orders Found' TYPE 'I'.
  EXIT.
ENDIF.


*Simple ALV Display
DATA: gr_alv TYPE REF TO cl_salv_table.

cl_salv_table=>factory(
  IMPORTING
    r_salv_table = gr_alv
  CHANGING
    t_table      = gt_po
).

gr_alv->display( ).
