#!/bin/perl
$latex         = 'platex -synctex=1 -halt-on-error %O %S';
$bibtex        = 'pbibtex %O %B';
$dvipdf        = 'dvipdfmx %O %S';
$pdf_mode      = 3;
$pdf_previewer = "start okular";
$pdf_update_method = 0;
